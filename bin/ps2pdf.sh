#!/bin/bash

gs="/c/Program Files/gs/gs9.21/bin/gswin64c.exe"
infile="$1"
outfile="$2"

"$gs" -q \
  -P- \
  -dSAFER \
  -dNOPAUSE \
  -dBATCH \
  -sDEVICE=pdfwrite \
  -sOutputFile="$outfile" \
  -c save pop \
  -f \
  "$infile"
