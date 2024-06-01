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
      vim.keymap.set("n", "[s", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "prev symbol" })
      vim.keymap.set("n", "]s", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "next symbol" })
    end,
    filter_kind = false,
  })
  utils.addCommandBeforeSaveSession("silent! AerialClose")
end

plugin.globalMappings = {
  { "n", "<leader>ct", ":AerialToggle<CR>", "outline" },
}

return plugin
