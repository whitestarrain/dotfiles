Plug 'goolord/alpha-nvim'
Plug 'Shatur/neovim-session-manager'

autocmd vimenter * call PlugConfigHomePage()
function! PlugConfigHomePage()
  lua  require'alpha'.setup(require'alpha.themes.dashboard'.opts)
endfunction

