#!/usr/bin/env bash

#
# MyPrivacyDNS-CI: Commit and push current changes from CI runner
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

# Ensure running in CI environment and CI_PROJECT_DIR exists
: "${CI_PROJECT_DIR:?CI_PROJECT_DIR must be set}"
cd "$CI_PROJECT_DIR"

# Make git operations safe in CI
git config user.name "${GIT_AUTHOR_NAME:-ci-bot}"
git config user.email "${GIT_AUTHOR_EMAIL:-ci-bot@example.com}"

# Abort if there is nothing to commit
if git diff --quiet --ignore-submodules -- && git diff --cached --quiet --ignore-submodules --; then
  printf "No changes to commit.\n"
  exit 0
fi

# Prefer explicit ref (fallback to CI_COMMIT_REF_NAME)
ref="${CI_COMMIT_REF_NAME:-${GIT_BRANCH:-master}}"

# Use a short, descriptive commit message; avoid push if empty
commit_msg="${CI_COMMIT_MESSAGE:-Auto committed from the CI runner [skip ci]}"

# Attempt commit & push with retries for transient network errors
git add -A

# Show status for debugging
git status --porcelain

# Create commit if needed
if git commit -m "$commit_msg"; then
  printf "Committed changes: %s\n" "$commit_msg"
else
  printf "Nothing committed (maybe no staged changes).\n"
fi

# Push with retry
push_remote="${CI_REMOTE_NAME:-origin}"
push_attempts=3
push_delay=5

for i in $(seq 1 $push_attempts); do
  if git push -u "$push_remote" "$ref"; then
    printf "\nPushed to %s/%s\n\n" "$push_remote" "$ref"
    break
  else
    if [ "$i" -lt "$push_attempts" ]; then
      printf "Push failed, retrying in %s seconds (attempt %d/%d)...\n" "$push_delay" "$i" "$push_attempts"
      sleep "$push_delay"
      push_delay=$((push_delay * 2))
    else
      printf "Push failed after %d attempts.\n" "$push_attempts" >&2
      exit 1
    fi
  fi
done

# Optionally trigger downstream pipelines if tokens provided
if [ -n "${HOSTS_TRIGGER_TOKEN-}" ] && [ -n "${HOSTS_PROJECT_ID-}" ]; then
  curl --fail -sS -X POST "https://gitlab.com/api/v4/projects/${HOSTS_PROJECT_ID}/trigger/pipeline" \
    -F "token=${HOSTS_TRIGGER_TOKEN}" -F "ref=master" || printf "Trigger hosts pipeline failed\n"
fi

if [ -n "${UNBOUND_TRIGGER_TOKEN-}" ] && [ -n "${UNBOUND_PROJECT_ID-}" ]; then
  curl --fail -sS -X POST "https://gitlab.com/api/v4/projects/${UNBOUND_PROJECT_ID}/trigger/pipeline" \
    -F "token=${UNBOUND_TRIGGER_TOKEN}" -F "ref=matrix" || printf "Trigger unbound pipeline failed\n"
fi

exit 0
