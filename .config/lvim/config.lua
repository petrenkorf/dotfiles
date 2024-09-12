-- lvim.colorscheme = 'nord'
lvim.leader = 'space'
-- lvim.transparent_window = true
lvim.builtin.bufferline.active = false
lvim.lsp.installer.setup.automatic_installation = true
lvim.format_on_save.enabled = true

require('lvim.lsp.manager').setup("tailwindcss", {
  filetypes = { 'html', "erb", 'eruby' },
  root_dir = function(fname)
    return require('lspconfig').util.root_pattern ".git" (fname)
  end
})

lvim.plugins = {
  {
    "f-person/git-blame.nvim",
    config = function()
      require("gitblame").setup({
        enabled = true
      })
    end
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "neovim/nvim-lspconfig",
    config = function()
    end
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      lvim.notify = require("notify")
      vim.notify = require("notify")
    end
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "rcarriga/nvim-notify"
    }
  },
  { 'folke/zen-mode.nvim' },
  {
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
      "olimorris/neotest-rspec",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-rspec')({
            root_files = { "Gemfile" },
            rspec_cmd = function()
              return vim.tbl_flatten({
                "bundle",
                "exec",
                "rspec"
              })
            end
          })
        }
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "elixir", "eex", "heex", "ruby", "clojure", "javascript", "typescript" },
        highlight = { enable = true }
      })
    end
  },
  { "thoughtbot/vim-rspec" },
  { "tpope/vim-rails" },
  -- Do not forget to install ripgrep in order to speed up file search
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require('telescope').setup({
        defaults = {
          file_ignore_patterns = { "_build", "node_modules", "target", "out", "coverage" },
          layout_config = {
            vertical = { width = 0.5 }
          }
        }
      })
    end
  },
  { "mfussenegger/nvim-dap" },
  {
    "suketa/nvim-dap-ruby",
    config = function()
      require('dap-ruby').setup()
    end
  },
  {
    "RRethy/nvim-treesitter-endwise",
    config = function()
      require('nvim-treesitter.configs').setup {
        endwise = {
          enable = true
        }
      }
    end
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          enable = true,
          enable_rename = true,
          enable_close = true,
          filetypes = { "html", "htmldjango", "xml", "eruby", "javascript", "typescript", "typescriptreact", "javascriptreact" }
        }
      })
    end
  },
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require('auto-save').setup()
    end
  },

  -- CLOJURE
  { "Olical/conjure" },
  { "guns/vim-sexp" },
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  { "shaunsingh/nord.nvim" }
}

-- Redirect messages to nvim-notify
local function notify_output(command, opts)
  local output = ""
  local notification
  local notify = function(msg, level)
    local notify_opts = vim.tbl_extend(
      "keep",
      opts or {},
      { title = table.concat(command, " "), replace = notification }
    )
    notification = vim.notify(msg, level, notify_opts)
  end
  local on_data = function(_, data)
    output = output .. table.concat(data, "\n")
    notify(output, "info")
  end
  vim.fn.jobstart(command, {
    on_stdout = on_data,
    on_stderr = on_data,
    on_exit = function(_, code)
      if #output == 0 then
        notify("No output of command, exit code: " .. code, "warn")
      end
    end,
  })
end

-- Open this configfile
lvim.keys.normal_mode["<Leader>lc"] = ":e ~/.config/lvim/config.lua<CR>"

-- Bundler install
lvim.keys.normal_mode["<Leader>i"] = ":!bundle install<CR>"
lvim.keys.normal_mode["<Leader>rf"] = ":!rubocop -A %<CR>"
lvim.keys.normal_mode["<Leader>rp"] = "Obinding.pry<Escape>"

-- Open terminal
lvim.keys.normal_mode["<Leader>\'"] = ':ToggleTerm<CR>'

-- neotest-rspec
lvim.keys.normal_mode["<Leader>ta"] = ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>'
lvim.keys.normal_mode["<Leader>ts"] = ':lua require("neotest").run.run()<CR>'
lvim.keys.normal_mode["<Leader>te"] = ':lua require("neotest").run.run({suite=true})<CR>'
lvim.keys.normal_mode["<Leader>tw"] = ':lua require("neotest").watch.toggle(vim.fn.expand("%"))<CR>'
lvim.keys.normal_mode["<Leader>to"] = ':lua require("neotest").summary.toggle()<CR>'
lvim.keys.normal_mode["<Leader>tj"] = ':lua require("neotest").jump.next({ status = "failed" })<CR>'
lvim.keys.normal_mode["<Leader>tp"] = ':lua require("neotest").prev.next({ status = "failed" })<CR>'
lvim.keys.normal_mode["<Leader>tt"] = ":exe \":TermExec cmd='bundle exec rspec \".expand('%').\":\".line('.').\"'\"<CR>"
lvim.keys.normal_mode["<Leader>tc"] =
":exe \":TermExec cmd='bundle exec cucumber \".expand('%').\":\".line('.').\"'\"<CR>"

-- zenmode
lvim.keys.normal_mode["<Leader>z"] = ':ZenMode<CR>'

-- jump to definition
lvim.keys.normal_mode["<Leader>jd"] = ":lua vim.lsp.buf.definition()<CR>"

-- Split hotkeys
lvim.keys.normal_mode["<Leader>0"] = "<C-W>v"
lvim.keys.normal_mode["<Leader>-"] = "<C-W>s"

-- Open spec file
lvim.keys.normal_mode["<tab>"] = ":A<CR>"

-- Live grep the current selection
lvim.keys.visual_mode["<Leader>st"] = "\"sy:exe \":Telescope live_grep default_text=\".getreg('s')<CR>"
