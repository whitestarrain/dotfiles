local plugin = require("wsain.plugin.template"):new()
plugin.short_url = "norcalli/nvim-colorizer.lua"
plugin.load_event = "VeryLazy"
plugin.config = function()
  require("colorizer").setup({ "json", "xml", "html", "css", "ps1", "lua", "vim", "yaml" })
  require("wsain.plugin.whichkey").register({
    { "<leader>zm", group = "+mode" },
    {
      "<leader>zmc",
      function()
        vim.cmd([[ColorizerToggle]])
      end,
      desc = "color",
    },
  })
end

return plugin
