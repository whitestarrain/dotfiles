local plugin = require("wsain.plugin.template"):new()
plugin.shortUrl = "luukvbaal/statuscol.nvim"
plugin.config = function()
  local builtin = require("statuscol.builtin")
  local cfg = {
    relculright = true,
    segments = {
      {
        sign = { name = { "Diagnostic" }, maxwidth = 1, auto = true },
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
        sign = { name = { "GitSigns" }, maxwidth = 1, auto = false },
        click = "v:lua.ScSa",
      },
      {
        sign = { name = { "Dap" }, maxwidth = 1, auto = true },
      },
    },
    clickmod = "c",
  }
  require("statuscol").setup(cfg)
end
return plugin
