-- Switch between clojure source and tests
local function switch_source_test()
  local path = vim.fn.expand("%:p")
  local target_path

  if path:match("_test%.clj$") then
    target_path = path
        :gsub("test/", "src/")       -- replace test/ with src/
        :gsub("_test%.clj$", ".clj") -- remove _test
  else
    target_path = path
        :gsub("src/", "test/")       -- replace src/ with test/
        :gsub("%.clj$", "_test.clj") -- add _test
  end

  vim.cmd("edit! " .. target_path)
end

-- vim.keymap.set("n", "<Tab>", switch_source_test, { noremap = true, silent = true })
vim.keymap.set("n", "<Tab>", ':A<CR>')

-- C build
vim.keymap.set('n', '<leader>b', ':!make clean && make<CR>')

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

-- Run Ruby file
vim.keymap.set('n', '<leader>rf', ':!ruby %<CR>', {})

-- Neovim Config
vim.keymap.set('n', '<leader>oc', ':e $MYVIMRC<CR>')

-- NeoTree
vim.keymap.set('n', '<leader>e', ':Neotree filesystem reveal float<CR>')

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
vim.keymap.set('n', '<leader>st', builtin.live_grep, {})
vim.keymap.set('n', '<leader>td', ':Telescope diagnostics<CR>')
