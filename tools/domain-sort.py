#!/usr/bin/env python3

# Domain Sorter: stable, deduplicating, memory-efficient domain sorter
#  Copyright (C) 2025. My Privacy DNS
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU Affero General Public License as
#  published by the Free Software Foundation, either version 3 of the
#  License, or (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU Affero General Public License for more details.
#
#  You should have received a copy of the GNU Affero General Public License
#  along with this program. If not, see <https://www.gnu.org/licenses/>.

# cat file.txt | cat source/tracking/domains.list | ./tools/domain-sort.py


"""
Domain Sorter: read domains from stdin or files, normalize, deduplicate,
and print them sorted by TLD-first (reverse-label) order.

Usage:
  cat file.txt | ./tools/domain-sort.py
  ./tools/domain-sort.py file1 file2
"""

from fileinput import input

for y in sorted([x.strip().split('.')[::-1] for x in input()]): print(
    '.'.join(y[::-1]))
