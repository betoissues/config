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
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    c = { "clang-format" },
                    javascript = { { "prettierd", "prettier" } },
                    typescript = { { "prettierd", "prettier" } },
                    javascriptreact = { { "prettierd", "prettier" } },
                    typescriptreact = { { "prettierd", "prettier" } },
                    json = { { "prettierd", "prettier" } },
                    go = { { "goimports" } },
                    graphql = { { "prettierd", "prettier" } },
                    markdown = { { "prettierd", "prettier" } },
                    html = { "htmlbeautifier" },
                    bash = { "beautysh" },
                    proto = { "buf" },
                    python = { "flake8", "black", "isort" },
                    yaml = { "yamlfix" },
                    toml = { "taplo" },
                    css = { { "prettierd", "prettier" } },
                    scss = { { "prettierd", "prettier" } },
                    zsh = { { "beautysh" } },
                },
            })

            vim.keymap.set({ "n", "v" }, "<leader>lf", function()
                require("conform").format({
                    lsp_fallback = true,
                    async = true,
                    timeout_ms = 500,
                })
            end, { desc = "Format file or range (in visual mode)" })
        end,
    },
    {
        'mfussenegger/nvim-lint',
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                javascript = { "eslint" },
                typescript = { "eslint" },
                javascriptreact = { "eslint_d" },
                typescriptreact = { "eslint_d" },
                terraform = { "tflint" },
                python = { "flake8", "mypy" },
            }

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })

            vim.keymap.set("n", "<leader>ll", function()
                lint.try_lint()
            end, { desc = "Trigger linting for current file" })
        end,
    },
    {
        'linux-cultist/venv-selector.nvim',
        dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
        branch = "regexp",
        opts = {
            -- Your options go here
            name = ".venv",
            auto_refresh = true,
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
        opts = {
            scope = { enabled = true },
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
        config = function()
            require("ibl").setup {}
        end,
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
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
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
    },
    -- OBSIDIAN
    {
        "epwalsh/obsidian.nvim",
        version = "*",  -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = "markdown",
        -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
        event = {
            -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
            -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
            -- refer to `:h file-pattern` for more examples
            "BufReadPre " .. vim.fn.expand "~" .."/Common/Notes/*.md",
            "BufNewFile " .. vim.fn.expand "~" .."/Common/Notes/*.md",
        },
        dependencies = {
            -- Required.
            "nvim-lua/plenary.nvim",
        },
        opts = {
            workspaces = {
                {
                    name = "personal",
                    path = vim.fn.expand "~" .. "/Common/Notes",
                }
            },
            disable_frontmatter = true,
            completion = {
                -- Set to false to disable completion.
                nvim_cmp = true,
                -- Trigger completion at 2 chars.
                min_chars = 2,
            },
        },
    },
    {
        "rebelot/kanagawa.nvim",
        opts = {
            colors = {
                palette = {
                    lotusInk1 = "#222222",
                    lotusWhite3 = "#EEEEEE"
                },
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none"
                        }
                    }
                }
            },
            overrides = function(colors)
                local theme = colors.theme
                return {
                    NormalFloat = { bg = "none" },
                    FloatBorder = { bg = "none" },
                    FloatTitle = { bg = "none" },

                    -- Save an hlgroup with dark background and dimmed foreground
                    -- so that you can use it where your still want darker windows.
                    -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                    NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                    -- Popular plugins that open floats will link to NormalFloat by default;
                    -- set their background accordingly if you wish to keep them dark and borderless
                    LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                    MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                }
            end,
        }
    }
}

require("lazy").setup(plugins, {})
require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup()

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
    completion = {
        completeopt = "menu,menuone,preview,noselect",
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'emoji' },
        { name = 'tmux' },
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-n>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
    }),
}

require('gitsigns').setup()

-- Telescope Config
local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
        file_ignore_patterns = { ".git/", "vendor/", "node_modules"},
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
    },
    pickers = {
        find_files = {
            hidden = true,
            find_command = {'rg', '--files', '--hidden', '-g', '!.git' }
        },
        grep_string = {
            additional_args = {'--hidden'}
        },
        live_grep = {
            additional_args = {'--hidden'}
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
                '',
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
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "javascript", "typescript", "dockerfile", "go", "markdown", "yaml", "php" },
    highlight = {
        enable = true,
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    additional_vim_regex_highlighting = false,
}

vim.cmd 'syntax on'
vim.cmd 'colorscheme kanagawa-dragon'
vim.cmd 'highlight ColorColumn ctermbg=241'
vim.cmd 'filetype plugin indent on'

vim.g["g:python3_host_prog"] = "/usr/bin/python3"


vim.opt.undofile = true
vim.opt.undodir = HOME .. "/.local/share/nvim/undodir"

vim.opt.cursorline = true
vim.opt.conceallevel = 1
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.shiftround = true
vim.opt.expandtab = true
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

-- vim.opt.background = "light"
vim.opt.timeoutlen = 250
vim.opt.showmode = false
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
    trail = "•",
    tab = ">—",
    nbsp = "¬",
    extends = "»",
    precedes = "«",
}
vim.opt.scrolloff = 10

vim.api.nvim_set_keymap('n', 'sd', ":-r !date +\\%Y-\\%m-\\%d<CR>$j", { noremap = true })
vim.api.nvim_set_keymap('n', 'st', ":-r !date +\"\\%Y-\\%m-\\%d \\%H:\\%M\"<CR>$j", { noremap = true })
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
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<leader>xD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>xr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '<leader>fl', '<cmd>Telescope diagnostics<CR>', opts)
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end
end

vim.diagnostic.config({
    virtual_text = {
        severity = { min = vim.diagnostic.severity.WARN }
    }
})


mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            on_attach = on_attach,
        }
    end,
    ['pylsp'] = function()
        require('lspconfig').pylsp.setup {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            on_attach = on_attach,
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
    end,
}
