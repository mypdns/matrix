#!/usr/bin/env bash

#
# The purpose of this script is to import various eternal hosts files into lists
# that contain only domain.tld for easier working with the lists to our RPZ files
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


# Exit on any errors

set -e

# Check if we have root right to install the apps via apt

if [ "$(whoami)" != "root" ]; then
    echo "You need to be root to do this!"
    exit 1
fi

# To have this running on CI, will have to make sure all necessary
# packages is installed

# install apt package management system
# Install needed packages
export DEBIAN_FRONTEND=noninteractive
bash -c "$(curl -sL https://raw.githubusercontent.com/ilikenwf/apt-fast/master/quick-install.sh)"

apt-fast update -yqq
#apt-fastdist-upgrade -yqq
apt-fast install -yqq openssh-client ldnsutils
