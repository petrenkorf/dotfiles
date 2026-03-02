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
