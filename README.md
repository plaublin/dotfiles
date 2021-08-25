# vimrc configuration

## Plugins

	* vim-plug: to manage the plugins
	* vim-a: open alternate files quickly
	* YouCompleteMe: code completion
	* vim-surround: easily add surroundings
	* syntastic: automatic syntax checking
	* rust.vim: rust syntax
	* tagbar: displays tags in a window

## Installation

	1. Clone the repository
	2. Launch vim and execute `:PlugInstall`
	3. Install `cmake`, `python-dev` and `python3-dev` in order to compile YouCompleteMe
	4. Go to `.vim/plugged/YouCompleteMe` and execute `./install.py --clang-completer`
	5. Install `exuberant-ctags`, e.g., `sudo aptitude install exuberant-ctags`
