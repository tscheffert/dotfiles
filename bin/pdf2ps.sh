#!/bin/bash

gs="/c/Program Files/gs/gs9.21/bin/gswin64c.exe"
infile="$1"
outfile="$2"

prefix="${infile%.*}"


"$gs" \
  -q \
  -P- \
  -dSAFER \
  -dNOPAUSE \
  -dBATCH \
  -sDEVICE=ps2write \
  -sOutputFile="$outfile" \
  "$infile"
