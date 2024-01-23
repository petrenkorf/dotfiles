-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.leader = 'space'

require('lvim.lsp.manager').setup("tailwindcss", {
  filetypes = { 'html', "erb", 'eruby' },
  root_dir = function(fname)
    return require('lspconfig').util.root_pattern ".git"(fname)
  end
})

lvim.plugins = {
  { "thoughtbot/vim-rspec" },
  { "tpope/vim-rails" },
  { 
    "nvim-telescope/telescope.nvim",
    config = function()
      require('telescope').setup({
        defaults = {
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
        enable = true,
        enable_rename = true,
        enable_close = true,
        filetypes = { "html", "xml", "eruby", "javascript", "typescript", "typescriptreact", "javascriptreact" }
      })
    end
  },
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require('auto-save').setup()
    end
  }
}

-- Open this configfile 
lvim.keys.normal_mode["<Leader>lc"] = ":e ~/.config/lvim/config.lua<CR>"

-- Bundler install
lvim.keys.normal_mode["<Leader>i"] = ":!bundle install<CR>"

-- vim-rspec
vim.g.rspec_command = "!bundle exec rspec --color {spec}"

lvim.keys.normal_mode["<Leader>t"] = ":call RunCurrentSpecFile()<CR>"
lvim.keys.normal_mode["<Leader>s"] = ":call RunNearestSpec()<CR>"
lvim.keys.normal_mode["<Leader>l"] = ":call RunLastSpec()<CR>"
lvim.keys.normal_mode["<Leader>a"] = ":call RunAllSpecs()<CR>"

-- Split hotkeys
lvim.keys.normal_mode["<Leader>0"] = "<C-W>v"
lvim.keys.normal_mode["<Leader>-"] = "<C-W>s"
