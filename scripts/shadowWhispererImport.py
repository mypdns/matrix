#!/usr/bin/env python3
#
# ShadowWhisperer Unique Extractor: produce unique adult blocklist entries not covered by explicit/strict filters
# Copyright (C) 2025. My Privacy DNS
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see https://www.gnu.org/licenses/.
#

"""
ShadowWhisperer Unique Extractor:
Read the ShadowWhisperer adult blocklist and write entries that are not
present in explicit_content or strict_filters to a .unique file.

Improved for:
- robust file handling and explicit text encoding (utf-8)
- memory-efficient streaming for large files
- stable, sorted output for reproducible commits
- clear logging and exit codes for CI/crons
"""

from pathlib import Path
import sys
import argparse
import logging

logging.basicConfig(level=logging.INFO, format="%(message)s")
logger = logging.getLogger(__name__)

DEFAULT_ADULT = Path("source/porn_filters/imported/adult.ShadowWhisperer")
DEFAULT_EXPLICIT = Path("source/porn_filters/explicit_content/wildcard.csv")
DEFAULT_STRICT = Path("source/strict_filters/wildcard.csv")
DEFAULT_OUT = DEFAULT_ADULT.with_suffix(DEFAULT_ADULT.suffix + ".unique")

def read_lines(path: Path):
    """Yield normalized non-empty lines from path (utf-8)."""
    if not path.exists():
        return
    with path.open("r", encoding="utf-8", errors="replace") as fh:
        for raw in fh:
            line = raw.strip()
            if line:
                yield line

def load_set(path: Path):
    return set(read_lines(path))

def main(argv=None):
    p = argparse.ArgumentParser(description="Extract unique ShadowWhisperer entries")
    p.add_argument("--adult", type=Path, default=DEFAULT_ADULT)
    p.add_argument("--explicit", type=Path, default=DEFAULT_EXPLICIT)
    p.add_argument("--strict", type=Path, default=DEFAULT_STRICT)
    p.add_argument("--out", type=Path, default=DEFAULT_OUT)
    p.add_argument("--sort", action="store_true", help="Sort output for reproducible results")
    args = p.parse_args(argv)

    if not args.adult.exists():
        logger.error("Adult source not found: %s", args.adult)
        return 2

    explicit = load_set(args.explicit) if args.explicit.exists() else set()
    strict = load_set(args.strict) if args.strict.exists() else set()

    # Stream adult file and write only uniques to avoid large temporary sets when possible
    uniques = []
    seen = set()
    for line in read_lines(args.adult):
        if line in seen:
            continue
        seen.add(line)
        if (line not in explicit) and (line not in strict):
            uniques.append(line)

    if args.sort:
        uniques.sort()

    args.out.parent.mkdir(parents=True, exist_ok=True)
    tmp = args.out.with_suffix(args.out.suffix + ".tmp")
    with tmp.open("w", encoding="utf-8", newline="\n") as fh:
        for line in uniques:
            fh.write(line + "\n")
    tmp.replace(args.out)  # atomic-ish on same filesystem

    logger.info("Wrote %d unique lines to %s", len(uniques), args.out)
    return 0

if __name__ == "__main__":
    sys.exit(main())
