return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "olimorris/neotest-rspec" },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-rspec")
        }
      })

      local Terminal = require('toggleterm.terminal').Terminal

      local rspec_term = Terminal:new({
        direction = "float",
        hidden = true
      })

      function RunRSpecCurrentLine()
        local file = vim.fn.expand("%:p:.")
        local line = vim.fn.line(".")

        if file == "" then
          print("No file detected")
          return
        end

        local cmd = string.format("bundle exec rspec %s:%d", file, line)

        rspec_term:toggle()
        rspec_term:send(cmd)
      end

      vim.keymap.set("n", "<leader>tt", function() RunRSpecCurrentLine() end)
      vim.keymap.set("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end)
      vim.keymap.set("n", "<leader>ts", function() require("neotest").summary.toggle() end)
      vim.keymap.set("n", "<leader>to", function() require("neotest").output.open({ enter = true }) end)
    end
  },
}
