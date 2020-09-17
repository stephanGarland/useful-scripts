#!/bin/bash

sudo $pakman $upd
if [[ $cloudinit != "unattended" ]]; then
    read -p "Do you want to upgrade all packages (Y/N)? " -n 1 -r

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo $pakman $upg -y
    else
        printf"\nOK, skipping update"
    fi
    printf "\nInstalling/checking git, glances, htop, micro, mc, ncdu, and tree\n"
fi

sudo "$pakman" install -y git glances htop mc ncdu tree zsh

curl -fsSl https://getmic.ro | bash
sudo mv micro /usr/local/bin
