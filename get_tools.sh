#!/bin/bash

read -p "Do you want to update all packages (Y/N)?" updateCheck
case $updateCheck in
    [Yy]*) sudo "$pakman" "$upd" -y
    [Nn]*) printf"\nOK, skipping update"
esac
printf "\nInstalling/checking git, htop, micro, mc, and tree\n"
sudo "$pakman" install -y git htop mc tree

curl -fsSl https://getmic.ro | bash
sudo mv micro /usr/local/bin
