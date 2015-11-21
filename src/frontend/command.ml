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
open Misc

open Protocol
open Merlin_lib

type state = {
  mutable buffer : Buffer.t;

  mutable verbosity_last : Obj.t option;
  mutable verbosity : int;
}

let normalize_context (ft,path,dot_merlins : Protocol.context) =
  let ft = match ft, path with
    | `ML   , _  -> Parser.ML
    | `MLI  , _  -> Parser.MLI
    | `Auto , Some path when Filename.check_suffix path ".mli" -> Parser.MLI
    | `Auto , _ -> Parser.ML
  in
  ft, path, dot_merlins

let new_buffer (ft, path, dot_merlins) =
  let buffer = Buffer.create ?dot_merlins ?path ft in
  begin match path with
    | Some path when Filename.check_suffix path "myocamlbuild.ml" ->
      let project = Buffer.project buffer in
      let config = Project.get_user_config project in
      Project.set_user_config project
        {config with
         Dot_merlin.packages = "ocamlbuild" :: config.Dot_merlin.packages}
    | _ -> ()
  end;
  buffer

let new_state ?context () =
  let buffer = match context with
    | None -> Buffer.create Parser.ML
    | Some context -> new_buffer context
  in
  {buffer; verbosity_last = None; verbosity = 0}

let checkout_buffer_cache = ref []
let checkout_buffer =
  let cache_size = 8 in
  fun context ->
    let context = normalize_context context in
    try List.assoc context !checkout_buffer_cache
    with Not_found ->
      let buffer = new_buffer context in
      begin match context with
        | _, Some path, _ ->
          checkout_buffer_cache :=
            (context, buffer) :: List.take_n cache_size !checkout_buffer_cache
        | _, None, _ -> ()
      end;
      buffer

let with_typer buffer f =
  let typer = Buffer.typer buffer in
  Typer.with_typer typer (fun () -> f typer)

let cursor_state state =
  { cursor = Source.get_lexing_pos (Buffer.source state.buffer) `End }

let user_failures project =
  match Project.get_user_config_failures project with
  | [] -> `Ok
  | xs -> `Failures xs

let node_list path =
  List.map ~f:snd (List.Non_empty.to_list path)

let track_verbosity (type a) state (command : a command) =
  let tracked =
    let obj = Some (Obj.repr command) in
    match command with
    | Query (Type_expr _) -> obj
    | Query (Type_enclosing _) -> obj
    | Query (Enclosing _) -> obj
    | Query (Complete_prefix _) -> obj
    | Query (Expand_prefix _) -> obj
    | _ -> None
  in
  match tracked with
  | None -> 0
  | value when state.verbosity_last = value ->
    state.verbosity <- state.verbosity + 1;
    state.verbosity
  | value ->
    state.verbosity_last <- value;
    state.verbosity <- 0;
    0

let buffer_update state items =
  Buffer.update state.buffer items;
  state.verbosity_last <- None

let buffer_freeze state items =
  buffer_update state items

module Printtyp = Type_utils.Printtyp

let dump buffer = function
  (*| [`String "parsetree"] ->
    with_typer buffer @@ fun typer ->
    let ppf, to_string = Format.to_string () in
    List.iter (List.rev (Typer.contents typer))
      ~f:(fun (parsed, _ , _) ->
          begin match parsed with
          | `Sg p -> Pprintast.signature ppf p
          | `Str p -> Pprintast.structure ppf p
          end;
          Format.pp_print_newline ppf ();
          Format.pp_force_newline ppf ()
          );
    `String (to_string ())

  | [`String "parser"] ->
    Merlin_recover.dump (Buffer.recover buffer)

  | [`String "typer"; `String "input"] ->
    with_typer buffer @@ fun typer ->
    let ppf, to_string = Format.to_string () in
    Typer.dump ppf typer;
    `String (to_string ())

  | [`String "typer"; `String "output"] ->
    with_typer buffer @@ fun typer ->
    let ppf, to_string = Format.to_string () in
    List.iter (fun (_,typed,_) ->
        match typed with
        | `Fail (_,loc) ->
          Format.fprintf ppf "<failed to type at %a>\n" Location.print loc
        | `Sg sg -> Printtyped.interface ppf sg
        |`Str str -> Printtyped.implementation ppf str
      ) (Typer.contents typer);
    `String (to_string ())

  | [`String "recover"] ->
    Merlin_recover.dump_recoverable (Buffer.recover buffer);

  | (`String ("env" | "fullenv" as kind) :: opt_pos) ->
    with_typer buffer @@ fun typer ->
    let kind = if kind = "env" then `Normal else `Full in
    let pos = IO.Protocol_io.optional_position opt_pos in
    let env = match pos with
      | None -> Typer.env typer
      | Some pos -> fst (Browse.leaf_node (Typer.node_at typer pos))
    in
    let sg = Browse_misc.signature_of_env ~ignore_extensions:(kind = `Normal) env in
    let aux item =
      let ppf, to_string = Format.to_string () in
      Printtyp.signature ppf [item];
      let content = to_string () in
      let ppf, to_string = Format.to_string () in
      match Raw_compat.signature_loc item with
      | Some loc ->
        Location.print_loc ppf loc;
        let loc = to_string () in
        `List [`String loc ; `String content]
      | None -> `String content
    in
    `List (List.map ~f:aux sg)

  | [`String "browse"] ->
    with_typer buffer @@ fun typer ->
    let structures = Typer.to_browse (Typer.contents typer) in
    Browse_misc.dump_ts (List.map ~f:snd @@ List.map ~f:Browse.leaf_node structures)

  | [`String "tokens"] ->
    let tokens = Buffer.lexer buffer in
    let tokens = History.seek_backward (fun _ -> true) tokens in
    let tokens = History.tail tokens in
    `List (List.filter_map tokens
             ~f:(fun (_exns,item) -> match item with
             | Lexer.Error _ -> None
             | Lexer.Valid (s,t,e) ->
               let t = Raw_parser_values.symbol_of_token t in
               let t = Raw_parser_values.class_of_symbol t in
               let t = Raw_parser_values.string_of_class t in
               Some (`Assoc [
                   "start", Lexing.json_of_position s;
                   "end", Lexing.json_of_position e;
                   "token", `String t;
                 ])
             )
          )

  | [`String "flags"] ->
    let flags = Project.get_flags (Buffer.project buffer) in
    let assoc =
      List.map flags ~f:(fun (src, flag_lists) ->
        let l = List.concat_map flag_lists ~f:(List.map ~f:(fun s -> `String s)) in
        src, `List l
      )
    in
    `Assoc assoc

  | [`String "warnings"] ->
    with_typer buffer @@ fun _typer ->
    Warnings.dump ()

  | [`String "exn"] ->
    with_typer buffer @@ fun typer ->
    let exns =
      Typer.exns typer
      @ Buffer.lexer_errors buffer
      @ Buffer.parser_errors buffer
    in
    `List (List.map ~f:(fun x -> `String (Printexc.to_string x)) exns)
    FIXME
    *)

  | _ -> IO.invalid_arguments ()

let dispatch_query ~verbosity buffer (type a) : a query_command -> a = function
  | Type_expr (source, pos) ->
    with_typer buffer @@ fun typer ->
    let env = match pos with
      | None -> Typer.env typer
      | Some pos -> fst (Browse.leaf_node (Typer.node_at typer pos))
    in
    let ppf, to_string = Format.to_string () in
    ignore (Type_utils.type_in_env ~verbosity env ppf source : bool);
    to_string ()

  | Type_enclosing (expro, pos) ->
    let open Browse_node in
    let open Typedtree in
    let open Override in
    with_typer buffer @@ fun typer ->
    let structures = Typer.to_browse (Typer.result typer) in
    let env, path = match Browse.enclosing pos [structures] with
      | None -> Typer.env typer, []
      | Some browse ->
         fst (Browse.leaf_node browse),
         Browse_misc.annotate_tail_calls_from_leaf browse
    in
    let aux (node,tail) =
      match node with
      | Expression {exp_type = t}
      | Pattern {pat_type = t}
      | Core_type {ctyp_type = t}
      | Value_description { val_desc = { ctyp_type = t } } ->
        let ppf, to_string = Format.to_string () in
        Printtyp.wrap_printing_env env ~verbosity
          (fun () -> Type_utils.print_type_with_decl ~verbosity env ppf t);
        Some (Browse.node_loc node, to_string (), tail)

      | Type_declaration { typ_id = id; typ_type = t} ->
        let ppf, to_string = Format.to_string () in
        Printtyp.wrap_printing_env env ~verbosity
          (fun () -> Printtyp.type_declaration env id ppf t);
        Some (Browse.node_loc node, to_string (), tail)

      | Module_expr {mod_type = m}
      | Module_type {mty_type = m}
      | Module_binding {mb_expr = {mod_type = m}}
      | Module_declaration {md_type = {mty_type = m}}
      | Module_type_declaration {mtd_type = Some {mty_type = m}}
      | Module_binding_name {mb_expr = {mod_type = m}}
      | Module_declaration_name {md_type = {mty_type = m}}
      | Module_type_declaration_name {mtd_type = Some {mty_type = m}} ->
        let ppf, to_string = Format.to_string () in
        Printtyp.wrap_printing_env env ~verbosity
          (fun () -> Printtyp.modtype env ppf m);
        Some (Browse.node_loc node, to_string (), tail)

      | _ -> None
    in
    let result = List.filter_map ~f:aux path in
    (* enclosings of cursor in given expression *)
    let exprs =
      match expro with
      | None ->
        assert false
        (* FIXME
           let lexer = Buffer.lexer buffer in
        let lexer =
          History.seek_backward
            (fun (_,item) -> Lexing.compare_pos pos (Lexer.item_start item) < 0)
            lexer
        in
        let path = Lexer.reconstruct_identifier lexer in
        let path = Lexer.identifier_suffix path in
        begin match path with
        | [] -> []
        | base :: tail ->
          let f {Location. txt=base; loc=bl} {Location. txt=dot; loc=dl} =
            let loc = Parsing_aux.location_union bl dl in
            let txt = base ^ "." ^ dot in
            Location.mkloc txt loc
          in
          [ List.fold_left tail ~init:base ~f ]
        end*)
      | Some (expr, offset) ->
        let loc_start =
          let l, c = Lexing.split_pos pos in
          Lexing.make_pos (l, c - offset)
        in
        let shift loc int =
          let l, c = Lexing.split_pos loc in
          Lexing.make_pos (l, c + int)
        in
        let add_loc source =
          let loc =
            { Location.
              loc_start ;
              loc_end = shift loc_start (String.length source) ;
              loc_ghost = false ;
            } in
          Location.mkloc source loc
        in
        let len = String.length expr in
        let rec aux acc i =
          if i >= len then
            List.rev_map ~f:add_loc (expr :: acc)
          else if expr.[i] = '.' then
            aux (String.sub expr ~pos:0 ~len:i :: acc) (succ i)
          else
            aux acc (succ i) in
        aux [] offset
    in
    let small_enclosings =
      let env, node = Browse.leaf_node (Typer.node_at typer pos) in
      let include_lident = match node with
        | Pattern _ -> false
        | _ -> true
      in
      let include_uident = match node with
        | Module_binding _
        | Module_binding_name _
        | Module_declaration _
        | Module_declaration_name _
        | Module_type_declaration _
        | Module_type_declaration_name _
          -> false
        | _ -> true
      in
      List.filter_map exprs ~f:(fun {Location. txt = source; loc} ->
          match source with
          | "" -> None
          | source when not include_lident && Char.is_lowercase source.[0] ->
            None
          | source when not include_uident && Char.is_uppercase source.[0] ->
            None
          | source ->
            try
              let ppf, to_string = Format.to_string () in
              if Type_utils.type_in_env ~verbosity env ppf source then
                Some (loc, to_string (), `No)
              else
                None
            with _ ->
              None
        )
    in
    let normalize ({Location. loc_start; loc_end}, text, _tail) =
        Lexing.split_pos loc_start, Lexing.split_pos loc_end, text in
    List.merge_cons
      ~f:(fun a b ->
          (* Tail position is computed only on result, and result comes last
             As an approximation, when two items are similar, we returns the
             rightmost one *)
          if normalize a = normalize b then Some b else None)
      (small_enclosings @ result)

  | Enclosing pos ->
    with_typer buffer @@ fun typer ->
    let structures = Typer.to_browse (Typer.result typer) in
    let path = match Browse.enclosing pos [structures] with
      | None -> []
      | Some path -> node_list path
    in
    List.map ~f:Browse.node_loc path

  | Complete_prefix (prefix, pos, with_doc) ->
    let complete ~no_labels typer =
      let path = Typer.node_at ~skip_recovered:true typer pos in
      let env, node = Browse.leaf_node path in
      let target_type, context =
        Completion.application_context ~verbosity ~prefix path in
      let get_doc =
        if not with_doc then None else
        let project    = Buffer.project buffer in
        let comments   = Lexer.comments (Buffer.lexer buffer) in
        let source     = Buffer.unit_name buffer in
        let local_defs = Typer.result typer in
        Some (
          Track_definition.get_doc ~project ~env ~local_defs
            ~comments ~pos source
        )
      in
      let entries =
        Completion.node_complete ?get_doc ?target_type buffer env node prefix
      and context = match context with
        | `Application context when no_labels ->
          `Application {context with Protocol.Compl.labels = []}
        | context -> context
      in
      {Compl. entries = List.rev entries; context }
    in
    let lexer0 = Buffer.lexer buffer in
    (*let lexer =
      History.seek_backward
        (fun (_,item) -> Lexing.compare_pos pos (Lexer.item_start item) <= 0)
        lexer0
    in
    let lexer =
      History.seek_forward ~last:true
        (fun (_,item) -> Lexing.compare_pos (Lexer.item_end item) pos <= 0)
        lexer
    in
    let need_token, no_labels =
      let open Raw_parser in
      let exns, item = History.focused lexer in
      let loc = Lexer.item_location item in
      let need_token =
        if Parsing_aux.compare_pos pos loc = 0 &&
           (match item with
            | Lexer.Valid (_, (LIDENT _ | UIDENT _), _) -> true
            | _ -> false)
        then
          None
        else
          Some (exns, Lexer.Valid (pos, LIDENT "", pos))
      and no_labels =
        (* Cursor is already over a label, don't suggest another one *)
        match item with
        | Lexer.Valid (_, (LABEL _ | OPTLABEL _), _) -> true
        | _ -> false
      in
      need_token, no_labels
    in
    begin match need_token with
    | None -> with_typer buffer (complete ~no_labels)
    | Some token ->
      (* Setup fake AST *)
      let lexer' = History.fake_insert token lexer in
      let lexer' = History.seek (History.position lexer0 + 1) lexer' in
      ignore (Buffer.update buffer lexer' : [> ]);
      try_finally
        (* Complete on adjusted buffer *)
        (fun () -> with_typer buffer (complete ~no_labels))
        (* Restore original buffer *)
        (fun () -> ignore (Buffer.update buffer lexer0 : [> ]))
    end
      *)
    with_typer buffer (complete ~no_labels:true)

  | Expand_prefix (prefix, pos) ->
    with_typer buffer @@ fun typer ->
    let env, _ = Browse.leaf_node (Typer.node_at typer pos) in
    let global_modules = Buffer.global_modules buffer in
    let entries = Completion.expand_prefix env ~global_modules prefix in
    { Compl. entries ; context = `Unknown }

  | Document (patho, pos) ->
    with_typer buffer @@ fun typer ->
    let comments = Lexer.comments (Buffer.lexer buffer) in
    let env, _ = Browse.leaf_node (Typer.node_at typer pos) in
    let local_defs = Typer.result typer in
    let path =
      match patho with
      | Some p -> p
      | None -> assert false
        (*let lexer = Buffer.lexer buffer in
        let lexer =
          History.seek_backward (fun (_,item) ->
            Lexing.compare_pos pos (Lexer.item_start item) < 0) lexer
        in
        let path = Lexer.reconstruct_identifier ~for_locate:true lexer in
        let path = Lexer.identifier_suffix path in
        let path = List.map ~f:(fun {Location. txt} -> txt) path in
        String.concat ~sep:"." path*)
    in
    if path = "" then `Invalid_context else
    let source  = Buffer.unit_name buffer in
    let project = Buffer.project buffer in
    Track_definition.get_doc ~project ~env ~local_defs ~comments ~pos source
      (`User_input path)

  | Locate (patho, ml_or_mli, pos) ->
    with_typer buffer @@ fun typer ->
    let env, _ = Browse.leaf_node (Typer.node_at typer pos) in
    let local_defs = Typer.result typer in
    let path =
      match patho with
      | Some p -> p
      | None -> assert false
        (*let lexer = Buffer.lexer buffer in
        let lexer =
          History.seek_backward (fun (_,item) ->
            Lexing.compare_pos pos (Lexer.item_start item) < 0) lexer
        in
        let path = Lexer.reconstruct_identifier ~for_locate:true lexer in
        let path = Lexer.identifier_suffix path in
        let path = List.map ~f:(fun {Location. txt} -> txt) path in
        String.concat ~sep:"." path*)
    in
    if path = "" then `Invalid_context else
    let project = Buffer.project buffer in
    begin match
      Track_definition.from_string ~project ~env ~local_defs ~pos ml_or_mli path
    with
    | `Found (file, pos) ->
      Logger.log "track_definition" "Locate"
        (Option.value ~default:"<local buffer>" file);
      `Found (file, pos)
    | otherwise -> otherwise
    end

  | Jump (target, pos) ->
    with_typer buffer @@ fun typer ->
    let typed_tree = Typer.result typer in
    Jump.get typed_tree pos target

  | Case_analysis ({ Location. loc_start ; loc_end } as loc) ->
    with_typer buffer @@ fun typer ->
    let env = Typer.env typer in
    Printtyp.wrap_printing_env env ~verbosity @@ fun () ->
    let structures = Typer.to_browse (Typer.result typer) in
    let enclosings = match Browse.enclosing loc_start [structures] with
      | None -> []
      | Some path -> node_list path
    in
    begin match
        List.drop_while enclosings ~f:(fun t ->
            Lexing.compare_pos (Browse.node_loc t).Location.loc_end loc_end < 0)
      with
      | [] -> failwith "No node at given range"
      | node :: parents -> Destruct.node ~loc node parents
    end

  | Outline ->
    with_typer buffer @@ fun typer ->
    let browse = Typer.to_browse (Typer.result typer) in
    Outline.get [BrowseT.of_browse browse]

  | Shape cursor ->
    with_typer buffer @@ fun typer ->
    let browse = Typer.to_browse (Typer.result typer) in
    Outline.shape cursor [BrowseT.of_browse browse]

  | Errors ->
    begin
      with_typer buffer @@ fun typer ->
      Printtyp.wrap_printing_env (Typer.env typer) ~verbosity @@ fun () ->
      try
        let typer = Buffer.typer buffer in
        let cmp (l1,_) (l2,_) =
          Lexing.compare_pos l1.Location.loc_start l2.Location.loc_start in
        let err exns =
          List.filter ~f:(fun (l,err) ->
            not l.Location.loc_ghost || err.Error_report.where <> "warning"
          ) @@
          List.sort_uniq ~cmp (List.map ~f:Error_report.of_exn exns)
        in
        let err_lexer  = [] in (*FIXME err @@ Lexer.errors  @@ Buffer.lexer buffer in*)
        let err_parser = [] in (*FIXME err @@ Parser.errors @@ Buffer.parser buffer in*)
        let err_typer  =
          (* When there is a cmi error, we will have a lot of meaningless errors,
           * there is no need to report them. *)
          let exns = Typer.errors typer @ Typer.checks typer in
          let exns =
            let cmi_error = function Cmi_format.Error _ -> true | _ -> false in
            try [ List.find exns ~f:cmi_error ]
            with Not_found -> exns
          in
          err exns
        in
        (* Return parsing warnings & first parsing error,
           or type errors if no parsing errors *)
        let rec extract_warnings acc = function
          | (_,{Error_report. where = "warning"; _ }) as err :: errs ->
            extract_warnings (err :: acc) errs
          | err :: _ ->
            List.rev (err :: acc),
            List.take_while ~f:(fun err' -> cmp err' err < 0) err_typer
          | [] ->
            List.rev acc, err_typer in
        (* Filter duplicate error messages *)
        let err_parser, err_typer = extract_warnings [] err_parser in
        let errors =
          List.map ~f:snd @@
          List.merge ~cmp err_lexer @@
          List.merge ~cmp err_parser err_typer
        in
        Error_report.flood_barrier errors
      with exn -> match Error_report.strict_of_exn exn with
        | None -> raise exn
        | Some (_loc, err) -> [err]
    end

  | Dump args ->
    dump buffer args

  | Which_path xs ->
    begin
      let project = Buffer.project buffer in
      let rec aux = function
        | [] -> raise Not_found
        | x :: xs ->
          try
            find_in_path_uncap (Project.source_path project) x
          with Not_found -> try
            find_in_path_uncap (Project.build_path project) x
          with Not_found ->
            aux xs
      in
      aux xs
    end

  | Which_with_ext exts ->
    let project = Buffer.project buffer in
    let with_ext ext = modules_in_path ~ext (Project.source_path project) in
    List.concat_map ~f:with_ext exts

  | Flags_get ->
    let project = Buffer.project buffer in
    List.concat (Merlin_lib.Project.get_user_config project).Dot_merlin.flags

  | Project_get ->
    let project = Buffer.project buffer in
    (Project.get_dot_merlins project,
     match Project.get_dot_merlins_failure project with
     | [] -> `Ok
     | failures -> `Failures failures)

  | Findlib_list ->
    Fl_package_base.list_packages ()

  | Extension_list kind ->
    let project = Buffer.project buffer in
    let enabled = Project.extensions project in
    let set = match kind with
      | `All -> Extension.all
      | `Enabled -> enabled
      | `Disabled -> String.Set.diff Extension.all enabled
    in
    String.Set.to_list set

  | Path_list `Build ->
    let project = Buffer.project buffer in
    Project.build_path project

  | Path_list `Source ->
    let project = Buffer.project buffer in
    Project.source_path project

  | Occurrences (`Ident_at pos) ->
    with_typer buffer @@ fun typer ->
    let str = Typer.to_browse (Typer.result typer) in
    let tnode = match Browse.enclosing pos [str] with
      | Some t -> BrowseT.of_browse t
      | None -> BrowseT.dummy
    in
    let str = BrowseT.of_browse str in
    let get_loc {Location.txt = _; loc} = loc in
    let ident_occurrence () =
      let paths = Browse_node.node_paths tnode.BrowseT.t_node in
      let under_cursor p = Parsing_aux.compare_pos pos (get_loc p) = 0 in
      Logger.logj "occurrences" "Occurrences paths" (fun () ->
          let dump_path ({Location.txt; loc} as p) =
            let ppf, to_string = Format.to_string () in
            Printtyp.path ppf txt;
            `Assoc [
              "start", Lexing.json_of_position loc.Location.loc_start;
              "end", Lexing.json_of_position loc.Location.loc_end;
              "under_cursor", `Bool (under_cursor p);
              "path", `String (to_string ())
            ]
          in
          `List (List.map ~f:dump_path paths));
      match List.filter paths ~f:under_cursor with
      | [] -> []
      | (path :: _) ->
        let path = path.Location.txt in
        let ts = BrowseT.all_occurrences path str in
        let loc (_t,paths) = List.map ~f:get_loc paths in
        List.concat_map ~f:loc ts

    and constructor_occurrence d =
      let ts = BrowseT.all_constructor_occurrences (tnode,d) str in
      List.map ~f:get_loc ts

    in
    let locs = match Browse_node.node_is_constructor tnode.BrowseT.t_node with
      | Some d -> constructor_occurrence d.Location.txt
      | None -> ident_occurrence ()
    in
    let loc_start l = l.Location.loc_start in
    let cmp l1 l2 = Lexing.compare_pos (loc_start l1) (loc_start l2) in
    List.sort ~cmp locs

  | Version ->
    Main_args.version_spec

  | Idle_job ->
    Buffer.idle_job buffer

let dispatch_sync state (type a) : a sync_command -> a = function
  (*| Tell (`Start pos) ->
    let lexer = Buffer.start_lexing ?pos state.buffer in
    state.lexer <- Some lexer;
    buffer_update state (Lexer.history lexer);
    cursor_state state

  | Tell (`File _ | `Source _ | `File_eof _ | `Source_eof _ | `Eof as source) ->
    let source, then_eof = match source with
      | `Eof -> Some "", false
      | `Source "" -> None, false
      | `Source source -> Some source, false
      | `File path ->
        begin match Misc.file_contents path with
        | "" -> None
        | source -> Some source
        end, false
      | `Source_eof source -> Some source, true
      | `File_eof path ->
        begin match Misc.file_contents path with
        | "" -> None
        | source -> Some source
        end, true
    in
    begin match source with
      | None -> cursor_state state
      | Some source ->
        let lexer = match state.lexer with
          | Some lexer ->
            assert (not (Lexer.eof lexer));
            lexer
          | None ->
            let lexer = Buffer.start_lexing state.buffer in
            state.lexer <- Some lexer; lexer in
        assert (Lexer.feed lexer source);
        if then_eof then assert (Lexer.feed lexer "");
        buffer_update state (Lexer.history lexer);
        (* Stop lexer on EOF *)
        if Lexer.eof lexer then state.lexer <- None;
        cursor_state state
    end *)

  | Tell _ -> assert false
  | Drop   -> assert false
  | Seek _ -> assert false

  | Refresh ->
    checkout_buffer_cache := [];
    Cmi_cache.flush ();
    Project.check_dot_merlin (Buffer.project state.buffer)

  | Flags_set flags ->
    let project = Buffer.project state.buffer in
    let config = Project.get_user_config project in
    Project.set_user_config project {config with Dot_merlin.flags = [flags]};
    user_failures project

  | Findlib_use packages ->
    let project = Buffer.project state.buffer in
    let config = Project.get_user_config project in
    Project.set_user_config project
      {config with
       Dot_merlin.packages = packages @ config.Dot_merlin.packages};
    user_failures project

  | Extension_set (action,exts) ->
    let f l = match action with
      | `Enabled  -> List.filter_dup (exts @ l)
      | `Disabled -> List.filter l ~f:(fun x -> not (List.mem x ~set:exts))
    in
    let project = Buffer.project state.buffer in
    let config = Project.get_user_config project in
    Project.set_user_config project
      {config with Dot_merlin.extensions = f config.Dot_merlin.extensions};
    user_failures project

  | Path (var,action,paths) ->
    let project = Buffer.project state.buffer in
    let config = Project.get_user_config project in
    let f l = match action with
      | `Add -> List.filter_dup (paths @ l)
      | `Rem -> List.filter l ~f:(fun x -> not (List.mem x ~set:paths))
    in
    let config = match var with
      | `Build -> {config with Dot_merlin.build_path = f config.Dot_merlin.build_path}
      | `Source -> {config with Dot_merlin.source_path = f config.Dot_merlin.source_path}
    in
    Project.set_user_config project config

  | Path_reset ->
    let project = Buffer.project state.buffer in
    let config = Project.get_user_config project in
    Project.set_user_config project
      {config with Dot_merlin.build_path = []; source_path = []}

  | Protocol_version _ ->
    (`Selected !IO.current_version,
     `Latest IO.latest_version,
     Main_args.version_spec)

  | Checkout _ -> IO.invalid_arguments ()

let dispatch state (type a) (cmd : a command) =
  let verbosity = track_verbosity state cmd in
  match cmd with
  | Query q -> dispatch_query ~verbosity state.buffer q
  | Sync (Checkout context) ->
    let buffer = checkout_buffer context in
    state.buffer <- buffer;
    cursor_state state
  | Sync s -> dispatch_sync state s

let contexts : (Parser.kind * string option * string list option,
                state) Hashtbl.t = Hashtbl.create 7

let context_dispatch context cmd =
  let context = normalize_context context in
  let state =
    try Hashtbl.find contexts context
    with Not_found ->
      let state = new_state ~context () in
      Hashtbl.add contexts context state;
      state
  in
  let verbosity = track_verbosity state cmd in
  match cmd with
  | Query q -> dispatch_query ~verbosity state.buffer q
  | Sync s -> dispatch_sync state s

let new_state () = new_state ()
