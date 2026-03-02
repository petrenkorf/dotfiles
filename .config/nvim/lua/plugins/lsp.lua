return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "clojure_lsp" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      lspconfig.terraformls.setup({
        on_attach = function(client, bufnr)
          -- optional, but nice to have:
          vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
        end,
        capabilities = capabilities,
        filetypes = { "terraform", "tf", "hcl" },
        cmd = { vim.fn.stdpath("data") .. "/mason/bin/terraform-ls", "serve" },
        root_dir = require('lspconfig.util').root_pattern(".terraform", ".terraform.lock.hcl", ".git"),
        settings = {
          terraform = {
            languageServer = {
              experimentalFeatures = {
                validateOnSave = true,
                schema = true,
              },
            },
          },
        },
      })
      lspconfig.elixirls.setup({
        capabilities = capabilities
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.clojure_lsp.setup({
        capabilities = capabilities
      })
      lspconfig.ruby_lsp.setup({
        capabilities = capabilities
      })
      lspconfig.emmet_language_server.setup({
        capabilities = capabilities,
        filetypes = { "typscriptreact", "typescript" }
      })
      lspconfig.clangd.setup({
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git")
      })
      lspconfig.jdtls.setup({
        cmd = "jdtls",
        settings = {
          java = {
            signatureHelp = { enabled = true },
            completion = { favoriteStaticMembers = { "org.junit.Assert.*", "java.util.Objects.*" } }
          }
        }
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- null_ls.builtins.diagnostics.rubocop,
          -- null_ls.builtins.formatting.rufo,
          null_ls.builtins.formatting.prettier.with({
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "jsx", "tsx" }
          }),
          null_ls.builtins.diagnostics.clj_kondo,
          null_ls.builtins.formatting.cljfmt,
        }
      })


      vim.keymap.set("n", "<leader>nf", vim.lsp.buf.format, {})

      vim.diagnostic.config({
        virtual_text = {
          prefix = "●", -- Could be '■', '▎', '▌', '▶', or a character you like
          spacing = 2,
        },
        signs = true,             -- Show signs in the gutter
        underline = true,         -- Underline problematic code
        update_in_insert = false, -- Whether to update diagnostics in insert mode
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.rb", "*.clj", "*.lua", "*.tsx", "*.ts", "*.jsx", "*.tf" },
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  },
}
