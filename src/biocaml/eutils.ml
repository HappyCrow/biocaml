open Batteries
open Printf

(* 
   exhaustive list of databases:
   http://www.ncbi.nlm.nih.gov/books/NBK25497/table/chapter2.chapter2_table1/?report=objectonly 
*)
type database = [
| `gene
| `genome
| `geodatasets
| `geoprofiles
| `protein
| `pubmed
| `pubmedcentral
| `sra
| `unigene
| `taxonomy
]

let id_of_database = function
  | `pubmed -> "pubmed"
  | `gene -> "gene"
  | `unigene -> "unigene"
  | `genome -> "genome"
  | `geoprofiles -> "geoprofiles"
  | `geodatasets -> "geodatasets"
  | `pubmedcentral -> "pmc"
  | `protein -> "protein"
  | `sra -> "sra"
  | `taxonomy -> "taxonomy"

let search_base_url = "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi"

let parameters l = 
  List.filter_map identity l
  |> List.map (fun (k,v) -> sprintf "%s=%s" k v)
  |> String.concat "&"
  
let string_of_datetype = function
  | `pdat -> "pdat"
  | `mdat -> "mdat"
  | `edat -> "edat"


let esearch_url ?retstart ?retmax ?rettype ?field ?datetype ?reldate ?mindate ?maxdate database query = 
  search_base_url ^ "?" ^ parameters Option.([
    Some ("db", id_of_database database) ;
    Some ("term", Netencoding.Url.encode query) ;
    map (fun i -> "retstart", string_of_int i) retstart ;
    map (fun i -> "retmax", string_of_int i) retmax ;
    map (function `uilist -> ("rettype", "uilist") | `count -> ("rettype", "count")) rettype ;
    map (fun s -> "field",s) field ;
    map (fun dt -> "datetype", string_of_datetype dt) datetype ;
    map (fun d -> "mindate", d) mindate ;
    map (fun d -> "maxdate", d) maxdate ;
  ])


let fetch_base_url = "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi"

let efetch_url ?rettype ?retmode database ids = 
  fetch_base_url ^ "?" ^ parameters Option.([
    Some ("db", id_of_database database) ;
    Some ("id", String.concat "," ids) ;
    map (fun d -> "rettype", d) rettype ;
    map (fun d -> "retmode", d) retmode ;
  ])
  
  
