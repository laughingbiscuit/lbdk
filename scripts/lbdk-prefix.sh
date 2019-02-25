#!/bin/bash
set -o xtrace
set -e
set -o pipefail 

LBDK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ARGS="$@"

# stub sudo if no argument is provided
if ! echo $ARGS | grep 'sudo' -q  ; then
	function sudo {
		"$@"
	}
fi

#scratch
#iwlwifi
