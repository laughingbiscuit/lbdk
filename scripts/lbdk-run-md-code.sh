#!/bin/bash

set -e

#arg1 as filename
FILENAME="${1:-}"

sed -n '/^```/,/^```/ p' $FILENAME | sed '/^```/ d'
