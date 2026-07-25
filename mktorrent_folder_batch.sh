#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 -a TRACKER [-o OUTPUT] ROOT [ROOT ...]" >&2
  exit 2
}

tracker=""; output=""
while getopts ":a:o:" opt; do
  case "$opt" in a) tracker="$OPTARG" ;; o) output="$OPTARG" ;; *) usage ;; esac
done
shift $((OPTIND - 1))
[[ -n "$tracker" && $# -gt 0 ]] || usage
command -v mktorrent >/dev/null || { echo "mktorrent is required" >&2; exit 1; }

for root in "$@"; do
  [[ -d "$root" ]] || { echo "Skipped missing root: $root" >&2; continue; }
  target="${output:-$root/torrents}"
  mkdir -p "$target"
  while IFS= read -r -d '' folder; do
    torrent="$target/$(basename "$folder").torrent"
    [[ -e "$torrent" ]] && { echo "Exists, skipped: $torrent"; continue; }
    mktorrent -a "$tracker" -x '*.DS_Store' -x '@eaDir' -x '@eaDir/*' -x '._*' -x 'Thumbs.db' -o "$torrent" "$folder"
    echo "Created: $torrent"
  done < <(find "$root" -mindepth 1 -maxdepth 1 -type d ! -name torrents -print0)
done
