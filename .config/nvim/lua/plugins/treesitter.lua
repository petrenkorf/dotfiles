return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "ruby", "clojure", "javascript", "typescript", "lua", "c", "cpp", "java" },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "ruby" }
        },
        indent = {
          enable = true,
          disable = { "ruby" }
        },
        autotag = {
          enabled = true
        }
      }
    end
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-ts-autotag").setup({
        enabled = true,
        filetypes = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact" }
      })
    end
  },
}
