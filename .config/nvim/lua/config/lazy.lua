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
  { import = "plugins.ui" },
  { import = "plugins.lsp" },
  { import = "plugins.testing" },
  { import = "plugins.terminal" },
  { import = "plugins.completion" },
  { import = "plugins.treesitter" },
  { import = "plugins.misc" },
  { import = "plugins.languages" },
}

require("lazy").setup(plugins, opts)
