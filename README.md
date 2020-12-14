# useful-scripts

This is to rapidly setup a new environment / cloud host with the tools I like having, and some zsh plugins. If you find it useful and add to it, please submit a PR.

MacOS requires Homebrew (it'll install it for you if you don't have it), and also downloads and symlinks gnu-sed as sed, because BSD sed doesn't handle in-place with \c very well. If you don't want it afterwards, rm /usr/local/bin/sed to delete the symlink, and brew remove gnu-sed to remove the package.

Run `main.sh` to install/check for everything (currently curl, git, glances, htop, micro, mc, ncdu, smartmontools, tree, and zsh). Checking for git after having git cloned is largely redundant, yes, but I figured I'd include it on the off-chance it was somehow removed after cloning the repo, or if this script was installed by other means.

There's an optional switch for using this with cloud-init or similar tools - if you call `main.sh` with the first arg `unattended`, there is no user interaction required, and this script does not attempt to update any system packages - it's assumed you'll handle that separately.

If you'd just like zsh/oh-my-zsh, you can `source check_env.sh` and then run `zsh_setup.sh`.

This has been tested on Amazon Linux, Debian, CentOS, Fedora, Raspbian, RHEL, SuSE, and Ubuntu. You can see what it's checking for in `check_env.sh`; if your distro is missing, please submit a PR.
