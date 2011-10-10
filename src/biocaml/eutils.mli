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
