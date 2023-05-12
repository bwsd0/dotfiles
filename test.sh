#!/bin/bash
set -eo pipefail
. ./bash/.env

git diff --cached --name-only --diff-filter=ACM HEAD |
	sort -u |
	xargs file |
	grep -E "POSIX shell|Bourne-Again shell script|*bash*" - |
	cut -d ':' -f1 |
	xargs shellcheck "$SHELLCHECK_OPTS" -f gcc
