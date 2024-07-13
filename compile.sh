#!/bin/bash
if [ -z "$1" ]; then
  echo "Usage: $0 <filename_without_extension>"
  exit 1
fi
set -x

filename="$1"
rm -f "${filename}.prg" "${filename}.dbg" "${filename}.fdb"
ca65 "${filename}.s" -g -o "${filename}.o" -t cx16
ld65 -C cx16.cfg -o "${filename}.prg" --dbgfile "${filename}.dbg" "${filename}.o"
