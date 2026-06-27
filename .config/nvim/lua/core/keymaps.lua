-- Switch between source and tests
local function switch_source_test()
  local path = vim.fn.expand("%:p")
  local target_path

  if path:match("_test%.clj$") then
    target_path = path
        :gsub("test/", "src/")
        :gsub("_test%.clj$", ".clj")
  elseif path:match("%.clj$") then
    target_path = path
        :gsub("src/", "test/")
        :gsub("%.clj$", "_test.clj")
  elseif path:match("_spec%.rb$") then
    target_path = path
        :gsub("spec/", "app/", 1)
        :gsub("_spec%.rb$", ".rb")
    if not vim.loop.fs_stat(target_path) then
      target_path = path
          :gsub("spec/", "lib/", 1)
          :gsub("_spec%.rb$", ".rb")
    end
  elseif path:match("%.rb$") then
    local rel = path:gsub("^.*/app/", ""):gsub("^.*/lib/", "")
    local spec_dir = path:match("^(.*)/app/") or path:match("^(.*)/lib/")
    if spec_dir then
      target_path = spec_dir .. "/spec/" .. rel:gsub("%.rb$", "_spec.rb")
    end
  end

  if target_path then
    vim.cmd("edit! " .. target_path)
  end
end
vim.keymap.set("n", "<Tab>", switch_source_test, { noremap = true, silent = true })

-- Prevent toggleterm to close
vim.keymap.set('t', '@', '@', { noremap = true })

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

-- Neovim Config
vim.keymap.set('n', '<leader>oc', ':e $MYVIMRC<CR>')

-- NeoTree
vim.keymap.set('n', '<leader>e', ':Neotree filesystem reveal float<CR>')

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
vim.keymap.set('n', '<leader>st', builtin.live_grep, {})
vim.keymap.set('n', '<leader>td', ':Telescope diagnostics<CR>')
