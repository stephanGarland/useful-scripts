#!/bin/bash

if [[ $distro =~ "mac" ]]; then
	if [[ $brew_check =~ "no" ]]; then
		printf "\nPlease install Homebrew first. Goodbye!" && exit 127 ;
	fi
	else
		printf "\nInstalling zsh using Homebrew\n"
		brew install zsh
fi

if [[ $pack_pack =~ "no" ]]; then
	printf "\nSorry, your distro is not currently supported!"
	exit 127
else
	$pack install -y zsh
fi

if [[ $(command -v git) -eq 0 ]]; then
	curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o install.sh
	chmod +x install.sh
	./install.sh --unattended
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	rm install.sh
	sed -i "/plugins=(git)/c\plugins=(git thefuck zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting)" ~/.zshrc
	echo "eval $(thefuck --alias)" >> ~/.zshrc
else
	printf "\nPlease install git and try again"
fi

sudo chsh -s $(zsh) $(whoami) &> /dev/null
zsh
