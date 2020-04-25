#!/bin/bash

set -euo pipefail

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
date1=$(($(gdate +%s) + $1 * 60));

sed -i "" -e "s/startAt = .*/startAt = Time.millisToPosix ${date1}000/" "$SCRIPTPATH/src/Data.elm"
