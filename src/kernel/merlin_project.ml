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

type config = {
  dot_config     : Dot_merlin.config;
  flags          : Clflags.set;
  warnings       : Warnings.state;
  keywords       : Merlin_lexer.keywords;
  extensions     : Extension.set;
  validity_stamp : bool ref;

  source_path    : string list;
  cmt_path       : string list;
  build_path     : string list;

  dot_failures  : (string * exn) list;
  user_failures : (string * exn) list;
}

type t = {
  dot_merlin          : Dot_merlin.t;
  mutable user_config : Dot_merlin.config;
  mutable local_path  : string list;
  mutable config        : config option;
}

let compute_packages prj =
  let `Failures dfails, dpaths, dppxs =
    Dot_merlin.path_of_packages (Dot_merlin.config prj.dot_merlin)
  and `Failures ufails, upaths, uppxs =
    Dot_merlin.path_of_packages prj.user_config
  in
  dfails, ufails, upaths @ dpaths, Ppxsetup.union uppxs dppxs

let compute_flags ppxsetup prj =
  let flags = Clflags.copy Clflags.initial in
  let warnings = Warnings.copy Warnings.initial in
  let spec = Clflags.arg_spec flags @ Warnings.arg_spec warnings in
  let process_flags spec flags =
    let failures = ref [] in
    let rec loop ?(current=(ref 0)) flags =
      try Arg.parse_argv ~current flags spec (fun flg -> raise (Arg.Bad flg)) "" with
      | Arg.Bad _ ->
        Logger.notify "project flags" "unknown flag: %s" flags.(!current);
        failures := (flags.(!current), Arg.Bad flags.(!current)) :: !failures ;
        loop ~current flags
      | Arg.Help _ -> (* ignore *)
        loop ~current flags
    in
    loop flags ;
    !failures
  in
  let process_flags_list lst =
    List.fold_left lst ~init:[] ~f:(fun acc lst ->
        let flags = Array.of_list ("merlin" :: lst) in
        List.rev_append (process_flags spec flags) acc
      )
  in
  let dfails = process_flags_list (Dot_merlin.config prj.dot_merlin).Dot_merlin.flags in
  let dfails = List.rev_append (process_flags (Main_args.flags @ spec) Sys.argv) dfails in
  let ufails = process_flags_list prj.user_config.Dot_merlin.flags in
  flags.Clflags.ppx <- Ppxsetup.union flags.Clflags.ppx ppxsetup;
  dfails, ufails, flags, warnings

let config prj =
  let dot_config = Dot_merlin.config prj.dot_merlin in
  match prj.config with
  | Some config when Dot_merlin.same config.dot_config dot_config -> config
  | None | Some _ ->
    begin match prj.config with
      | None -> ()
      | Some config -> config.validity_stamp := false
    end;
    let dfails0, ufails0, pkgpaths, ppxsetup = compute_packages prj in
    let dfails1, ufails1, flags, warnings = compute_flags ppxsetup prj in
    let open Dot_merlin in
    let user_config = prj.user_config in
    let stdlib =
      if flags.Clflags.std_include then
        [if user_config.stdlib =
            empty_config.stdlib
         then dot_config.stdlib
         else user_config.stdlib]
      else []
    in
    let source_path =
      user_config.source_path @
      dot_config.source_path @
      pkgpaths
    and build_path =
      user_config.cmi_path @
      user_config.build_path @
      dot_config.cmi_path @
      dot_config.build_path @
      pkgpaths @
      !(flags.Clflags.include_dirs) @
      stdlib
    and cmt_path =
      user_config.cmt_path @
      user_config.Dot_merlin.build_path @
      dot_config.cmt_path @
      dot_config.build_path @
      pkgpaths @
      !(flags.Clflags.include_dirs) @
      stdlib
    in
    let extensions = Extension.from
        ~extensions:(user_config.extensions @ dot_config.extensions)
        ~packages:(user_config.packages @ dot_config.packages)
    in
    let keywords = Extension.keywords extensions in
    let config = {
        dot_config;
        warnings; flags;
        extensions; keywords;
        source_path; cmt_path; build_path;
        dot_failures = dfails0 @ dfails1;
        user_failures = ufails0 @ ufails1;
        validity_stamp = ref true;
      }
    in
    prj.config <- Some config;
    config

let source_path p = p.local_path @ (config p).source_path
let build_path  p = p.local_path @ (config p).build_path
let cmt_path    p = p.local_path @ (config p).cmt_path

let global_modules p =
  Misc.modules_in_path ~ext:".cmi" (build_path p)

let set_local_path project path =
  project.local_path <- path

let get_flags project = [
  "user", project.user_config.Dot_merlin.flags;
  "cmd line", [ List.tl @@ Array.to_list Sys.argv ];
  ".merlin", (Dot_merlin.config project.dot_merlin).Dot_merlin.flags;
]

let invalidate t =
  match t.config with
  | None -> ()
  | Some config ->
    config.validity_stamp := false;
    t.config <- None

let get_user_config t = t.user_config
let set_user_config t user_config =
  t.user_config <- user_config;
  invalidate t

let get_user_config_failures t = (config t).user_failures

let create dot_merlins = {
  dot_merlin = Dot_merlin.load dot_merlins;
  user_config = Dot_merlin.empty_config;
  local_path = [];
  config = None;
}

let store : (string list, t) Hashtbl.t = Hashtbl.create 3
let get path =
  try Hashtbl.find store path, `Cached
  with Not_found ->
    let project = create path in
    Hashtbl.replace store path project;
    project, `Fresh

let check_dot_merlin project =
  Dot_merlin.update project.dot_merlin

let get_dot_merlins project =
  (Dot_merlin.config project.dot_merlin).Dot_merlin.dot_merlins

let get_dot_merlins_failure t =
  (config t).dot_failures

(* Make global state point to current project *)
let setup t =
  let c = config t in
  Clflags.set := c.flags;
  Warnings.current := c.warnings;
  Config.load_path := build_path t

(* Enabled extensions *)
let extensions t = (config t).extensions

(* Lexer keywords for current config *)
let keywords t = (config t).keywords

let validity_stamp t =
  let r = (config t).validity_stamp in
  assert !r; r
