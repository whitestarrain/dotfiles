local utils = require("wsain.utils")
local plugin = require("wsain.plugin.template"):new()

plugin.globalMappings = {
  { "n", "<leader>d", ":bp|bd #<cr>", "delete buffer" },

  { "n", "<leader>z", name = "+others" },
  { "n", "<leader>zp", ":syntax sync fromstart<cr>", "syntax sync" },
  { "n", "<leader>zl", ":%s/\\v(\\n\\s*){2,}/\\r\\r/<cr> :/jkjk<cr>", "compress blank line" },
  { "n", "<leader>zf", ':echo expand("%:p")<cr>', "show file path" },
  { "n", "<leader>zu", require("wsain.utils").openFileUnderCursor, "open file under cursor" },
  { "n", "<leader>zo", require("wsain.utils").openCurrentFile, "open current file" },
  { "n", "<leader>m", name = "markdown" },
  {
    "n",
    "<leader>md",
    function()
      utils.save_image_by_url()
    end,
    "download url image",
  },
}

return plugin
