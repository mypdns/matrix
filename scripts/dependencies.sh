#!/usr/bin/env bash

# The perpose of this script is to import various eternal hosts files into lists
# that contail only domain.tld for easier working with the lists to our RPZ files

# Exit on any erros

set -e

# Check if we have root right to install the apps via apt

if [ `whoami` != "root" ]
    then
    echo "You need to be root to do this!"
    exit 1
fi

# To have this running on CI, will have to make sure all nessesary
# packages is installed

# install apt pakage manement system
# Install needed packages
export DEBIAN_FRONTEND=noninteractive
bash -c "$(curl -sL https://raw.githubusercontent.com/ilikenwf/apt-fast/master/quick-install.sh)"

apt-fast update -yqq
#apt-fastdist-upgrade -yqq
apt-fast install -yqq openssh-client ldnsutils
