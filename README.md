# useful-scripts

Mostly used by me with Terraform to get what I want in a sandbox environment, but if you want an easy way to get a great CLI editor and zsh (with plugins to make it like fish) installed, be my guest. Note that for MacOS, it requires Homebrew (it'll install it for you if you don't have it), and also downloads and symlinks gnu-sed as sed, because BSD sed doesn't handle in-place with \c very well. If you don't want it afterwards, rm /usr/local/bin/sed to delete the symlink, and brew remove gnu-sed to remove the package.

Run master.sh if you want both micro (world's greatest CLI editor; vi and emacs can have their war) and zsh installed.

Run the other two on their own if you want what they're offering.

zsh_setup works on anything declaring itself as "fedora", "debian," or "suse" in /etc/os.release, e.g. Red Hat/Fedora, Debian/Ubuntu, SuSE, AWS Linux, etc. as well as Darwin (MacOS). If you want to add functionality for something else, by all means, submit a PR.

get_micro works on anything that has curl. Probably. x86, amd64, and arm work.
