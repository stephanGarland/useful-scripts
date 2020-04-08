#!/bin/bash

read -p "Do you want to update all packages (Y/N)? " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]] then
    sudo "$pakman" "$upd" -y
else
    printf"\nOK, skipping update"
fi
printf "\nInstalling/checking git, htop, micro, mc, and tree\n"
sudo "$pakman" install -y git htop mc tree

curl -fsSl https://getmic.ro | bash
sudo mv micro /usr/local/bin
