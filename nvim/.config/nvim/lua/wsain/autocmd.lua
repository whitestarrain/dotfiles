local utils = require("wsain.utils")
local bigfile_feature_handler = require("wsain.bigfile")

-- highlight autocmd
local bgHighLightAugroup = vim.api.nvim_create_augroup("BgHighlight", { clear = true })
vim.api.nvim_create_autocmd("WinEnter", {
  group = bgHighLightAugroup,
  callback = function()
    vim.opt.cul = true
  end,
})
vim.api.nvim_create_autocmd("WinLeave", {
  group = bgHighLightAugroup,
  callback = function()
    vim.opt.cul = false
  end,
})

local special_file_types = {
  "NvimTree",
  "TelescopePrompt",
  "checkhealth",
  "dirbuf",
  "dirvish",
  "floaterm",
  "floaterm",
  "fugitive",
  "help",
  "leadf",
  "lspinfo",
  "man",
  "msnumber",
  "packer",
  "startify",
}

-- bigfile autocmd
local bigfile_check_flag = "big_file_check_flag"
local function bigfile_handler(bufnr)
  local file_type = vim.fn.getbufvar(bufnr, "&filetype")

  -- special file
  if file_type == nil then
    return
  end
  local expand_name = vim.fn.expand("%:e")
  for _, s_type in ipairs(special_file_types) do
    if file_type == s_type or expand_name == s_type then
      return
    end
  end
  -- cmdwin
  if file_type == "vim" and vim.fn.getcmdwintype() == ":" then
    return
  end

  -- markdown
  if file_type == "markdown" then
    if vim.api.nvim_buf_line_count(bufnr) > 2000 then
      bigfile_feature_handler.enable_indent_blankline(bufnr)
      return
    else
      bigfile_feature_handler.enable_treesitter_highlight(bufnr)
      bigfile_feature_handler.enable_indent_blankline(bufnr)
      return
    end
  end

  local status_ok, flag = pcall(vim.api.nvim_buf_get_var, bufnr, bigfile_check_flag)
  local is_bigfile
  if status_ok then
    is_bigfile = flag
  else
    is_bigfile = utils.get_check_bigfile_function(1024 * 1024, 10000, 1000)(bufnr)
  end
  vim.api.nvim_buf_set_var(bufnr, bigfile_check_flag, is_bigfile)

  -- bigfile
  if is_bigfile then
    bigfile_feature_handler.disable_treesitter(bufnr)
    bigfile_feature_handler.disable_vimopts(bufnr)
    bigfile_feature_handler.disable_illuminate(bufnr)
    return
  end

  -- common file
  bigfile_feature_handler.enable_treesitter_highlight(bufnr)
  bigfile_feature_handler.enable_rainbow(bufnr)
  bigfile_feature_handler.enable_indent_blankline(bufnr)
end

local HeavyTreesitterEnableGroup = vim.api.nvim_create_augroup("HeavyTreesitterEnable", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
  group = HeavyTreesitterEnableGroup,
  callback = vim.schedule_wrap(function(args)
    bigfile_handler(args.buf)
  end),
})
