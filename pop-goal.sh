#!/bin/bash

set -euo pipefail

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

sed -i "" -e "s/goals = [^:]* :: /goals = /" "$SCRIPTPATH/src/Data.elm"
