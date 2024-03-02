HOME = os.getenv("HOME")
vim.g.mapleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  	vim.fn.system({
    	"git",
    	"clone",
    	"--filter=blob:none",
    	"https://github.com/folke/lazy.nvim.git",
    	"--branch=stable", -- latest stable release
    	lazypath,
  	})
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
    	"nvim-neo-tree/neo-tree.nvim",
    	branch = "v3.x",
    	dependencies = {
      		"nvim-lua/plenary.nvim",
      		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      		"MunifTanjim/nui.nvim",
    	}
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x"
	},
	-- General
	"majutsushi/tagbar",
	"jiangmiao/auto-pairs",
	"junegunn/goyo.vim",
	"junegunn/vim-easy-align",
	"lukas-reineke/indent-blankline.nvim",
	"nvim-lualine/lualine.nvim",
	"nvim-lua/plenary.nvim",
	-- Git
	"lewis6991/gitsigns.nvim",
	-- Fuzzy Finder
	"airblade/vim-rooter",
	-- Completion
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-emoji",
	"andersevenrud/cmp-tmux",
	"ray-x/lsp_signature.nvim",
	-- Language Support
	"neovim/nvim-lspconfig",
	"nvim-lua/completion-nvim",
	"tpope/vim-commentary"
}

require("lazy").setup(plugins, {})
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

require'lspconfig'.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- Depending on the usage, you might want to add additional paths here.
              -- E.g.: For using `vim.*` functions, add vim.env.VIMRUNTIME/lua.
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      })
    end
    return true
  end
}

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
local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
      	mappings = {
        	i = {
          		["<esc>"] = actions.close,
          		["<C-[>"] = actions.close,
          		["<C-q>"] = actions.send_to_qflist,
          	},
        },
    },
}
require('lualine').setup {
	options = {
		theme = 'ayu_dark'
	}
}
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.opt.compatible = false
--vim.cmd 'scriptencoding utf-8'
vim.cmd 'syntax on'
vim.cmd 'colorscheme contrastneed'
vim.cmd 'highlight ColorColumn ctermbg=241'
vim.cmd 'filetype plugin indent on'

vim.g["g:python3_host_prog"] = "/usr/bin/python3"


vim.opt.undofile = true
vim.opt.undodir = HOME .. "/.local/share/nvim/undodir"

vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.ruler = true
vim.opt.swapfile = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.shiftround = true
vim.opt.expandtab = false
vim.opt.preserveindent = true
vim.opt.copyindent = true
vim.opt.clipboard:append("unnamedplus")
vim.opt.winwidth = 84
vim.opt.winheight = 5
vim.opt.winminheight = 5
vim.opt.winheight = 999
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.textwidth = 80
vim.opt.colorcolumn = "+1"
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.wrapmargin = 0
vim.opt.textwidth = 0
vim.opt.formatoptions:append({ tc = true }) -- wrap text and comments using textwidth
vim.opt.formatoptions:append({ r = true }) -- continue comments when pressing ENTER in I mode
vim.opt.formatoptions:append({ q = true }) -- enable formatting of comments with gq
vim.opt.formatoptions:append({ n = true }) -- detect lists for formatting
vim.opt.formatoptions:append({ b = true }) -- auto-wrap in insert mode, and do not wrap old long
vim.opt.laststatus = 2

vim.opt.background = "dark"
vim.opt.timeoutlen = 300
vim.opt.encoding = "utf-8"
vim.opt.showmode = false
vim.opt.hidden = true
vim.opt.joinspaces = false
vim.opt.switchbuf = "useopen"
vim.opt.signcolumn = "yes"
vim.opt.showcmd = false
vim.opt.inccommand = "split"

-- GUI Options
vim.opt.vb = true
vim.opt.backspace = "2"
vim.opt.foldenable = false
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 500
vim.opt.relativenumber = true
vim.opt.diffopt:append("iwhite")
vim.opt.diffopt:append("algorithm:patience")
vim.opt.diffopt:append("indent-heuristic")
vim.opt.shortmess:append({ c = true })
vim.opt.list = true
vim.opt.listchars = {
	nbsp = "¬",
	extends = "»",
	precedes = "«",
	trail = "•",
	tab = ">—"
}
vim.opt.scrolloff = 10

vim.api.nvim_set_keymap("n", "<leader><leader>", "<c-^>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>g", ":Goyo<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-n>", ":Neotree toggle<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-w>", ":bd<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<C-J>", "<C-W><C-J>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-K>", "<C-W><C-K>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-L>", "<C-W><C-L>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-H>", "<C-W><C-H>", { noremap = true })

vim.api.nvim_set_keymap("n", "<C-j>", "<C-W>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-W>k", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-W>l", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-h>", "<C-W>h", { noremap = true })

vim.api.nvim_set_keymap("n", "j", "gj", { noremap = true })
vim.api.nvim_set_keymap("n", "k", "gk", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>t", ":TagbarToggle<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-tab>", ":bn<CR>", { noremap = true })

vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true })
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true })
