vim.cmd([[
  Plug 'simrat39/symbols-outline.nvim'
]])

require("au")["User LoadPluginConfig"] = function()
  local status, symbolsOutline = pcall(require, "symbols-outline")
  if not status then
    return
  end
  symbolsOutline.setup({
    keymaps = { -- These keymaps can be a string or a table for multiple keys
      close = { "<Esc>", "q" },
      goto_location = "<Cr>",
      focus_location = "o",
      hover_symbol = "K",
      toggle_preview = "P",
      rename_symbol = "r",
      -- code_actions = "a",
      fold = "h",
      unfold = "l",
      fold_all = "W",
      unfold_all = "E",
      fold_reset = "R",
    },
    symbols = {
      File = { icon = "", hl = "@URI" },
      Module = { icon = "", hl = "@Namespace" },
      Namespace = { icon = "", hl = "@Namespace" },
      Package = { icon = "", hl = "@Namespace" },
      Class = { icon = "ﴯ", hl = "@Type" },
      Method = { icon = "ƒ", hl = "@Method" },
      Property = { icon = "", hl = "@Method" },
      Field = { icon = "ﰠ", hl = "@Field" },
      Constructor = { icon = "", hl = "@Constructor" },
      Enum = { icon = "ℰ", hl = "@Type" },
      Interface = { icon = "ﰮ", hl = "@Type" },
      Function = { icon = "", hl = "@Function" },
      Variable = { icon = "", hl = "@Constant" },
      Constant = { icon = "", hl = "@Constant" },
      String = { icon = "", hl = "@String" },
      Number = { icon = "#", hl = "@Number" },
      Boolean = { icon = "⊨", hl = "@Boolean" },
      Array = { icon = "", hl = "@Constant" },
      Object = { icon = "⦿", hl = "@Type" },
      Key = { icon = "", hl = "@Type" },
      Null = { icon = "NULL", hl = "@Type" },
      EnumMember = { icon = "", hl = "@Field" },
      Struct = { icon = "פּ", hl = "@Type" },
      Event = { icon = "", hl = "@Type" },
      Operator = { icon = "+", hl = "@Operator" },
      TypeParameter = { icon = "", hl = "@Parameter" },
    },
  })

  vim.cmd([[
    " starify，seesion关闭时执行操作
    if exists("g:startify_session_before_save")
      let g:startify_session_before_save +=  ['silent! SymbolsOutlineClose']
    endif
  ]])
end
