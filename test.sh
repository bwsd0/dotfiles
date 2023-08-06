#!/bin/bash
set -eo pipefail
. ./bash/.env

modified="$(git diff --cached --name-only --diff-filter=ACM HEAD)"
if [ -z "$modified" ]; then
  exit 0
fi

echo "$modified" |
  sort -u  |
  xargs file |
  grep -E "POSIX shell|Bourne-Again shell script|*bash*" - |
  cut -d ':' -f1 |
  xargs shellcheck -x "$SHELLCHECK_OPTS" -f gcc

(
  tmpdir="$(mktemp -d)"
  trap 'rm -rf -- "$tmpdir"' EXIT
  make install DESTDIR="$tmpdir" 1> /dev/null
)
