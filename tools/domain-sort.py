#!/usr/bin/env python3.11

# cat file.txt | cat source/tracking/domains.list | ./tools/domain-sort.py

from fileinput import input

for y in sorted([x.strip().split('.')[::-1] for x in input()]): print(
    '.'.join(y[::-1]))
