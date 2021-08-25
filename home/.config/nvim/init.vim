set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

set clipboard+=unnamedplus
map <Leader>y "*y
map <Leader>p "*p

set nofoldenable    " disable folding
