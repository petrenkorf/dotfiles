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
  { "tpope/vim-endwise" }
}
