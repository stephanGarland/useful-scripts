#!/bin/bash

export mac_check=$(uname) &> /dev/null
export distro=$(awk -F= '$1=="ID" {print $2}' /etc/*release || lsb_release -si) &> /dev/null

if [[ "$distro" =~ "debian" || "$distro" =~ "ubuntu" ]]; then
    export pakman="apt-get"
    export upd="update"
elif [[ "$distro" =~ "fedora" || "$distro" =~ "amzn" ]]; then
    export pakman="yum"
    export upd="update"
elif [[ "$distro" =~ "suse" ]]; then
    export pakman="zypper"
    export upd="refresh"
else
    export pakman="error"
fi
