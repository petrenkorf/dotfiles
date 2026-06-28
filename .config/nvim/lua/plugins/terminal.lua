return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({})

      local Terminal1 = require("toggleterm.terminal").Terminal
      local Terminal2 = require("toggleterm.terminal").Terminal
      local Terminal3 = require("toggleterm.terminal").Terminal

      local close_on_esc = function(term)
        vim.keymap.set("t", "<Esc>", function()
          term:close()
        end, { buffer = term.bufnr, noremap = true, silent = true })
      end

      local float_term1 = Terminal1:new({ direction = "float", on_open = close_on_esc })
      local float_term2 = Terminal2:new({ direction = "float", on_open = close_on_esc })
      local float_term3 = Terminal3:new({ direction = "float", on_open = close_on_esc })

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
    "christoomey/vim-tmux-navigator",
    vim.keymap.set("n", "C-h", ":TmuxNavigateLeft<CR>"),
    vim.keymap.set("n", "C-j", ":TmuxNavigateDown<CR>"),
    vim.keymap.set("n", "C-k", ":TmuxNavigateUp<CR>"),
    vim.keymap.set("n", "C-l", ":TmuxNavigateRight<CR>"),
  },
}
