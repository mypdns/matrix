#!/usr/bin/env bash
#
# Source List Builder: Generate a deduplicated CSV of active source URLs from repository data
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

REPO_REMOTE="${REPO_REMOTE:-https://raw.githubusercontent.com/mypdns/matrix/master}"
OUTPUT_DIR="${OUTPUT_DIR:-source}"
OUTPUT_FILE="${OUTPUT_FILE:-$OUTPUT_DIR/source.csv}"
SEARCH_DIRS="${SEARCH_DIRS:-source}"
PATTERNS="${PATTERNS:-*.csv}"

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [ -z "$REPO_ROOT" ]; then
  printf 'Error: not in a git repository\n' >&2
  exit 1
fi

mkdir -p "$REPO_ROOT/$OUTPUT_DIR"

TEMP_FILE="$(mktemp --tmpdir="$(pwd)" source.csv.XXXXXX)"
cleanup() { rm -f "$TEMP_FILE"; }
trap cleanup EXIT

(
  cd "$REPO_ROOT" || exit 1
  find $SEARCH_DIRS -type f $ -false $(for p in $PATTERNS; do printf " -o -name %s" "$p"; done) $ -print 2>/dev/null |
    sed 's|^\./||' |
    awk -v base="$REPO_REMOTE" '{ print base "/" $0 }' |
    sort -u
) > "$TEMP_FILE"

mv "$TEMP_FILE" "$REPO_ROOT/$OUTPUT_FILE"
ls -lh "$REPO_ROOT/$OUTPUT_FILE"
