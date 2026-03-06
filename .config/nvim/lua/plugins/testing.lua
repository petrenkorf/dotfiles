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
      local function rspec_cmd()
        if vim.g.rspec_cmd then
          return vim.g.rspec_cmd
        end

        return { "bundle", "exec", "rspec" }
      end

      require("neotest").setup({
        adapters = {
          require("neotest-rspec")({
            rspec_cmd = rspec_cmd
          })
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

        local cmd = table.concat(rspec_cmd(), " ") .. " " .. file .. ":" .. line
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
