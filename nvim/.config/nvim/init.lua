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
	'mfussenegger/nvim-lint',
	{
		'linux-cultist/venv-selector.nvim',
		dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
		opts = {
			-- Your options go here
			name = ".venv",
			auto_refresh = true
		},
		event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
		keys = {
			-- Keymap to open VenvSelector to pick a venv.
			{ '<leader>vs', '<cmd>VenvSelect<cr>' },
			-- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
			{ '<leader>vc', '<cmd>VenvSelectCached<cr>' },
		},
	},
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
	{
		'goolord/alpha-nvim',
		config = function ()
			require'alpha'.setup(require'alpha.themes.theta'.config)
		end
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VimEnter",
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
		main = "ibl",
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
		}
	},
	-- General
	"majutsushi/tagbar",
	"jiangmiao/auto-pairs",
	"junegunn/goyo.vim",
	"junegunn/vim-easy-align",
	"nvim-lualine/lualine.nvim",
	"nvim-lua/plenary.nvim",
	-- Git
	"lewis6991/gitsigns.nvim",
	-- Completion
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-emoji",
	"andersevenrud/cmp-tmux",
	-- Language Support
	"nvim-treesitter/nvim-treesitter",
	"neovim/nvim-lspconfig",
	"nvim-lua/completion-nvim",
	"tpope/vim-commentary",
	-- Misc
	"nvim-telescope/telescope-ui-select.nvim",
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {}
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	}
}

require("lazy").setup(plugins, {})


vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

require("noice").setup({
	presets = {
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = false, -- long messages will be sent to a split
		lsp_doc_border = true
	}
})


-- Completion Config
local cmp = require('cmp')
cmp.setup {
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'path' },
		{ name = 'buffer' },
		{ name = 'emoji' },
		{ name = 'tmux' },
	},
	mappings = {
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<S-CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<C-CR>"] = function(fallback)
			cmp.abort()
			fallback()
		end,
	}
}

require('gitsigns').setup()

-- Telescope Config
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
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown {}
		}
	}
}
require("telescope").load_extension("ui-select")

local builtin = require('telescope.builtin')
builtin.diagnostics({ severity_bound = 0 })
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', 'gr', builtin.lsp_references, {})

-- Lualine Config
require('lualine').setup {
	options = {
		theme = 'auto',
		extensions = { "neo-tree", "lazy" },
		globalstatus = true,
		icons_enabled = true,
		component_separators = '|',
		section_separators = '',
	},
	sections = {
		lualine_a = { 
			{
				'buffers',
				show_filename_only = true,   -- Shows shortened relative path when set to false.
				hide_filename_extension = false,   -- Hide filename extension when set to true.
				show_modified_status = true, -- Shows indicator when the buffer is modified.
				mode = 0,
				max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
				-- it can also be a function that returns
				-- the value of `max_length` dynamically.
				filetype_names = {
					TelescopePrompt = 'Telescope',
					dashboard = 'Dashboard',
					packer = 'Packer',
					fzf = 'FZF',
					alpha = 'Alpha'
				}, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )
				buffers_color = {
					-- Same values as the general color option can be used here.
					active = 'lualine_buffer_normal',     -- Color for active buffer.
					inactive = 'lualine_buffer_inactive', -- Color for inactive buffer.
				},

				symbols = {
					modified = ' ●',      -- Text to show when the buffer is modified
					alternate_file = '#', -- Text to show to identify the alternate file
					directory =  '',     -- Text to show when the buffer is a directory
				},
			},
			"mode"
		},
	},
}

require('nvim-treesitter').setup {
	indent = {
		enable = true
	}
}

require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "javascript" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    additional_vim_regex_highlighting = false,
}

require("ibl").setup()

vim.opt.compatible = false
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
vim.api.nvim_set_keymap("n", "<C-w>x", ":bd<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-w>|", ":vsplit<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-w>-", ":split<CR>", { noremap = true })

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

-- LSP Config
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
	local opts = { noremap=true, silent=true }
	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<leader>xD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<leader>xr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	buf_set_keymap('n', '<leader>dd', '<cmd>Telescope diagnostics<CR>', opts)
	if client.resolved_capabilities.document_formatting then
		buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	elseif client.resolved_capabilities.document_range_formatting then
		buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	end
end
local servers = {'rust_analyzer', 'gopls', 'html', 'intelephense', 'clangd'}
for _, lsp in ipairs(servers) do
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	nvim_lsp[lsp].setup {
		on_attach = on_attach,
		capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities),
	}
end

nvim_lsp.pylsp.setup{
	on_attach = on_attach,
	capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities),
	settings = {
		pylsp = {
			plugins = {
				pylint = {
					enabled = true,
				}
			}
		}
	}
}

vim.diagnostic.config({
   virtual_text = {
        severity = { min = vim.diagnostic.severity.WARN }
   }
})

nvim_lsp.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
            }
          }
        }
      })
    end
    return true
  end
}