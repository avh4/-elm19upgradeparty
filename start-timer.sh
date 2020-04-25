#!/bin/bash

set -euo pipefail

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
newStart="Time.millisToPosix $(date +%s)000"

# create the timer if there isn't one
sed -i "" -e "s/timer = Nothing/timer = Just (lastTime 0 0 0 0, Nothing)/" "$SCRIPTPATH/src/Data.elm"
# unpause the timer if there is one
sed -i "" -e "s/timer = Just (\([^,]*\), Nothing/timer = Just (\1, Just <| $newStart/" "$SCRIPTPATH/src/Data.elm"
