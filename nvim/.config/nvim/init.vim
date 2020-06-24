set nocompatible
scriptencoding utf-8
let g:python3_host_prog='/usr/bin/python3'

" ===== PLUGINS =====

call plug#begin('~/.config/nvim/plugged')

"" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"" Autocomplete
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

"" Python
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

Plug 'majutsushi/tagbar'
Plug 'tomtom/tcomment_vim'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'stanangeloff/php.vim'
Plug 'mattn/emmet-vim'
Plug 'chriskempson/base16-vim'


call plug#end()
filetype plugin indent on
set timeoutlen=300
set encoding=utf-8
set noshowmode
set hidden
set nowrap
set nojoinspaces

let mapleader = " "

" ===== PERSONAL =====
set background=dark
colorscheme contrastneed

map j gj
map k gk
vnoremap > >gv
vnoremap < <gv

set number
set numberwidth=4
syn on

set ruler
set noswapfile

"Case insensitive
set incsearch
set ignorecase
set smartcase
set gdefault

"Soft tabs
set tabstop=4
set shiftwidth=4
set shiftround
set expandtab
set smarttab
set clipboard+=unnamedplus

" Splits autoresize
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999
set splitright
set splitbelow

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <leader><leader> <c-^>
nnoremap <C-w> :bd<CR>

"Line 80 mark
set tw=80
set colorcolumn=+1
highlight ColorColumn ctermbg=0

set wrapmargin=0
" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long

set showcmd


set laststatus=2

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
set nolist
set listchars=nbsp:¬,extends:»,precedes:«,trail:•


" ==== MOVEMENT ====
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

map <C-tab> :bn

" == SCROLLING ==
set scrolloff=10

" ==== TAGBAR ====
nmap <leader>t :TagbarToggle<CR>

" ==== vim closetag =====
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php"

au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix
autocmd FileType php setlocal tabstop=4 shiftwidth=4 expandtab

" ==== LANGUAGE SUPPORT ====
" Completion
set hidden
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ }
autocmd BufEnter * call ncm2#enable_for_buffer()
" set completeopt=noinsert,menuone,noselect
au User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")

let g:LanguageClient_autoStart = 1
let g:LanguageClient_useVirtualText = "No"
let g:LanguageClient_useFloatingHover = 0
nnoremap <silent> cm :call LanguageClient_contextMenu()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>

let $FZF_DEFAULT_COMMAND = 'rg --files'

" Python Mode
let g:pymode_python = 'python3'

map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

if executable('rg')
        set grepprg=rg\ --no-heading\ --vimgrep
        set grepformat=%f:%l:%c:m
endif

" Follow Rust code style rules
au Filetype rust set colorcolumn=100

" Buffer Hooks
autocmd BufEnter * silent! cd %:p:h
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview"
autocmd BufRead *.plot set filetype=gnuplot
autocmd BufRead *.md set filetype=markdown
autocmd BufRead *.lds set filetype=ld
autocmd BufRead *.tex set filetype=tex
autocmd BufRead *.trm set filetype=c
autocmd BufReadPost *.rs setlocal filetype=rust
set t_Co=256
