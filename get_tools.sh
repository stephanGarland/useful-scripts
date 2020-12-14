#!/usr/bin/env bash

sudo $pakman $upd
if [[ $cloudinit != "unattended" ]]; then
    read -p "Do you want to upgrade all packages (Y/N)? " -n 1 -r

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo $pakman $upg -y
    else
        printf"\nOK, skipping update"
    fi
    printf "\nInstalling/checking curl, git, glances, htop, micro, mc, ncdu, smartmontools, tree, and zsh\n"
fi

sudo $pakman install -y curl git glances htop mc ncdu smartmontools tree zsh

curl -fsSl https://getmic.ro | bash
sudo mv micro /usr/local/bin
