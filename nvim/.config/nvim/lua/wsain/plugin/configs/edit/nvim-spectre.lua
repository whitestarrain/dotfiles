local plugin = require("wsain.plugin.template"):new()

plugin.short_url = "nvim-pack/nvim-spectre"
plugin.load_event = "VeryLazy"
plugin.config = function()
  require("spectre").setup({
    find_engine = {
      ["rg"] = {
        cmd = "rg",
        -- default args
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        options = {
          ["ignore-case"] = {
            value = "--ignore-case",
            desc = "ignore case",
            icon = "[I]",
          },
          ["hidden"] = {
            value = "--hidden",
            desc = "hidden file",
            icon = "[H]",
          },
          ["no-ignore"] = {
            value = "--no-ignore",
            desc = "no ignore file",
            icon = "[G]",
          },
        },
      },
    },
    mapping = {
      ["quit"] = {
        map = "q",
        cmd = ":q<cr>",
        desc = "quit",
      },
      ["toggle_no_ignore"] = {
        map = "tg",
        cmd = "<cmd>lua require('spectre').change_options('no-ignore')<CR>",
        desc = "toggle no ignore",
      },
    },
  })
end

return plugin
