return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup()
    end
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd.colorscheme "carbonfox"
    end
  },
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('tokyonight').setup({
  --       transparent = true
  --     })
  --     vim.cmd.colorscheme "tokyonight-storm"
  --   end
  -- },
  {
    "nvim-telescope/telescope.nvim",
    name = "telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim"
    },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({})
          }
        },
        defaults = {
          file_ignore_patterns = { "resources/", "node_modules/" }
        }
      })

      require("telescope").load_extension("ui-select")
    end
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
        },
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim"
    } --,
    -- config = function()
    --   vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
    --   vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
    -- end
  },
  {
    "folke/zen-mode.nvim"
  },
}
