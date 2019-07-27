#!/bin/bash

mac_check = `uname`
if [[ $mac_check == "Darwin" ]]; then
	echo "Please install zsh using Homebrew or a similar package manager"
	exit 127 # command not found, since the next command would fail
fi

zsh_check = `which zsh`
if [[ $zsh_check -eq 0 ]]; then
	echo "zsh already installed"
else
	distro = `cat /etc/os-release | grep ID_LIKE`
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
git_check = `which git`
if [[ $ git_check -eq 0 ]]; then
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/install.sh -O -)"
	git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}:~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

	sed '/plugins=/s/.*/plugins=(git zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting)' ~/.zshrc
else
	echo "\nGit not found, installing"
	if [[ $distro =~ "debian" ]]; then
		sudo apt-get install -y git
	elif [[ $distro =~ "fedora" ]]; then
		sudo yum install -y git
	elif [[ $distro =~ "suse" ]]; then
		sudo zypper install -y git
fi
