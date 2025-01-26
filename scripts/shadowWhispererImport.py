#  <Program Name>: <Brief Description of the Program>
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

import csv
import os


def read_csv(file_path):
    with open(file_path, 'r') as file:
        return set(line.strip() for line in file)


def main():
    adult_list = read_csv('source/porn_filters/imported/adult.ShadowWhisperer')
    explicit_content = read_csv(
        'source/porn_filters/explicit_content/wildcard.csv')
    strict_filters = read_csv(
        'source/strict_filters/wildcard.csv') if os.path.exists(
        'source/strict_filters/wildcard.csv') else set()

    unique_lines = adult_list - explicit_content - strict_filters

    with open('source/porn_filters/imported/adult.ShadowWhisperer.unique',
              'w') as output_file:
        for line in unique_lines:
            output_file.write(line + '\n')


if __name__ == "__main__":
    main()
