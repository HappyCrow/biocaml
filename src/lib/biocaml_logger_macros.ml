
module Loc = struct
  let of_tuple (filename, line_number, _, _, _, _, _, _) =
    filename, line_number
end

DEFINE FATAL(loc, log, msg)  =
  (Biocaml_logger.log_message log Biocaml_logger.FATAL
     (lazy ((Biocaml_logger.loc_string loc) ^ (msg))))
DEFINE ERROR(loc, log, msg)  =
  (Biocaml_logger.log_message log Biocaml_logger.ERROR
     (lazy ((Biocaml_logger.loc_string loc) ^ (msg))))
DEFINE WARN(loc, log, msg)   =
  (Biocaml_logger.log_message log Biocaml_logger.WARN
     (lazy ((Biocaml_logger.loc_string loc) ^ (msg))))
DEFINE NOTICE(loc, log, msg) =
  (Biocaml_logger.log_message log Biocaml_logger.NOTICE
     (lazy ((Biocaml_logger.loc_string loc) ^ (msg))))
DEFINE INFO(loc, log, msg)   =
  (Biocaml_logger.log_message log Biocaml_logger.INFO
     (lazy ((Biocaml_logger.loc_string loc) ^ (msg))))
DEFINE DEBUG(loc, log, msg)  =
  (Biocaml_logger.log_message log Biocaml_logger.DEBUG
     (lazy ((Biocaml_logger.loc_string loc) ^ (msg))))
