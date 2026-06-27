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
        hidden = true,
        on_open = function(term)
          vim.keymap.set("t", "<Esc>", function()
            term:close()
          end, { buffer = term.bufnr, noremap = true, silent = true })
        end,
      })

      local last_rspec_cmd = nil
      local last_rspec_file = nil

      function RunRSpecCurrentLine()
        local file = vim.fn.expand("%:p:.")
        local line = vim.fn.line(".")

        if file == "" then
          print("No file detected")
          return
        end

        local cmd
        if file:match("_spec%.rb$") then
          cmd = table.concat(rspec_cmd(), " ") .. " " .. file .. ":" .. line
          last_rspec_cmd = cmd
          last_rspec_file = file
        elseif last_rspec_cmd then
          cmd = last_rspec_cmd
        else
          print("No spec has been run yet")
          return
        end

        rspec_term:open()
        rspec_term:send(cmd)
      end

      function RunRSpecFile()
        local file = vim.fn.expand("%:p:.")

        local target
        if file:match("_spec%.rb$") then
          target = file
          last_rspec_file = file
        elseif last_rspec_file then
          target = last_rspec_file
        else
          print("No spec has been run yet")
          return
        end

        rspec_term:open()
        rspec_term:send(table.concat(rspec_cmd(), " ") .. " " .. target)
      end

      vim.keymap.set("n", "<leader>tt", function() RunRSpecCurrentLine() end)
      vim.keymap.set("n", "<leader>ta", function() RunRSpecFile() end)
      vim.keymap.set("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end)
      vim.keymap.set("n", "<leader>ts", function() require("neotest").summary.toggle() end)
      vim.keymap.set("n", "<leader>to", function() require("neotest").output.open({ enter = true }) end)
    end
  },
}
