vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.opt.wrap = false
-- vim.cmd("set autoindent")
-- vim.cmd("set smartindent")
-- vim.cmd("filetype plugin indent on")

vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

local opts = {}

local plugins = {
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup({
        transparent = true
      })
      vim.cmd.colorscheme "tokyonight-storm"
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    name = "telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim"
    },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({})
          }
        }
      })

      require("telescope").load_extension("ui-select")
    end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim"
    },
    config = function()
      vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "ruby", "clojure", "javascript", "typescript", "lua" },
        highlight = {
          enable = true
        },
        indent = {
          enable = true
        }
      }
    end
  },
  {
    "tpope/vim-surround"
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "clojure_lsp" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.clojure_lsp.setup({
        capabilities = capabilities
      })
      lspconfig.ruby_lsp.setup({
        capabilities = capabilities
      })
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.rubocop,
          null_ls.builtins.formatting.rufo,
          null_ls.builtins.diagnostics.clj_kondo,
          null_ls.builtins.formatting.cljfmt,
        }
      })

      vim.keymap.set("n", "<leader>nf", vim.lsp.buf.format, {})

      vim.diagnostic.config({
        virtual_text = {
          prefix = "●", -- Could be '■', '▎', '▌', '▶', or a character you like
          spacing = 2,
        },
        signs = true,             -- Show signs in the gutter
        underline = true,         -- Underline problematic code
        update_in_insert = false, -- Whether to update diagnostics in insert mode
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.rb", "*.clj", "*.lua" },
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({})

      local Terminal1 = require("toggleterm.terminal").Terminal
      local Terminal2 = require("toggleterm.terminal").Terminal
      local Terminal3 = require("toggleterm.terminal").Terminal
      local float_term1 = Terminal1:new({ direction = "float" })
      local float_term2 = Terminal2:new({ direction = "float" })
      local float_term3 = Terminal3:new({ direction = "float" })

      vim.keymap.set({ "n", "t" }, "<A-1>", function()
        float_term1:toggle()
      end, { desc = "Toggle Floating Terminal" })

      vim.keymap.set({ "n", "t" }, "<A-2>", function()
        float_term2:toggle()
      end, { desc = "Toggle Floating Terminal" })

      vim.keymap.set({ "n", "t" }, "<A-3>", function()
        float_term3:toggle()
      end, { desc = "Toggle Floating Terminal" })
    end
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "hrsh7th/cmp-nvim-lsp"
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "luasnip" }, -- For luasnip users.
          { name = "nvim_lsp" }
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
  -- Clojure
  {
    "Olical/conjure",
    ft = { "clojure" }
  },
  -- Ruby
  {
    "vim-ruby/vim-ruby"
  },
  {
    "tpope/vim-endwise"
  }

}

require("lazy").setup(plugins, opts)

-- Custom
vim.keymap.set('n', '<leader>q', ':q!<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>0', ':vsplit<CR>')
vim.keymap.set('n', '<leader>-', ':split<CR>')

-- LSP
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>jd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>jr", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})

-- vim.keymap.set("n", "<leader>ca", function()
--   require("telescope.builtin").code_actions()
-- end, { desc = "LSP Code Actions" })


-- Neovim Config
vim.keymap.set('n', '<leader>oc', ':e $MYVIMRC<CR>')

-- NeoTree
vim.keymap.set('n', '<leader>e', ':Neotree filesystem reveal float<CR>')

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
vim.keymap.set('n', '<leader>st', builtin.live_grep, {})
vim.keymap.set('n', '<leader>td', ':Telescope diagnostics<CR>')
