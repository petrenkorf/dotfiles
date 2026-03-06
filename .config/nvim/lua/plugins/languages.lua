return {
  -- Clojure
  {
    "Olical/conjure",
    ft = { "clojure" },
    config = function()
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*.clj", -- or "*.cljs", "*.cljc"
        callback = function()
          vim.cmd("ConjureEvalBuf")
        end
      })
    end
  },
  -- Ruby
  { "vim-ruby/vim-ruby" },
  { "tpope/vim-endwise" },
  { "tpope/vim-rails" },
  -- SQL
  {
    "tpope/vim-dadbod",
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod", "kristijanhusak/vim-dadbod-completion" }
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    ft = { "sql", "mysql", "plsql" },
    dependencies = { "tpope/vim-dadbod" }
  },
}
