vim.cmd([[
  Plug 'skywind3000/asynctasks.vim'
  Plug 'skywind3000/asyncrun.vim'
  Plug 'GustavoKatel/telescope-asynctasks.nvim'
]])

vim.g.asyncrun_open = 6
vim.g.asynctasks_term_pos = "external"
vim.g.asynctasks_extra_config = {
  vim.g.absolute_config_path .. "./others/tasks.ini",
}

require("au")["User LoadPluginConfig"] = function()
  local status, telescope = pcall(require, "telescope")
  if not status then
    return
  end

  telescope.load_extension('asynctasks')

  vim.cmd([[
    nnoremap <silent><leader>ft :Telescope asynctasks all<CR>
    let g:which_key_map.f.t = 'find tasks'
  ]])
end
