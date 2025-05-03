local fn = function()
  local x = vim.diagnostic.severity

  vim.diagnostic.config({
    virtual_text = { prefix = "" }, -- 行内显示错误
    signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } }, -- 行号旁显示标记
    update_in_insert = false,
  })

  vim.lsp.inlay_hint.enable()

  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "lua_ls",
      "rust_analyzer",
      "pyright",
      "clangd",
    },
  })

  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  local on_attach = function(client, bufnr)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
  end

  require("mason-lspconfig").setup_handlers({
    function(server_name)
      lspconfig[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities
      })
    end,
    ["lua_ls"] = function()
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } }
          }
        }
      })
    end,
    ["clangd"] = function()
      lspconfig.clangd.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--all-scopes-completion",
          "--completion-style=detailed",
          "--fallback-style=llvm",
        },
      })
    end,
    ["rust_analyzer"] = function()
      lspconfig.rust_analyzer.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            check = {
              allTargets = false,
            }
          }
        }
      })
    end
  })
end

return fn
