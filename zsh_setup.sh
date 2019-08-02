#!/bin/bash

mac_check=`uname`
if [[ $mac_check == "Darwin" ]]; then
	echo "Please install zsh using Homebrew or a similar package manager"
	exit 127 # command not found, since the next command would fail
fi

which zsh
if [[ $? -eq 0 ]]; then
	echo "zsh already installed"
else
	distro=`cat /etc/os-release | grep ID_LIKE`
	if [[ $distro =~ "debian" ]]; then
		echo "\nI will now ask for your sudo privileges to install zsh"
		# apt-get for backwards compatibility
		sudo apt-get update && sudo apt-get install -y zsh
	elif [[ $distro =~ "fedora" ]]; then
		echo "\nI will now ask for your sudo privileges to install zsh"
		sudo yum update && sudo yum install -y zsh
	elif [[ $distro =~ "suse" ]]; then
		echo "\nI will now ask for your sudo privileges to install zsh"
		sudo zypper refresh && sudo zypper install -y zsh
	fi
fi

which git
if [[ $? -eq 0 ]]; then
	wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
	chmod +x install.sh
	`./install.sh --unattended`
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	rm install.sh
	sed -i '/plugins=(git)/c\plugins=(git zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting)' ~/.zshrc
else
	echo "\nPlease install git and try again"
fi
