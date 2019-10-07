#!/bin/bash

mac_check=`uname`
if [[ $mac_check == "Darwin" ]]; then
	which brew
	if [[ $? -eq 0 ]]; then
		printf "\nInstalling zsh using Homebrew\n"
		brew install zsh
	else
		printf "\nDo you want to install Homebrew (Y/N)? "
		read brew_install
		case ${brew_install} in
			([nN]) printf "\nPlease install zsh using whatever means you're comfortable with. Goodbye!" && exit 127 ;;
			([yY]) printf "\nInstalling Homebrew" && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" ;;
		esac
	fi
fi

which zsh
if [[ $? -eq 0 ]]; then
	printf "\nzsh already installed"
else
	distro=`cat /etc/os-release | grep -w ID`
	if [[ $distro =~ "debian" || "ubuntu" ]]; then
		printf "\nI will now ask for your sudo privileges to install zsh"
		# apt-get for backwards compatibility
		sudo apt-get update && sudo apt-get install -y zsh
	elif [[ $distro =~ "fedora" ]]; then
		printf "\nI will now ask for your sudo privileges to install zsh"
		sudo yum update && sudo yum install -y zsh
	elif [[ $distro =~ "suse" ]]; then
		printf "\nI will now ask for your sudo privileges to install zsh"
		sudo zypper refresh && sudo zypper install -y zsh
	else
		printf "\nSorry, your distro is not currently supported!"
		exit 127
	fi
fi

which git
if [[ $? -eq 0 ]]; then
	curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o install.sh
	chmod +x install.sh
	`./install.sh --unattended`
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	rm install.sh
	sed -i '/plugins=(git)/c\plugins=(git zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting)' ~/.zshrc
else
	printf "\nPlease install git and try again"
fi

sudo chsh -s `which zsh` `whoami` &> /dev/null
zsh
