return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "olimorris/neotest-rspec",
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter"
    },
    config = function()
      local neotest = require("neotest")
      neotest.setup({
        adapters = {
          require("neotest-rspec")({
            rspec_cmd = function()
              return vim.tbl_flatten({
                "bundle",
                "exec",
                "rspec"
              })
            end
          })
        }
      })

      local Terminal = require("toggleterm.terminal").Terminal

      local rspec_term = Terminal:new({
        direction = "float",
        hidden = true,
      })

      local last_rspec_cmd = nil

      function RunRSpecCurrentLine()
        local file = vim.fn.expand("%")
        local line = vim.fn.line(".")

        if file == "" then
          print("No file detected")
          return
        end

        local cmd
        if file:match("_spec%.rb$") then
          cmd = string.format("bundle exec rspec %s:%d", file, line)
          last_rspec_cmd = cmd
        elseif last_rspec_cmd then
          cmd = last_rspec_cmd
        else
          print("No spec has been run yet")
          return
        end

        rspec_term:toggle()
        rspec_term:send(cmd)
      end

      vim.keymap.set("n", "<leader>tt", function()
        RunRSpecCurrentLine()
      end)
      vim.keymap.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end,
        { desc = "Run current file" })
      vim.keymap.set("n", "<leader>ts", function() neotest.summary.toggle() end, { desc = "Toggle test summary" })
      vim.keymap.set("n", "<leader>to", function() neotest.output.open({ enter = true }) end,
        { desc = "Show test output" })
    end
  },
}
