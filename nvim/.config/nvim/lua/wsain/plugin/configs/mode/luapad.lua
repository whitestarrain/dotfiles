local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "rafcamlet/nvim-luapad"
plugin.loadEvent = "VeryLazy"

plugin.config = function()
  require("luapad").setup({
    count_limit = 150000,
    error_indicator = false,
    eval_on_move = true,
    error_highlight = "WarningMsg",
    split_orientation = "horizontal",
    on_init = function()
    end,
    context = {
      the_answer = 42,
      shout = function(str)
        return (string.upper(str) .. "!")
      end,
    },
  })

  require("wsain.plugin.whichkey").register({
    { "<leader>zm", group = "+mode" },
    {
      "<leader>zml",
      function()
        require("luapad").toggle({})
      end,
      desc = "luapad toggle",
    },
  })
end

return plugin
