-- DEPN: scoop install shellcheck
require('lspconfig')['efm'].setup{
  init_options = {documentFormatting = true},
  settings = {
    rootMarkers = {".git/"},
    languages = {
      --[[ lua = {
        {formatCommand = "lua-format -i", formatStdin = true}
      } ]]
    }
  }
  filetypes = {'sh'}, -- Populate this according to the note below
  single_file_support = false, -- This is the important line for supporting older version of EFM
}
