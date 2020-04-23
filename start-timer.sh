#!/bin/bash

set -euo pipefail

sed -i "" -e "s/timer = Nothing/timer = Just (lastTime 0 0 0 0, Time.millisToPosix $(date +%s)000)/" src/Data.elm
