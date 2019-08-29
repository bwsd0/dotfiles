#!/bin/bash
set -e
set -o pipefail

errors=()

for f in $(find . -type f -not -path '*.git*' | sort -u); do
	if file "$f" | grep -q -E "POSIX shell|Bourne-Again shell script"; then
		{
			shellcheck "$f"
		} || {
			errors+=("$f")
		}
	fi
done

if [ ${#errors[@]} -gt 0 ]; then
    for e in "${errors[@]}"; do
        echo "$e" 1>&2
    done
	exit 1
fi
