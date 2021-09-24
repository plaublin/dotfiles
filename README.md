# vimrc configuration

## Quick install

This should work on Ubunt 20.04.
```
# install important stuff
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt install fd-find neovim fzf
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# nvim configuration
git clone git@github.com:plaublin/dotfiles.git
ln -s dotfiles/home/.vimrc
ln -s dotfiles/home/.vim
mkdir .config
ln -s ~/dotfiles/home/.config/nvim ~/.config/nvim

# update the .bashrc
cat << 'EOF' >> .bashrc

alias fd=fdfind
alias vim=nvim

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

function j(){
    jobs | wc -l | egrep -v ^0 | sed -r 's/^([0-9]+)/ (\1)/'
}

PROMPT_COMMAND=__prompt_command # Func to gen PS1 after CMDs

[ -f /etc/bash_completion.d/git-prompt ] && source /etc/bash_completion.d/git-prompt
[ -f /usr/share/git/completion/git-prompt.sh ] && source /usr/share/git/completion/git-prompt.sh

__prompt_command() {
        local EXIT="$?" # This needs to be first
        PS1=""

        local RCol='\[\e[0m\]'
        local Red='\e[0;31m'
        local Gre='\e[0;32m'
        local Blu='\e[1;34m'

        PS1+="${Gre}\u@\h$(j)${RCol}: ${Red}\w${Blu}$(__git_ps1)"
        if [ $EXIT != 0 ]; then
                PS1+="$Red \342\234\226 (${EXIT})"
        else
                PS1+="$Gre \342\234\224"
        fi
        PS1+="$RCol\n> "
}

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM=auto

EOF
source .bashrc

# need to launch vim and execute :PlugInstall
echo "Please launch vim and execute :PlugInstall"
```

## Dependencies

### fd

https://github.com/sharkdp/fd

Archlinux: `sudo pacman -S fd`
Ubuntu: `sudo apt-get install fd-find`, then add an alias: `alias fd=fdfind`

### proximity-sort

https://github.com/jonhoo/proximity-sort

## Installation

	1. Clone the repository
	2. Launch vim and execute `:PlugInstall`
