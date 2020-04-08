#!/bin/bash

sudo "$pakman $upd"
printf "\nInstalling/checking git, htop, micro, mc, and tree\n"
sudo "$pakman" install -y git htop mc tree

curl -fsSl https://getmic.ro | bash
sudo mv micro /usr/local/bin