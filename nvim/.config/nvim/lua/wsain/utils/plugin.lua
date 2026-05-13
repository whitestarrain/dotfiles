local M = {}

---@param command string
function M.add_command_before_save_session(command)
  local tmp = vim.g.startify_session_before_save or {}
  table.insert(tmp, command)
  vim.g.startify_session_before_save = tmp
end

---@param bufnr integer
---@param range_start integer
---@param range_end integer
function M.prettier_range_format(bufnr, range_start, range_end)
  -- https://github.com/prettier/vim-prettier/blob/master/autoload/prettier/job/runner.vim
  local start_index = range_start > 0 and range_start - 1 or 0
  local end_index = range_end > 0 and range_end - 1 or 0
  if vim.fn.executable("prettier") ~= 1 then
    return
  end
  local format_cmd = {
    "prettier",
    "--parser=" .. vim.o.filetype,
    "--stdin-filepath=" .. vim.fn.expand("%"),
  }
  local file_path = vim.fn.expand("%")
  if file_path == "" then
    return
  end
  local cmd = table.concat(format_cmd, " ")
  local input_lines = vim.api.nvim_buf_get_lines(bufnr, start_index, end_index + 1, false)
  local output_lines = vim.fn.split(vim.fn.system(cmd, input_lines), "\n")
  vim.api.nvim_buf_set_lines(bufnr, start_index, end_index + 1, false, output_lines)
end

local cmp_mode = false
---@param mode? boolean
function M.toggle_auto_cmp(mode)
  mode = mode or not cmp_mode
  cmp_mode = mode
  local status, cmp = pcall(require, "cmp")
  if not status then
    return
  end
  if mode then
    cmp.setup({
      completion = {
        autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
      },
    })
  else
    cmp.setup({
      completion = {
        autocomplete = false,
      },
    })
  end
end

---@param lang string
---@param module string ts module name, such as 'highlights', 'indents', 'folds'
---@return boolean
function M.check_treesitter_support(lang, module)
  local status, _ = pcall(require, "nvim-treesitter")
  if not status then
    return false
  end

  lang = vim.treesitter.language.get_lang(lang)
  if not lang then
    return false
  end

  return vim.treesitter.query.get(lang, module) ~= nil
end

return M
