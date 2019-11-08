#!/bin/bash

export mac_check=$(uname) &> /dev/null
export distro=$(grep -w ID /etc/os-release) &> /dev/null

if [[ $distro =~ "debian" || "ubuntu" ]]; then
    export pakman="apt-get"
    export upd="update"
elif [[ $distro =~ "fedora" ]]; then
    export pakman="yum"
    export upd="update"
elif [[ $distro =~ "suse" ]]; then
    export pakman="zypper"
    export upd="refresh"
else
    export pakman="error"
fi