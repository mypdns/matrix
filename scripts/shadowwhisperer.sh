#!/bin/sh

#
# Git Auto-Updater: Pull repository, refresh ShadowWhisperer Adult blacklist, commit & push
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

set -eu

# Intended to be run from cron. Requires git, wget (or curl) and network access.
# Configure these environment variables when used in CI/cron if paths/refs differ:
#   GIT_REMOTE (default: origin)
#   GIT_BRANCH (default: master)
#   BLACKLIST_URL (default: https://raw.githubusercontent.com/ShadowWhisperer/BlockLists/master/RAW/Adult)
#   DEST_PATH (default: source/porn_filters/imported/adult.ShadowWhisperer)

GIT_REMOTE="${GIT_REMOTE:-origin}"
GIT_BRANCH="${GIT_BRANCH:-master}"
BLACKLIST_URL="${BLACKLIST_URL:-https://raw.githubusercontent.com/ShadowWhisperer/BlockLists/master/RAW/Adult}"
DEST_PATH="${DEST_PATH:-source/porn_filters/imported/adult.ShadowWhisperer}"

# Resolve repo root
if ! GIT_DIR="$(git rev-parse --show-toplevel 2>/dev/null)"; then
  printf 'Error: not inside a git repository\n' >&2
  exit 1
fi

cd "$GIT_DIR"

# Ensure working tree is clean before attempting changes
if ! git diff --quiet || ! git diff --cached --quiet; then
  printf 'Working tree has uncommitted changes; aborting to avoid conflicts\n' >&2
  exit 2
fi

# Update from remote
if ! git fetch "$GIT_REMOTE" "$GIT_BRANCH"; then
  printf 'Error: git fetch failed\n' >&2
  exit 3
fi

if ! git reset --hard "$GIT_REMOTE/$GIT_BRANCH"; then
  printf 'Error: git reset failed\n' >&2
  exit 4
fi

# Create destination directory if needed
mkdir -p "$(dirname "$DEST_PATH")"

# Download blacklist (prefer curl if available)
if command -v curl >/dev/null 2>&1; then
  if ! curl -fsSL "$BLACKLIST_URL" -o "$DEST_PATH"; then
    printf 'Error: failed to download blacklist with curl\n' >&2
    exit 5
  fi
elif command -v wget >/dev/null 2>&1; then
  if ! wget -q -O "$DEST_PATH" "$BLACKLIST_URL"; then
    printf 'Error: failed to download blacklist with wget\n' >&2
    exit 5
  fi
else
  printf 'Error: neither curl nor wget is available to download blacklist\n' >&2
  exit 6
fi

# Only commit if there are changes
if git add "$DEST_PATH" && git diff --cached --quiet; then
  printf 'No changes to blacklist; nothing to commit.\n'
  exit 0
fi

commit_msg="Update ShadowWhisperer Adult list: $(date -u +%Y-%m-%dT%H:%M:%SZ)"

if ! git commit -m "$commit_msg"; then
  printf 'Error: git commit failed\n' >&2
  exit 7
fi

# Push with simple retry for transient failures
push_attempts=3
delay=5
i=1
while [ "$i" -le "$push_attempts" ]; do
  if git push "$GIT_REMOTE" "HEAD:$GIT_BRANCH"; then
    printf 'Successfully pushed updates.\n'
    exit 0
  fi
  printf 'Push failed, retrying in %s seconds (%d/%d)\n' "$delay" "$i" "$push_attempts" >&2
  sleep "$delay"
  i=$((i + 1))
  delay=$((delay * 2))
done

printf 'Error: failed to push after retries\n' >&2
exit 8
