#!/bin/bash

set -euo pipefail

date1=$(($(gdate +%s) + $1 * 60));

sed -i "" -e "s/startAt = .*/startAt = Time.millisToPosix ${date1}000/" src/Data.elm
