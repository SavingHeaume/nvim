local fn = function()
  local x = vim.diagnostic.severity
  vim.diagnostic.config({
    virtual_text = { prefix = "" }, -- 行内显示错误
    signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } }, -- 行号旁显示标记
    update_in_insert = false,
  })

  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "lua_ls",
      "rust_analyzer",
      "pyright",
      "clangd",
    },
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()

  local on_attach = function(_, bufnr)
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
  end

  vim.lsp.config("*", {
    on_attach = on_attach,
    capabilities = capabilities,
  })

  vim.lsp.config("lua_ls", {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = { globals = { "vim", "require" } }
      }
    }

  })

  vim.lsp.config("rust_analyzer", {
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

  vim.lsp.config("clangd", {
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
end

return fn
