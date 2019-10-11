#!/bin/bash

function install_prereqs() {
	if [[ $distro =~ "mac" ]]; then
		printf "\nInstalling git, gnu-sed, jq, tmux\n"
		brew install gsed jq tmux
		printf "\nSymlinking gsed to sed\n"
		ln -s /usr/local/bin/gsed /usr/local/bin/sed
	fi
	
	distro=$(grep -w ID /etc/os-release)
	if [[ $distro =~ "debian" || "ubuntu" ]]; then
		# apt-get for backwards compatibility
		pack='sudo apt-get '
	elif [[ $distro =~ "fedora" ]]; then
		pack='sudo yum update '
	elif [[ $distro =~ "suse" ]]; then
		pack='sudo zypper refresh '
	else
		printf "\nSorry, your distro is not currently supported!"
		pack_check='no'
		exit 127
	fi
	
	printf "\nInstalling curl, git, jq, and tmux\n"
	$pack install -y curl git jq tmux
	printf "\nInstalling pip and python3\n"
	if [[ $(command -v python3) -eq 0 ]]; then
		$pack install -y python3-pip
	else
		$pack install -y python3 python3-pip
	fi

	export distro
	export pack
	export pack_check
}

mac_check=$(uname)
if [[ $mac_check == "Darwin" ]]; then
	distro='mac'
	if [[ ! $(command -v brew) -eq 0 ]]; then
		printf "\nDo you want to install Homebrew (Y/N)? "
		read brew_install
		case ${brew_install} in
			([nN]) printf "\nGoodbye!" && brew_check='no' && exit 127 ;;
			([yY]) printf "\nInstalling Homebrew" && \
				/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && \
				brew_check='yes' ;;
		esac
	fi
	export brew_check
	export distro
fi

install_prereqs
