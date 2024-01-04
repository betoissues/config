HOME = os.getenv("HOME")
o = vim.opt
g = vim.g
o.encoding = "utf-8"
o.compatible = false

g.python3_host_prog="/usr/bin/python3"

vim.cmd([[
" ===== PLUGINS =====

call plug#begin('~/.config/nvim/plugged')

"" General
Plug 'majutsushi/tagbar'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'Yggdroot/indentLine'
Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'

"" GIT
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim', { 'branch': 'main' }

"" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

"" Completion
Plug 'hrsh7th/nvim-cmp', { 'branch': 'main' }
Plug 'hrsh7th/cmp-nvim-lsp', { 'branch': 'main' }
Plug 'hrsh7th/cmp-path', { 'branch': 'main' }
Plug 'hrsh7th/cmp-buffer', { 'branch': 'main' }
Plug 'hrsh7th/cmp-emoji', { 'branch': 'main' }
Plug 'andersevenrud/cmp-tmux', { 'branch': 'main' }
Plug 'ray-x/lsp_signature.nvim'

"" Language Support
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'tpope/vim-commentary'
Plug 'hashivim/vim-terraform'
Plug 'rust-lang/rust.vim'

call plug#end()

]])

vim.cmd("colorscheme contrastneed")
o.filetype = "on"
o.filetype.indent = "on"
o.filetype.plugin = "on"
o.syntax = "on"
o.background = "dark"
o.timeoutlen = 300
o.showmode = false
o.hidden = true
o.joinspaces = false

o.number = true
o.numberwidth = 4
o.ruler = true
o.swapfile = false
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.gdefault = true
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 0
o.shiftround = true
o.expandtab = false
o.preserveindent = true
o.copyindent = true
o.clipboard = unnamedplus
o.winwidth = 84
o.winheight = 5
o.winminheight = 5
o.winheight = 999
o.splitright = true
o.splitbelow = true
o.tw = 80
o.colorcolumn = "+1"
o.wrap = true
o.linebreak = true
o.wrapmargin=0
o.textwidth=0
o.formatoptions= o.formatoptions + "tc" -- wrap text and comments using textwidth
o.formatoptions = o.formatoptions + "r" -- continue comments when pressing ENTER in I mode
o.formatoptions = o.formatoptions + "q" -- enable formatting of comments with gq
o.formatoptions = o.formatoptions + "n" -- detect lists for formatting
o.formatoptions = o.formatoptions + "b" -- auto-wrap in insert mode, and do not wrap old long
o.laststatus=2
o.switchbuf = "useopen"
o.signcolumn = "yes"
o.showcmd = false
o.inccommand="split"
o.undodir = HOME .. "/.local/share/nvim/undodir"
o.undofile = true

-- ==== GUI ====
o.vb = true
o.backspace = "2"
o.foldenable = false
o.ruler = true
o.ttyfast = true
o.lazyredraw = true
o.synmaxcol = 500
o.relativenumber = true
o.diffopt = "internal,filler,closeoff,iwhite,algorithm:patience,indent-heuristic"
o.shortmess= o.shortmess + "c"
o.list = true
o.listchars="nbsp:¬,extends:»,precedes:«,trail:•,tab:>—"
o.scrolloff=10

-- ==== LANGUAGE SUPPORT ====
g.diagnostic_enable_virtual_text = 1
g.diagnostic_virtual_text_prefix = ''
g.closetag_filenames = "*.html,*.xhtml,*.phtml,*.php"
vim.cmd("let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'")

require("lsp")

vim.cmd([[
map j gj
map k gk
vnoremap > >gv
vnoremap < <gv


if executable('rg')
        set grepprg=rg\ --no-heading\ --vimgrep
        set grepformat=%f:%l:%c:m
endif


highlight ColorColumn ctermbg=241


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
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

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
nnoremap <leader>g :Goyo<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-w> :bd<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

nmap <leader>; :Buffers<CR>
nmap <leader>t :TagbarToggle<CR>
map <C-tab> :bn
map <C-p> :Files<CR>

let &t_8f = "<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "<Esc>[48;2;%lu;%lu;%lum"
set t_Co=256
]])
