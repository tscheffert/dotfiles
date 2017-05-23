#!/bin/bash

function extract() {
  pdffile="$1"
  prefix="${pdffile%.*}"

  if [[ ! -d "$prefix" ]]; then
    mkdir "$prefix"
  fi
  pdfimages -j "$pdffile" "$prefix"

  mv *.jpg "$prefix"
}

arg="$1"

if [[ -f "$arg" ]]; then
  extract "$arg"
else
  for pdffile in *.pdf ; do
    extract "$pdffile"
  done
fi

