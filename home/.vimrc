" inspired by many vimrc, mainly:
"	https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim
"	https://github.com/padawin/dotfiles/blob/master/.vimrc

set nocompatible
filetype off
let mapleader = ";"

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

" melange theme
Plug 'savq/melange-nvim'

" change the working directory to the project root when opening a file
"Plug 'airblade/vim-rooter'

" vim syntax for toml
Plug 'cespare/vim-toml'

" rust syntax
" provides syntax highlighting, file detection, etc.: basic functions.
Plug 'rust-lang/rust.vim'

" format C/C++/etc. using clang-format
Plug 'rhysd/vim-clang-format'

" add inlay hints
Plug 'lvimuser/lsp-inlayhints.nvim'

" markdown language support
Plug 'plasticboy/vim-markdown'

" align text
" e.g., in a latex tabular, select text and then :Tabularize /&
Plug 'godlygeek/tabular'

" fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" tagbar
" need to install universal ctags
Plug 'preservim/tagbar'

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'nvim-lua/lsp_extensions.nvim'

" A completion engine plugin for neovim written in Lua.
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" A plugin to improve your rust experience in neovim.
Plug 'simrat39/rust-tools.nvim'

" Move seamlessly between vim and tmux splits
Plug 'christoomey/vim-tmux-navigator'

" helps updating dependencies in Cargo.toml
Plug 'mhinz/vim-crates'

call plug#end()


if has('nvim')
  autocmd BufRead Cargo.toml call crates#toggle()
endif

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
set termguicolors
let base16colorspace=256

colorscheme melange

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
"set completeopt=menuone,noinsert

"" Complete selected word
"inoremap <expr> <TAB> pumvisible() ? '<C-y>' : "\<TAB>"
"" Enter does not select the currently hovered item in the popup menu.
"" This is to avoid a pre-selected autocompletion to be selected when the
"" currently entered word is enough and the user wants to enter a new line.
"inoremap <expr> <CR> pumvisible() ? "<C-o>o" : "<CR>"

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

" highlight extra whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

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
" With a small keyboard (planck, ferris sweep) this is no longer needed
" nnoremap <up> <nop>
" nnoremap <down> <nop>
" noremap <left> gT
" noremap <right> gt
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>

" disable ctrl+q
nnoremap <c-q> <nop>
inoremap <c-q> <nop>
noremap <c-q> <nop>

" <leader>, shows/hides hidden characters
nnoremap <leader>, :set invlist<cr>

" If a physical line is displayed on multiple lines, then move to the next
" displayed line
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'

" / to search, so:
" <leader>+/ to stop searching
vnoremap <leader>/ :nohlsearch<cr>
nnoremap <leader>/ :nohlsearch<cr>

" My F1 key is too sensitive
map <F1> <Esc>
imap <F1> <Esc>

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

function! s:list_cmd()
  if executable('proximity-sort')
	  let base = fnamemodify(expand('%'), ':h:.:S')
	  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
  else
	  return 'fd --type file --follow'
  endif
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
nmap <leader>t :TagbarToggle<CR>

lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
       -- completion = cmp.config.window.bordered(),
       -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['clangd'].setup {
    capabilities = capabilities
  }

  -- Set up inlay hints
  require("lsp-inlayhints").setup()
  vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
  vim.api.nvim_create_autocmd("LspAttach", {
	  group = "LspAttach_inlayhints",
	  callback = function(args)
	  if not (args.data and args.data.client_id) then
		  return
		  end

		  local bufnr = args.buf
		  local client = vim.lsp.get_client_by_id(args.data.client_id)
		  require("lsp-inlayhints").on_attach(client, bufnr)
		  end,
  })
EOF

" Jumps to the definition of the symbol under the cursor
nnoremap <c-d> <cmd>lua vim.lsp.buf.definition()<CR>

" Displays hover information about the symbol under the cursor in a floating
" window. Calling the function twice will jump into the floating window.
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>

" Displays signature information about the symbol under the cursor in a
" floating window. Need to be inside the function parenthesis
inoremap <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>

" Selects a code action available at the current cursor position.
nnoremap <silent> <leader>a    <cmd>lua vim.lsp.buf.code_action()<CR>

" rename
nnoremap <buffer> <leader>r <cmd>lua vim.lsp.buf.rename()<cr>

" Lists all the implementations for the symbol under the cursor in the
" quickfix window.
" nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementations()<CR>

" Jumps to the definition of the type of the symbol under the cursor.
" nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>

" Lists all the references to the symbol under the cursor in the quickfix
" window.
" nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>

" Lists all symbols in the current buffer in the quickfix window.
" nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>

" Lists all symbols in the current workspace in the quickfix window.
" nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

"  Jumps to the declaration of the symbol under the cursor.
" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>


