---@diagnostic disable: assign-type-mismatch, unused-local
local Template = require("wsain.plugin.template")
local plugin = Template:new()

plugin.shortUrl = "akinsho/bufferline.nvim"
plugin.dependencies = { "kyazdani42/nvim-web-devicons" }

plugin.config = function()
  local status, bufferline = pcall(require, "bufferline")
  if not status then
    return
  end
  local separator_style = { "", "" }

  bufferline.setup({
    options = {
      diagnostics = "nvim_lsp",
      separator_style = separator_style,
      -- left offset
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "center",
        },
      },
      -- icon
      buffer_close_icon = "",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      indicator = {
        icon = " ",
        style = "icon",
      },
      -- show config
      show_buffer_close_icons = false,
      show_close_icon = false,
      show_buffer_icons = true,
      -- lsp icon
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " " or (e == "warning" and " " or "")
          s = s .. n .. sym
        end
        return s
      end,
    },
  })

  vim.keymap.set("n", "<M-h>", ":BufferLineCyclePrev<CR>")
  vim.keymap.set("n", "<M-l>", ":BufferLineCycleNext<CR>")
end

return plugin
