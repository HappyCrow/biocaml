(** PHRED quality scores.

    PHRED scores are encoded as ASCII characters in many file
    formats. Two different encodings have been used: an offset of 33
    is the most widely used, but a 64 offset was also used in files
    generated by Illumina software for a period of time. This module
    allows specifying the offset, using the more common 33 as the
    default.

    For details see {{:http://dx.doi.org/10.1093/nar/gkp1137}The
    Sanger FASTQ file format for sequences with quality scores, and
    the Solexa/Illumina FASTQ variants}. Using an offset of 33 or 64
    in this module corresponds to using the fastq-sanger or
    fastq-illumina encodings, respectively, defined in this paper.
*)
open Batteries

exception Error of string

type t

val to_int : t -> int

val to_probability : t -> float

val to_ascii : ?offset:[`offset33 | `offset64] -> t -> char
  (** [to_ascii ~offset t] encodes [t] as an ASCII character using the
      given offset (default = 33).

      @raise Error if [t] with the given [offset] cannot be encoded as
      a visible ASCII character (codes 33 - 126).
  *)

val of_int : int -> t
  (** [of_int x] returns the PHRED score with the same value [x], but
      assures that [x] is non-negative.
      
      @raise Error if [x] is negative.
  *)

val of_ascii : ?offset:[`offset33 | `offset64] -> char -> t
  (** [of_ascii ~offset x] returns the PHRED score encoded by ASCII
      character [x].

      @raise Error if [x] does not represent a valid score.
  *)

val of_probability : ?f:(float -> int) -> float -> t
  (** [of_probability ~f x] returns [-10 * log_10(x)], which is the
      definition of PHRED scores.

      PHRED scores are integral, and it is unclear what convention is
      used to convert the resulting float value to an integer. Thus,
      the optional [f] is provided to dictate this. The default is to
      round the computed score to the closest integer.

      @raise Error if [x] is not between 0.0 - 1.0.
  *)
