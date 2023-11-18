local plugin = require("wsain.plugin.template"):new()
plugin.shortUrl = "luukvbaal/statuscol.nvim"
plugin.customConfig = function(lsp_mode)
  local builtin = require("statuscol.builtin")
  local auto_diagnostic_sign = true
  if lsp_mode then
    auto_diagnostic_sign = false
  end
  local cfg = {
    relculright = true,
    segments = {
      {
        sign = { name = { "Diagnostic" }, maxwidth = 1, auto = auto_diagnostic_sign },
        click = "v:lua.ScSa",
      },
      {
        sign = { name = { ".*" }, maxwidth = 1, auto = true },
      },
      {
        text = { builtin.lnumfunc, "" },
        condition = { true, builtin.not_empty },
        click = "v:lua.ScLa",
      },
      {
        sign = { namespace = { "gitsign" }, name = { "Dap" }, maxwidth = 1, auto = false },
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
