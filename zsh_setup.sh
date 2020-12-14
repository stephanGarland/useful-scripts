#!/usr/bin/env bash

if [[ $mac_check == Darwin ]]; then
	command -v brew &> /dev/null
	if [[ $? -eq 0 ]]; then
		printf "\nInstalling zsh using Homebrew\n"
		brew install zsh
		printf "\nInstalling gnu-sed using Homebrew\n"
		brew install gnu-sed
		printf "\nSymlinking gsed to sed\n"
		ln -s /usr/local/bin/gsed /usr/local/bin/sed
	else
		printf "\nDo you want to install Homebrew (Y/N)? "
		read brew_install
		case ${brew_install} in
			([nN]) printf "\nPlease install zsh using whatever means you're comfortable with. Goodbye!" && exit 127 ;;
			([yY]) printf "\nInstalling Homebrew" && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" ;;
		esac
	fi
fi

command -v zsh &> /dev/null
if [[ $? -eq 0 ]]; then
	printf "\nzsh already installed"
else
    if [[ $pakman == error ]]; then
        printf "\nSorry, your distro is not currently supported!"
        exit 127
    fi
	sudo $pakman install -y zsh
fi

command -v git &> /dev/null
if [[ $? -eq 0 ]]; then
	curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o ./install.sh
	chmod +x install.sh
	$(./install.sh --unattended)
	git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
	rm install.sh
	
	sed -i'' '/plugins=(git)/c\plugins=(colored-man-pages git gitignore wd web-search you-should-use zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting)' ~/.zshrc
	sed -i'' '/plugins=(colored/a \\nexport YSU_MESSAGE_FORMAT="$(tput setaf 1)Use %alias instead of %command $(tput sgr0)"' ~/.zshrc
	sed -i'' '/export YSU/a \\nexport ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#586e75"' ~/.zshrc
	sed -i'' '/ZSH_THEME=/c\ZSH_THEME="powerlevel10k/powerlevel10k"' ~/.zshrc
	sed -i'' '/ZSH_THEME=/a \\nPOWERLEVEL9K_MODE="awesome-patched"' ~/.zshrc
else
	printf "\nPlease install git and try again"
fi

printf "\nChanging your shell to zsh\n"

if [[ $mac_check == Darwin ]]; then
    sudo dscl . -delete /Users/$(whoami) UserShell
    sudo dscl . -append /Users/$(whoami) /bin/zsh
else
    sudo usermod --shell $(which zsh) $(whoami)
fi

zsh
