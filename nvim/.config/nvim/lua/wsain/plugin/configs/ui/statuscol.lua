local plugin = require("wsain.plugin.template"):new()
plugin.shortUrl = "luukvbaal/statuscol.nvim"
plugin.customConfig = function(lsp_mode)
  local status, builtin = pcall(require, "statuscol.builtin")
  if not status then
    return
  end
  local auto_diagnostic_sign = true
  if lsp_mode then
    auto_diagnostic_sign = false
  end
  local cfg = {
    relculright = true,
    -- get all signs:
      -- sign: vim.fn.sign_getplaced(0)
      -- extmark: vim.api.nvim_buf_get_extmarks(0, -1, 0, -1, {type = "sign", details = true})

    -- check plugins's "sign_assign_segment" function to figure out the matching mechanism
    segments = {
      {
        sign = { namespace = { "diagnostic" }, maxwidth = 1, colwidth = 1, auto = auto_diagnostic_sign },
        click = "v:lua.ScSa",
      },
      {
        sign = { name = { ".*" }, maxwidth = 1, colwidth = 1, auto = true },
      },
      {
        text = { builtin.lnumfunc },
        condition = { true, builtin.not_empty },
        click = "v:lua.ScLa",
      },
      {
        sign = { namespace = { "gitsign" }, name = { "Dap" }, maxwidth = 1, colwidth = 1, auto = false },
        click = "v:lua.ScSa",
      },
    },
    clickmod = "c",
  }
  require("statuscol").setup(cfg)
end
plugin.config = function()
  plugin.customConfig(false)
end

plugin.setForLspConfig = function()
  plugin.customConfig(true)
end

return plugin
