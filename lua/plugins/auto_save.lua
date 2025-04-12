local M = {
  {
    -- auto-save自动保存
    "okuuva/auto-save.nvim",
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
    opts = {
    },
  },
}

return M
