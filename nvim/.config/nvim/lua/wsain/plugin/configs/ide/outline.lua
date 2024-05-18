local plugin = require("wsain.plugin.template"):new()
local utils = require("wsain.utils")

plugin.shortUrl = "stevearc/aerial.nvim"
plugin.loadEvent = "VeryLazy"
plugin.dependencies = {
  "nvim-treesitter/nvim-treesitter",
  "nvim-tree/nvim-web-devicons",
}
plugin.config = function()
  require("aerial").setup({
    backends = { "lsp", "treesitter" },
    on_attach = function(bufnr)
      vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
      vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end,
    filter_kind = false,
    -- To see all available values, see :help SymbolKind
    -- filter_kind = {
    --   "Class",
    --   "Constructor",
    --   "Enum",
    --   "Function",
    --   "Interface",
    --   "Module",
    --   "Method",
    --   "Struct",
    -- },
  })
  utils.addCommandBeforeSaveSession("silent! AerialClose")
end

plugin.globalMappings = {
  { "n", "<leader>ct", ":AerialToggle<CR>", "outline" },
  { "n", "<leader>cT", ":AerialNavToggle<CR>", "outline nav" },
}

return plugin
