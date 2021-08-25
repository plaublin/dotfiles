" My ~/.vimrc file


" disable vi compatible mode
set nocompatible

" display line numbers
set number

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

" enable the mouse
if has('mouse')
	set mouse=a
endif

" indentation
filetype plugin indent on
set shiftwidth=3
set tabstop=3
set softtabstop=3
set noexpandtab

" colors in a dark terminal
if !has("gui_running")
	set background=dark
endif

if has("vms")
	set nobackup		" do not keep a backup file, use versions instead
else
	set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set showcmd		" display incomplete commands

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" show correspondign parrenthesis
set showmatch

" grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" search (incremental, ignore case)
set incsearch
set ignorecase

if has("autocmd")
	" when reopening a file, go back to the position from where we closed it
	autocmd BufReadPost *
				\ if line("'\"") > 0 && line("'\"") <= line("$") |
				\   exe "normal g`\"" |
				\ endif

	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on

	" For all text files set 'textwidth' to 80 characters.
	" autocmd FileType text setlocal textwidth=80
else
	set autoindent		" always set autoindenting on
endif

" vim-plug
if has('nvim')
	call plug#begin('~/.config/nvim/plugged')
else
	call plug#begin('~/.vim/plugged')
endif

" alternate files in vim quickly (.c -> .h etc); :help alternate
Plug 'https://github.com/vim-scripts/a.vim'

" code-completion, :help ycm
Plug 'https://github.com/Valloric/YouCompleteMe.git'

" provides mappings to easily delete, change and add paired "surroundings",
" :help surround 
Plug 'git://github.com/tpope/vim-surround.git'

" automatic syntax checking, :help syntastic
Plug 'https://github.com/scrooloose/syntastic.git'

" rust syntax
Plug 'https://github.com/rust-lang/rust.vim.git'

" displays tags in a window, ordered by class, etc., :help tagbar
Plug 'https://github.com/majutsushi/tagbar.git'

" need to install coc for rust-analyzer
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" youcompleteme
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
"let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion = ['<Up>']
" close the preview window after leaving insert mode
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0

" tagbar
nmap <F8> :TagbarToggle<CR>
