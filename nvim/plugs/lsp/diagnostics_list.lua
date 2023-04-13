vim.cmd([[
  Plug 'folke/trouble.nvim'
]])

require("au")["User LoadPluginConfig"] = function()
  local status, trouble = pcall(require, "trouble")
  if not status then
    return
  end
  trouble.setup({
    mode = "document_diagnostics",
    auto_open = false,
    auto_close = false,
    auto_preview = false,
    auto_fold = false,
    auto_jump = { "lsp_definitions" },
  })
end
