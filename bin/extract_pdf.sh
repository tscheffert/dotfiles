#!/bin/bash

for pdffile in *.pdf ; do
  prefix="${pdffile%.*}"

  if [[ ! -d "$prefix" ]]; then
    mkdir "$prefix"
  fi
  pdfimages -j "$pdffile" "$prefix"

  mv *.jpg "$prefix"
done
