#!/bin/bash
# Runs make in Launcher/ under devkitPro's MSYS2. Invoked by .vscode/tasks.json.
# Usage: build.sh [make args...]
set -o pipefail

export DEVKITPRO=/opt/devkitpro
export DEVKITPPC=/opt/devkitpro/devkitPPC

script_dir="$(dirname "$(cygpath -u "$0")")"
cd "$script_dir/../Launcher" || exit 1

# Rewrite /c/... paths in compiler output to C:/... so VS Code can link errors
make "$@" 2>&1 | sed -u -E 's#(^|[[:space:]])/([a-zA-Z])/#\1\2:/#g'
