#!/bin/bash

set -euo pipefail

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
stopTime="Time.millisToPosix $(date +%s)000"

echo "        |> Timer.stopTimer ($stopTime)" >> "$SCRIPTPATH/src/Data/Timer.elm"
