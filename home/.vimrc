" inspired by many vimrc, mainly:
"	https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim
"	https://github.com/padawin/dotfiles/blob/master/.vimrc

set nocompatible
filetype off

" vim-plug
if has('nvim')
	call plug#begin('~/.config/nvim/plugged')
else
	call plug#begin('~/.vim/plugged')
endif

" a beautiful lightline
Plug 'itchyny/lightline.vim'

" make the yanked region apparent
Plug 'machakann/vim-highlightedyank'

" change the working directory to the project root when opening a file
Plug 'airblade/vim-rooter'

" vim syntax for toml
Plug 'cespare/vim-toml'

" rust syntax
Plug 'rust-lang/rust.vim'

" format C/C++/etc. using clang-format
Plug 'rhysd/vim-clang-format'

" markdown language support
Plug 'plasticboy/vim-markdown'

" align text
" e.g., in a latex tabular, select text and then :Tabularize /&
Plug 'godlygeek/tabular'

" fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" taskbar
Plug 'preservim/tagbar'

" make vim as smart as vscode
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" asynchronous linter
Plug 'dense-analysis/ale'

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'nvim-lua/lsp_extensions.nvim'

" Autocompletion framework for built-in LSP
Plug 'nvim-lua/completion-nvim'

call plug#end()

" activate filetypes and syntax highlighting
filetype plugin indent on
set autoindent
syntax on

" display line numbers
set number

" indentation
set shiftwidth=3
set tabstop=3
set softtabstop=3
set noexpandtab

" delay before o opens a new line
" http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set timeoutlen=300 

" show corresponding parenthesis
set showmatch

" search (incremental, ignore case)
set incsearch
set ignorecase
set smartcase
set gdefault

" enable the mouse only in insert mode
if has('mouse')
	set mouse=i
endif

" colors
set background=dark

set backup			" keep a backup file (*~ file)
set history=50		" keep 50 lines of command line history
set showcmd			" display incomplete commands
set autoindent		" always set autoindenting on
set encoding=utf-8
set scrolloff=2	" leave a few lines above and below the cursor when scrolling
set nojoinspaces	" when joining lines, don't add an extra space
set nofoldenable  " disable folding
set laststatus=2	" always display the status bar
set diffopt+=iwhite " No whitespace in vimdiff
set colorcolumn=80 " and give me a colored column
set showcmd " Show (partial) command in status line.
set shortmess+=c " don't give |ins-completion-menu| messages.

" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Sane splits
set splitright
set splitbelow

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" use ag silver searcher instead of grep
" call with :grep
if executable('ag')
	set grepprg=ag\ --vimgrep\ $*
	set grepformat=%f:%l:%c:%m
else
	" grep will sometimes skip displaying the file name if you
	" search in a singe file. This will confuse Latex-Suite. Set your grep
	" program to always generate a file-name.
	set grepprg=grep\ -nH\ $*
endif

if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
end

" Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" do not indent automatically in tex files
let g:tex_indent_brace = 0
let g:latex_indent_enabled = 0

" Completion
" Better completion
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=*~Thumbs.db,*.swp

" Show those damn hidden characters
set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
"set listchars=nbsp:¬,extends:»,precedes:«,trail:•

" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Prevent accidental writes to buffers that shouldn't be edited
autocmd BufRead *.orig set readonly
autocmd BufRead *.pacnew set readonly

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

au Filetype rust set colorcolumn=100

" Help filetype detection
autocmd BufRead *.plot set filetype=gnuplot
autocmd BufRead *.md set filetype=markdown
autocmd BufRead *.lds set filetype=ld
autocmd BufRead *.tex set filetype=tex
autocmd BufRead *.trm set filetype=c
autocmd BufRead *.xlsx.axlsx set filetype=ruby

" Script plugins
" after the opening tag, press ctrl+_ to get the closing tag
autocmd Filetype html,xml,xsl,php source ~/.vim/scripts/closetag.vim

" always load the termdebug plugin for C/C++/Rust files
" to be able to use gdb in vim
autocmd BufNewFile,BufRead *.c,*.cc,*.cpp,*.h,*.rs packadd termdebug

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" <leader>, shows/hides hidden characters
nnoremap <leader>, :set invlist<cr>

" If a physical line is displayed on multiple lines, then move to the next
" displayed line
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'

" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Lightline
set noshowmode
set cmdheight=1
let g:lightline = {
		\ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileencoding', 'filetype' ] ],
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename'
      \ },
      \ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

let g:highlightedyank_highlight_duration = 250

let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_folding_disabled = 1

" fzf
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" TODO will not work if proximity-sort is not installed
" so check if it exists
function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

" Open hotkeys for fzf                                                  
map <C-p> :Files<CR>                                                            
nmap <leader>; :Buffers<CR>

" rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

" tagbar
let g:tagbar_ctags_bin = '/usr/bin/uctags'
nmap <F8> :TagbarToggle<CR>

" Configure LSP
" https://github.com/neovim/nvim-lspconfig#rust_analyzer
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
EOF

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
