#!/usr/bin/env bash

#
# CI Shellcheck Runner: Find and run shellcheck on all shell scripts in the repo
# Copyright (C) 2025. @spirillen, My Privacy DNS - Matrix
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
#

set -euo pipefail

# Ensure we're in project root (CI_PROJECT_DIR should be set in CI)
: "${CI_PROJECT_DIR:=.}"
cd "$CI_PROJECT_DIR"

# Check that shellcheck is installed
if ! command -v shellcheck >/dev/null 2>&1; then
  printf 'Error: shellcheck is not installed.\n' >&2
  exit 2
fi

# Collect shell files with common extensions and executable files with a shebang
# Exclude .git and vendor directories commonly present in projects
mapfile -t files < <(find . -path './.git' -prune -o -path './vendor' -prune -o \
  -type f $ -name '*.sh' -o -name '*.bash' -o -name '*.profile' -o -name '*.zsh' $ -print -o \
  -type f -executable -print | sort -u)

# Also filter files that contain a shebang (to avoid non-shell executables)
sh_files=()
for f in "${files[@]}"; do
  if head -n 1 "$f" 2>/dev/null | grep -qE '^#!.*(sh|bash|dash|ksh|zsh)'; then
    sh_files+=("$f")
  fi
done

if [ "${#sh_files[@]}" -eq 0 ]; then
  printf "No shell scripts found to lint.\n"
  exit 0
fi

# Run shellcheck in parallel where available for speed, otherwise sequentially
if command -v xargs >/dev/null 2>&1 && xargs --help 2>&1 | grep -q -- '--max-procs'; then
  printf "Running shellcheck on %d files (parallel)...\n" "${#sh_files[@]}"
  printf '%s\0' "${sh_files[@]}" | xargs -0 -n1 -P"$(nproc 2>/dev/null || echo 4)" shellcheck
else
  printf "Running shellcheck on %d files (sequential)...\n" "${#sh_files[@]}"
  for f in "${sh_files[@]}"; do
    shellcheck "$f"
  done
fi

printf "Shellcheck completed.\n"
