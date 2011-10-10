type database = [
  `pubmed
| `gene
]

val esearch_url : 
  ?retstart:int -> ?retmax:int -> 
  ?rettype:[`uilist | `count] -> 
  ?field:string ->
  ?datetype:[`pdat | `mdat | `edat] ->
  ?reldate:int ->
  ?mindate:string -> ?maxdate:string ->
  database -> string -> string

(** does not support more than 200 ids *)
val efetch_url : 
  ?rettype:string -> ?retmode:string ->
  database -> string list -> string
