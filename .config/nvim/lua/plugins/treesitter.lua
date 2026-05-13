return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "html", "ruby", "embedded_template", "clojure", "javascript", "typescript", "lua" },
        highlight = {
          enable = true
        },
        indent = {
          enable = true
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
        filetypes = { "eruby", "html", "javascript", "typescript", "javascriptreact", "typescriptreact" }
      })
    end
  },
}
