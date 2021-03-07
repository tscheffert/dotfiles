#!/usr/bin/env bash
# vim: ft=sh

fix_insecure_compaudit() {
  local dir=/usr/local/share/
  sudo chown -R "$(whoami):staff" "$dir"
  sudo chmod -R 755 "$dir"
}

fix_insecure_compaudit "$@"
