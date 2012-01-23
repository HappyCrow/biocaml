(* BatLogger is just extended to provide string logging *)
include BatLogger

(* localtime is used to date events, _not_ GMT, beware scientist *)
let default_timestamp_formatter ts =
  let tm     = Unix.localtime ts in
  let us, _s = modf ts           in
    (* example: "2012-01-13 18h26m52.091428s" *)
    Printf.sprintf "%04d-%02d-%02d %02dh%02dm%02d.%06ds"
      (1900 + tm.Unix.tm_year)
      (1    + tm.Unix.tm_mon)
      (tm.Unix.tm_mday)
      (tm.Unix.tm_hour)
      (tm.Unix.tm_min)
      (tm.Unix.tm_sec)
      (int_of_float (1_000_000. *. us))

let default_log_formatter
    timestamp_formatter out_chan logger log_level (message, _event_args) ts =
  let name_of_level_fixed_length log_level =
    (* It helps humans to read logs faster if prefixes are always of same
       length *)
    match log_level with
      | NONE   -> "NONE__"
      | FATAL  -> "FATAL_"
      | ERROR  -> "ERROR_"
      | WARN   -> "WARN__"
      | NOTICE -> "NOTICE"
      | INFO   -> "INFO__"
      | DEBUG  -> "DEBUG_"
  in
    Printf.fprintf out_chan "%s:%s:%s\n%!"
      (timestamp_formatter ts)
      (name_of_level_fixed_length log_level)
      message

let log_init
    log_name log_level (out_chan: out_channel)
    log_formatter (timestamp_formatter: float -> string) =
  let logger = make_log log_name in
    register_formatter log_name (log_formatter timestamp_formatter out_chan);
    log_enable logger log_level;
    logger

let log_message logger level lazy_msg =
  log logger level (fun () -> Lazy.force lazy_msg, [])

let loc_string (filename, line_number) =
  Printf.sprintf "%s:%d:" filename line_number
