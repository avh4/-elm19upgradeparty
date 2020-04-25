#!/bin/bash

set -euo pipefail

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

sed -i "" -e "s/timer = Nothing/timer = Just (lastTime 0 0 0 0, Time.millisToPosix $(date +%s)000)/" "$SCRIPTPATH/src/Data.elm"
