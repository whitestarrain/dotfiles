-- DEPN: Plug 'nvim-lua/plenary.nvim'
-- DEPN: scoop install ripgrep

-- 记得加冒号`:`
-- 显示高亮时，屏幕滚动可能会有些卡顿，但是利大于弊

vim.cmd([[
  Plug 'folke/todo-comments.nvim'
]])

require("au")["User LoadPluginConfig"] = function()
  local status, todoComments = pcall(require, "todo-comments")
  if not status then
    return
  end

  --NOTE: to fix error report when open command line (q:)
  local hl = require("todo-comments.highlight")
  local highlight_win = hl.highlight_win
  hl.highlight_win = function(win, force)
    pcall(highlight_win, win, force)
  end

  todoComments.setup({
    signs = true,
    sign_priority = 9,
    keywords = {
      FIX = {
        icon = " ",
        color = "error",
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
      },
      TODO = { icon = " ", color = "#ffbb00" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX", "WARN" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      DEPN = { icon = " ", color = "#1e90ff" },
    },
    merge_keywords = true,
    highlight = {
      before = "",
      keyword = "wide",
      after = "fg",
      pattern = [[.*<(KEYWORDS)\s*:]],
      comments_only = false,
      max_line_len = 400,
      exclude = {},
    },
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
      warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
      info = { "DiagnosticInfo", "#ffbb00" },
      hint = { "DiagnosticHint", "#10B981" },
      default = { "Identifier", "#7C3AED" },
    },
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },
      pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    },
  })
end
