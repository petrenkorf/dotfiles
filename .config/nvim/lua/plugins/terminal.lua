return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({})

      local Terminal1 = require("toggleterm.terminal").Terminal
      local Terminal2 = require("toggleterm.terminal").Terminal
      local Terminal3 = require("toggleterm.terminal").Terminal
      local float_term1 = Terminal1:new({ direction = "float" })
      local float_term2 = Terminal2:new({ direction = "float" })
      local float_term3 = Terminal3:new({ direction = "float" })

      local open_term1 = function()
        float_term1:toggle()
      end
      local open_term2 = function()
        float_term2:toggle()
      end
      local open_term3 = function()
        float_term3:toggle()
      end

      vim.keymap.set({ "n", "t" }, "<A-1>", open_term1, { desc = "Toggle Floating Terminal" })
      vim.keymap.set({ "n", "t" }, "!", open_term1, { desc = "Toggle Floating Terminal" })
      vim.keymap.set({ "n", "t" }, "<A-2>", open_term2, { desc = "Toggle Floating Terminal" })
      vim.keymap.set({ "n", "t" }, "@", open_term2, { desc = "Toggle Floating Terminal" })
      vim.keymap.set({ "n", "t" }, "<A-3>", open_term3, { desc = "Toggle Floating Terminal" })
      vim.keymap.set({ "n", "t" }, "#", open_term3, { desc = "Toggle Floating Terminal" })
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
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
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
