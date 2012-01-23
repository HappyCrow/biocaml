#!/bin/bash

#set -x

# use OCaml provided by GODI
export PATH=/usr/local/godi/bin:/usr/local/godi/sbin:$PATH

ocaml setup.ml -configure
make
make test
#make doc
#make install
