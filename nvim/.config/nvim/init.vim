set nocompatible
scriptencoding utf-8
let g:python3_host_prog='/usr/bin/python3'

" ===== PLUGINS =====

call plug#begin('~/.config/nvim/plugged')

"" General
Plug 'majutsushi/tagbar'
Plug 'lvht/tagbar-markdown'
Plug 'tomtom/tcomment_vim'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'stanangeloff/php.vim'
Plug 'mattn/emmet-vim'
Plug 'junegunn/goyo.vim'

"" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"" NCM2
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'

"" Language Support
Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

"" Rust
Plug 'rust-lang/rust.vim'


call plug#end()
filetype plugin indent on
syntax on
colorscheme contrastneed
set background=dark
set timeoutlen=300
set encoding=utf-8
set noshowmode
set hidden
set nojoinspaces

map j gj
map k gk
vnoremap > >gv
vnoremap < <gv

set number
set numberwidth=4
set ruler
set noswapfile
set incsearch
set ignorecase
set smartcase
set gdefault
set tabstop=4
set shiftwidth=4
set softtabstop=0
set shiftround
set noexpandtab
set preserveindent
set copyindent
set clipboard+=unnamedplus
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999
set splitright
set splitbelow
set tw=80
set colorcolumn=+1
set wrap
set linebreak
set wrapmargin=0
set textwidth=0
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long
set showcmd
set laststatus=2

if executable('rg')
        set grepprg=rg\ --no-heading\ --vimgrep
        set grepformat=%f:%l:%c:m
endif

let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php"
let $FZF_DEFAULT_COMMAND = 'rg --files'

highlight ColorColumn ctermbg=241

" ==== GUI ====
set guioptions-=T
set vb t_vb=
set backspace=2
set nofoldenable
set ruler
set ttyfast
set lazyredraw
set synmaxcol=500
set relativenumber
set number
set diffopt+=iwhite
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set shortmess+=c
set list
set listchars=nbsp:¬,extends:»,precedes:«,trail:•,tab:>—
set scrolloff=10


" ==== LANGUAGE SUPPORT ====
set hidden
let g:LanguageClient_autoStart = 1
let g:LanguageClient_useVirtualText = "No"
let g:LanguageClient_useFloatingHover = 0
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'python': ['~/.local/bin/pyls'],
    \ 'vue': ['~/.yarn/bin/vls'],
    \ }
autocmd BufEnter * call ncm2#enable_for_buffer()
au User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect


" ===== FILETYPE SUPPORT =====
autocmd BufEnter * silent! cd %:p:h
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview"
autocmd BufRead *.plot set filetype=gnuplot
autocmd BufRead *.lds set filetype=ld
autocmd BufRead *.tex set filetype=tex
autocmd BufRead *.trm set filetype=c

" Rust
autocmd BufReadPost *.rs setlocal filetype=rust
au Filetype rust set colorcolumn=100

" Markdown
autocmd BufRead *.md set filetype=markdown conceallevel=3
autocmd FileType markdown setlocal spell spelllang=en_gb
autocmd FileType markdown Goyo
autocmd FileType markdown hi markdownItalic cterm=italic ctermfg=246 guifg=246

" Python
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

" PHP
autocmd FileType php setlocal tabstop=4 shiftwidth=4 expandtab

" ===== KEYBINDS =====
let mapleader = " "

nnoremap <leader><leader> <c-^>
nnoremap <leader>f :Goyo<CR>
nnoremap <C-w> :bd<CR>
map <C-tab> :bn

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>
nmap <leader>t :TagbarToggle<CR>

nnoremap <silent> cm :call LanguageClient_contextMenu()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")
let &t_8f = "<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "<Esc>[48;2;%lu;%lu;%lum"
set t_Co=256
