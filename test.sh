#!/bin/bash
set -e
set -o pipefail

OPTS=${OPTS:-}
if [ -n "$2" ]; then
	OPTS="$2"
	shift;
fi

errors=()
srcs=$(git diff --cached --name-only --diff-filter=ACM HEAD | sort -u)

for sh in $srcs; do
	if file "$sh" | grep -qlE "POSIX shell|Bourne-Again shell script"; then
		{
			shellcheck "$OPTS" -f gcc "$sh"
		} || {
			errors+=("$sh")
		}
	fi
done

if [ ${#errors[@]} -gt 0 ]; then
    for e in "${errors[@]}"; do
        echo "$e" 1>&2
    done
	exit 1
fi
