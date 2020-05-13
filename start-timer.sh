#!/bin/bash

set -euo pipefail

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
newStart="Time.millisToPosix $(date +%s)000"

echo "        |> Timer.startTimer ($newStart)" >> "$SCRIPTPATH/src/Data/Timer.elm"
