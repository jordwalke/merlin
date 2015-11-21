(* {{{ COPYING *(

  This file is part of Merlin, an helper for ocaml editors

  Copyright (C) 2013 - 2015  Frédéric Bour  <frederic.bour(_)lakaban.net>
                             Thomas Refis  <refis.thomas(_)gmail.com>
                             Simon Castellan  <simon.castellan(_)iuwt.fr>

  Permission is hereby granted, free of charge, to any person obtaining a
  copy of this software and associated documentation files (the "Software"),
  to deal in the Software without restriction, including without limitation the
  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
  sell copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  The Software is provided "as is", without warranty of any kind, express or
  implied, including but not limited to the warranties of merchantability,
  fitness for a particular purpose and noninfringement. In no event shall
  the authors or copyright holders be liable for any claim, damages or other
  liability, whether in an action of contract, tort or otherwise, arising
  from, out of or in connection with the software or the use or other dealings
  in the Software.

)* }}} *)

open Std
open Logger

let latest_version : Protocol.protocol_version = `V2
let current_version = ref latest_version

type io = Protocol.request Stream.t * (Protocol.response -> unit)
type low_io = Json.json Stream.t * (Json.json -> unit)
type io_maker =
  on_read:(Unix.file_descr -> unit) -> input:Unix.file_descr ->
  output:Unix.file_descr ->
  low_io

let invalid_arguments () = failwith "invalid arguments"

let json_log (input,output) =
  let log_input json =
    Logger.logj "frontend" "input" (fun () -> json);
    json
  in
  let log_output json =
    Logger.logj "frontend" "output" (fun () -> json);
    json
  in
  let input' = Stream.map ~f:log_input input in
  let output' json = output (log_output json) in
  input', output'

let json_make ~on_read ~input ~output =
  let rec read buf len =
    on_read input;
    try Unix.read input buf 0 len
    with Unix.Unix_error (Unix.EINTR,_,_) ->
      read buf len
  in
  let lexbuf = Lexing.from_function read in
  let input = Json.stream_from_lexbuf (Json.init_lexer ()) lexbuf in
  let output = Unix.out_channel_of_descr output in
  let output' = Json.to_channel output in
  let output json =
    output' json;
    output_char output '\n';
    flush output
  in
  input, output

let makers = ref ["json", ("(default) simple JSON-based protocol", json_make)]

let register_protocol ~name ~desc inst =
  makers := (name, (desc,inst)) :: !makers

let make' = ref json_make
let make ~on_read ~input ~output =
  json_log (!make' ~on_read ~input ~output)

let select_frontend name =
  try make' := snd (List.assoc name !makers)
  with Not_found ->
    if name <> "help" then
      prerr_endline
        ("Unknown protocol '" ^ name ^ "' (maybe check build configuration)\n");
    prerr_endline "Choose protocol to use for communication. Known protocols:";
    List.iter (fun (name, (desc, _)) ->
        prerr_endline (name ^ "\t" ^ desc))
      !makers;
    exit 1

module Protocol_io = struct
  exception Failure' = Failure
  open Protocol

  let with_location ?(skip_none=false) loc assoc =
    if skip_none && loc = Location.none then
      `Assoc assoc
    else
      `Assoc (("start", Lexing.json_of_position loc.Location.loc_start) ::
              ("end",   Lexing.json_of_position loc.Location.loc_end) ::
              assoc)

  let json_of_error {Error_report. valid; text; where; sub; loc} =
    let of_sub (msg,loc) = with_location ~skip_none:true loc ["message", `String msg] in
    let content = [
      "type"    , `String where;
      "sub"     , `List (List.map ~f:of_sub sub);
      "valid"   , `Bool valid;
      "message" , `String text;
    ] in
    with_location ~skip_none:true loc content

  let error_catcher exn =
    match Error_report.error_catcher exn with
    | None -> None
    | Some (loc,t) -> Some (loc, json_of_error t)

  let make_pos (pos_lnum, pos_cnum) =
    Lexing.({ pos_fname = "" ; pos_lnum ; pos_cnum ; pos_bol = 0 })

  let pos_of_json = function
    | `Assoc props ->
      begin try match List.assoc "line" props, List.assoc "col" props with
        | `Int line, `Int col -> make_pos (line,col)
        | _ -> failwith "Incorrect position"
      with Not_found -> failwith "Incorrect position"
      end
    | _ -> failwith "Incorrect position"

  let optional_position = function
    | [`String "at"; jpos] -> Some (pos_of_json jpos)
    | [] -> None
    | _ -> invalid_arguments ()

  let mandatory_position = function
    | [`String "at"; jpos] -> pos_of_json jpos
    | _ -> invalid_arguments ()

  let optional_string = function
    | [`String name] -> Some name
    | [] -> None
    | _ -> invalid_arguments ()

  let string_list l =
    List.map (function `String s -> s | _ -> invalid_arguments ()) l

  let json_of_string_list l =
    `List (List.map (fun s -> `String s) l)

  let json_of_type_loc (loc,str,tail) =
    with_location loc [
      "type", `String str;
      "tail", `String (match tail with
          | `No -> "no"
          | `Tail_position -> "position"
          | `Tail_call -> "call")
    ]

  let string_of_kind = function
    | `Value       -> "Value"
    | `Variant     -> "Variant"
    | `Constructor -> "Constructor"
    | `Label       -> "Label"
    | `Module      -> "Module"
    | `Modtype     -> "Signature"
    | `Type        -> "Type"
    | `Method      -> "Method"
    | `MethodCall  -> "#"
    | `Exn         -> "Exn"
    | `Class       -> "Class"

  let json_of_completion {Compl. name; kind; desc; info} =
    `Assoc ["name", `String name;
            "kind", `String (string_of_kind kind);
            "desc", `String desc;
            "info", `String info]

  let json_of_completions {Compl. entries; context } =
    `Assoc [
      "entries", `List (List.map json_of_completion entries);
      "context", (match context with
          | `Unknown -> `Null
          | `Application {Compl. argument_type; labels} ->
            let label (name,ty) = `Assoc ["name", `String name;
                                          "type", `String ty] in
            let a = `Assoc ["argument_type", `String argument_type;
                            "labels", `List (List.map label labels)] in
            `List [`String "application"; a])
    ]

  let rec json_of_outline outline =
    let json_of_item { outline_name ; outline_kind ; location ; children } =
      with_location location [
        "name", `String outline_name;
        "kind", `String (string_of_kind outline_kind);
        "children", `List (json_of_outline children);
      ]
    in
    List.map json_of_item outline

  let rec json_of_shape { shape_loc; shape_sub } =
    with_location shape_loc [
      "children", `List (List.map ~f:json_of_shape shape_sub);
    ]

  let json_of_cursor_state {cursor} =
    `Assoc [ "cursor", Lexing.json_of_position cursor ]

  let source_or_build = function
    | "source" -> `Source
    | "build"  -> `Build
    | _ -> invalid_arguments ()

  let ml_or_mli = function
    | "ml" -> `ML
    | "mli"  -> `MLI
    | _ -> invalid_arguments ()

  let auto_ml_or_mli = function
    | "auto" -> `Auto
    | x -> ml_or_mli x

  let add_or_remove = function
    | "add"    -> `Add
    | "remove" -> `Rem
    | _ -> invalid_arguments ()

  let load_or_find = function
    | "load" -> `File
    | "find" -> `Find
    | _ -> invalid_arguments ()

  let with_failures assoc = function
    | `Ok -> assoc
    | `Failures failures ->
      let packages, flags, extensions =
        List.fold_left failures ~init:([],[],[]) ~f:(
          fun (pkgs, flgs, exts) (str,exn) ->
            let str = "\"" ^ str ^ "\"" in
            match exn with
            | Fl_package_base.No_such_package _ -> str :: pkgs, flgs, exts
            | Arg.Bad _ -> pkgs, str :: flgs, exts
            | Extension.Unknown -> pkgs, flgs, str :: exts
            | e -> (str ^ " (" ^ Printexc.to_string e ^ ")") :: pkgs, flgs, exts
        )
      in
      let packages =
        match packages with
        | [] -> []
        | failures ->
          let str = String.concat ~sep:", " failures in
          [ `String ("Failed to load some packages " ^ str) ]
      in
      let flags =
        match flags with
        | [] -> []
        | failures ->
          let str = String.concat ~sep:", " failures in
          [ `String ("Unknown flags " ^ str) ]
      in
      let extensions =
        match extensions with
        | [] -> []
        | failures ->
          let str = String.concat ~sep:", " failures in
          [ `String ("Unknown extensions " ^ str) ]
      in
      ("failures", `List (packages @ flags @ extensions)) :: assoc

  let context_of_json = function
    | (`String "dot_merlin" :: `List dot_merlins :: `String kind :: opt_name) ->
      auto_ml_or_mli kind, optional_string opt_name, Some (string_list dot_merlins)
    | (`String kind :: opt_name) ->
      auto_ml_or_mli kind, optional_string opt_name, None
    | _ -> invalid_arguments ()

  let request_of_json = function
    | (`String "tell" :: `String "start" :: opt_pos) ->
      Request (Sync (Tell (`Start (optional_position opt_pos))))
    | [`String "tell"; `String "source"; `String source] ->
      Request (Sync (Tell (`Source source)))
    | [`String "tell"; `String "source-eof"; `String source] ->
      Request (Sync (Tell (`Source_eof source)))
    | [`String "tell"; `String "file"; `String path] ->
      Request (Sync (Tell (`File path)))
    | [`String "tell"; `String "file-eof"; `String path] ->
      Request (Sync (Tell (`File_eof path)))
    | [`String "tell"; `String "eof"] ->
      Request (Sync (Tell `Eof))
    | (`String "type" :: `String "expression" :: `String expr :: opt_pos) ->
      Request (Query (Type_expr (expr, optional_position opt_pos)))
    | [`String "type"; `String "enclosing";
        `Assoc [ "expr", `String expr ; "offset", `Int offset] ; jpos] ->
      Request (Query (Type_enclosing (Some (expr, offset), pos_of_json jpos)))
    | [`String "type"; `String "enclosing"; `String "at"; jpos] ->
      Request (Query (Type_enclosing (None, pos_of_json jpos)))
    | [ `String "case"; `String "analysis"; `String "from"; x; `String "to"; y ] ->
      let loc_start = pos_of_json x in
      let loc_end = pos_of_json y in
      let loc_ghost = true in
      Request (Query (Case_analysis ({ Location. loc_start ; loc_end ; loc_ghost })))
    | [`String "enclosing"; jpos] ->
      Request (Query (Enclosing (pos_of_json jpos)))
    | [`String "complete"; `String "prefix"; `String prefix; `String "at"; jpos] ->
      Request (Query (Complete_prefix (prefix, pos_of_json jpos, false)))
    | [`String "complete"; `String "prefix"; `String prefix; `String "at"; jpos;
       `String "with"; `String "doc"] ->
      Request (Query (Complete_prefix (prefix, pos_of_json jpos, true)))
    | [`String "expand"; `String "prefix"; `String prefix; `String "at"; jpos] ->
      Request (Query (Expand_prefix (prefix, pos_of_json jpos)))
    | (`String "document" :: (`String "" | `Null) :: pos) ->
      Request (Query (Document (None, mandatory_position pos)))
    | (`String "document" :: `String path :: pos) ->
      Request (Query (Document (Some path, mandatory_position pos)))
    | (`String "locate" :: (`String "" | `Null) :: `String choice :: pos) ->
      Request (Query (Locate (None, ml_or_mli choice, mandatory_position pos)))
    | (`String "locate" :: `String path :: `String choice :: pos) ->
      Request (Query (Locate (Some path, ml_or_mli choice, mandatory_position pos)))
    | (`String "jump" :: `String target :: pos) ->
      Request (Query (Jump (target, mandatory_position pos)))
    | [`String "outline"] ->
      Request (Query Outline)
    | [`String "shape"; pos] ->
      Request (Query (Shape (pos_of_json pos)))
    | [`String "drop"] ->
      Request (Sync Drop)
    | [`String "seek"; `String "position"] ->
      Request (Sync (Seek `Position))
    | [`String "occurrences"; `String "ident"; `String "at"; jpos] ->
      Request (Query (Occurrences (`Ident_at (pos_of_json jpos))))
    | [`String "seek"; `String "before"; jpos] ->
      Request (Sync (Seek (`Before (pos_of_json jpos))))
    | [`String "seek"; `String "exact"; jpos] ->
      Request (Sync (Seek (`Exact (pos_of_json jpos))))
    | [`String "seek"; `String "end"] ->
      Request (Sync (Seek `End))
    | (`String ("reset"|"checkout") :: context) ->
      Request (Sync (Checkout (context_of_json context)))
    | [`String "refresh"] ->
      Request (Sync Refresh)
    | [`String "errors"] ->
      Request (Query Errors)
    | (`String "dump" :: args) ->
      Request (Query (Dump args))
    | [`String "which"; `String "path"; `String name] ->
      Request (Query (Which_path [name]))
    | [`String "which"; `String "path"; `List names] ->
      Request (Query (Which_path (string_list names)))
    | [`String "which"; `String "with_ext"; `String ext] ->
      Request (Query (Which_with_ext [ext]))
    | [`String "which"; `String "with_ext"; `List exts] ->
      Request (Query (Which_with_ext (string_list exts)))
    | [`String "flags" ; `String "set" ; `List flags ] ->
      Request (Sync (Flags_set (string_list flags)))
    | [`String "flags" ; `String "get" ] ->
      Request (Query (Flags_get))
    | [`String "find"; `String "use"; `List packages]
    | (`String "find" :: `String "use" :: packages) ->
      Request (Sync (Findlib_use (string_list packages)))
    | [`String "find"; `String "list"] ->
      Request (Query Findlib_list)
    | [`String "extension"; `String "enable"; `List extensions] ->
      Request (Sync (Extension_set (`Enabled,string_list extensions)))
    | [`String "extension"; `String "disable"; `List extensions] ->
      Request (Sync (Extension_set (`Disabled,string_list extensions)))
    | [`String "extension"; `String "list"] ->
      Request (Query (Extension_list `All))
    | [`String "extension"; `String "list"; `String "enabled"] ->
      Request (Query (Extension_list `Enabled))
    | [`String "extension"; `String "list"; `String "disabled"] ->
      Request (Query (Extension_list `Disabled))
    | [`String "path"; `String "list";
                       `String ("source"|"build" as var)] ->
      Request (Query (Path_list (source_or_build var)))
    | [`String "path"; `String "reset"] ->
      Request (Sync Path_reset)
    | (`String "path" :: `String ("add"|"remove" as action) ::
         `String ("source"|"build" as var) :: ((`List pathes :: []) | pathes)) ->
      Request (Sync (Path (source_or_build var, add_or_remove action, string_list pathes)))
    | [`String "project"; `String "get"] ->
      Request (Query Project_get)
    | [`String "version"] ->
      Request (Query Version)
    | [`String "protocol"; `String "version"] ->
      Request (Sync (Protocol_version None))
    | [`String "protocol"; `String "version"; `Int n] ->
      Request (Sync (Protocol_version (Some n)))
    | _ -> invalid_arguments ()

  let json_of_protocol_version : Protocol.protocol_version -> _ = function
    | `V2 -> `Int 2

  let json_of_query_command (type a) (command : a query_command) (response : a) : json =
    match command, response with
    | Type_expr _, str -> `String str
    | Type_enclosing _, results ->
      `List (List.map json_of_type_loc results)
    | Enclosing _, results ->
      `List (List.map (fun loc -> with_location loc []) results)
    | Complete_prefix _, compl ->
      json_of_completions compl
    | Expand_prefix _, compl ->
      json_of_completions compl
    | Document _, resp ->
      begin match resp with
        | `No_documentation -> `String "No documentation available"
        | `Invalid_context -> `String "Not a valid identifier"
        | `Not_found (id, None) -> `String ("didn't manage to find " ^ id)
        | `Not_found (i, Some f) ->
          `String
            (sprintf "%s was supposed to be in %s but could not be found" i f)
        | `Not_in_env str ->
          `String (Printf.sprintf "Not in environment '%s'" str)
        | `File_not_found msg ->
          `String msg
        | `Found doc ->
          `String doc
      end
    | Locate _, resp ->
      begin match resp with
        | `At_origin -> `String "Already at definition point"
        | `Invalid_context -> `String "Not a valid identifier"
        | `Not_found (id, None) -> `String ("didn't manage to find " ^ id)
        | `Not_found (i, Some f) ->
          `String
            (sprintf "%s was supposed to be in %s but could not be found" i f)
        | `Not_in_env str ->
          `String (Printf.sprintf "Not in environment '%s'" str)
        | `File_not_found msg ->
          `String msg
        | `Found (None,pos) ->
          `Assoc ["pos", Lexing.json_of_position pos]
        | `Found (Some file,pos) ->
          `Assoc ["file",`String file; "pos", Lexing.json_of_position pos]
      end
    | Jump _, resp ->
      begin match resp with
        | `Error str ->
          `String str
        | `Found pos ->
          `Assoc ["pos", Lexing.json_of_position pos]
      end
    | Case_analysis _, ({ Location. loc_start ; loc_end }, str) ->
      let assoc =
        `Assoc [
          "start", Lexing.json_of_position loc_start  ;
          "end", Lexing.json_of_position loc_end ;
        ]
      in
      `List [ assoc ; `String str ]
    | Outline, outlines ->
      `List (json_of_outline outlines)
    | Shape _, shapes ->
      `List (List.map ~f:json_of_shape shapes)
    | Errors, errors ->
      `List (List.map ~f:json_of_error errors)
    | Dump _, json -> json
    | Which_path _, str -> `String str
    | Which_with_ext _, strs -> json_of_string_list strs
    | Flags_get, flags ->
      json_of_string_list flags
    | Findlib_list, strs -> json_of_string_list strs
    | Extension_list _, strs -> json_of_string_list strs
    | Path_list _, strs -> json_of_string_list strs
    | Project_get, (strs, failures) ->
      `Assoc (with_failures ["result", json_of_string_list strs] failures)
    | Occurrences _, locations ->
      `List (List.map locations
               ~f:(fun loc -> with_location loc []))
    | Version, version ->
      `String version
    | Idle_job, b -> `Bool b

  let json_of_sync_command (type a) (command : a sync_command) (response : a) : json =
    match command, response with
    | Tell _, cursor ->
      json_of_cursor_state cursor
    | Seek _, cursor ->
      json_of_cursor_state cursor
    | Drop, cursor ->
      json_of_cursor_state cursor
    | Checkout _, cursor ->
      json_of_cursor_state cursor
    | Refresh, () -> `Bool true
    | Flags_set _, failures ->
      `Assoc (with_failures ["result", `Bool true] failures)
    | Findlib_use _, failures ->
      `Assoc (with_failures ["result", `Bool true] failures)
    | Extension_set _, failures ->
      `Assoc (with_failures ["result", `Bool true] failures)
    | Path _, () -> `Bool true
    | Path_reset, () -> `Bool true
    | Protocol_version _, (`Selected v, `Latest vm, version) ->
      `Assoc ["selected", json_of_protocol_version v;
              "latest", json_of_protocol_version v;
              "merlin",  `String version
             ]

  let json_of_response = function
    | Failure s | Exception (Failure' s) -> `List [`String "failure"; `String s]
    | Error error -> `List [`String "error"; error]
    | Exception exn ->
      begin match error_catcher exn with
      | Some (_,error) -> `List [`String "error"; error]
      | None -> `List [`String "exception"; `String (Printexc.to_string exn)]
      end
    | Return (Query cmd, response) ->
      `List [`String "return"; json_of_query_command cmd response]
    | Return (Sync cmd, response) ->
      `List [`String "return"; json_of_sync_command cmd response]

  let request_of_json = function
    | `Assoc _ as json ->
      let open Json.Util in
      let ctx = member "context" json |> to_list in
      let query = member "query" json |> to_list in
      begin match request_of_json query with
        | Request request -> Context_request (context_of_json ctx, request)
        | _ -> assert false
      end
    | `List jsons -> request_of_json jsons
    | _ -> invalid_arguments ()
end

(* Used when dumping state as raw json *)
let with_location = Protocol_io.with_location

let lift (i,o : low_io) : io =
  (Stream.map ~f:Protocol_io.request_of_json i,
   (fun x -> o (Protocol_io.json_of_response x)))
