set nocompatible
scriptencoding utf-8
let g:python3_host_prog='/usr/bin/python3'

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
set laststatus=2

set switchbuf=useopen signcolumn=yes noshowcmd inccommand=split
set undodir=~/.local/share/nvim/undodir undofile

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
set diffopt+=iwhite
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set shortmess+=c
set list
set listchars=nbsp:¬,extends:»,precedes:«,trail:•,tab:>—
set scrolloff=10


" ==== LANGUAGE SUPPORT ====
:lua << EOF 
	local nvim_lsp = require('lspconfig')
	local on_attach = function(client, bufnr)
		local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
		local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
		buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
		require('lsp_signature').on_attach()
		local opts = { noremap=true, silent=true }
		buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
		buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
		buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
		buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
		buf_set_keymap('n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
		buf_set_keymap('n', '<leader>xD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
		buf_set_keymap('n', '<leader>xr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
		buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
		buf_set_keymap('n', '<leader>xd', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
		if client.resolved_capabilities.document_formatting then
			buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
		elseif client.resolved_capabilities.document_range_formatting then
			buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
		end
	end
	local servers = {'rust_analyzer', 'pylsp', 'gopls', 'html', 'intelephense', 'clangd', 'terraform-ls'}
	for _, lsp in ipairs(servers) do
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		nvim_lsp[lsp].setup {
			on_attach = on_attach,
			capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities),
		}
	end
	require('cmp').setup {
		sources = {
			{ name = 'nvim_lsp' },
			{ name = 'path' },
			{ name = 'buffer' },
			{ name = 'emoji' },
			{ name = 'tmux' },
		}
	}
	require('gitsigns').setup()
	require('lualine').setup {
	options = {
		theme = 'ayu_dark'
		}
	}
EOF 

let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_virtual_text_prefix = ''

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
