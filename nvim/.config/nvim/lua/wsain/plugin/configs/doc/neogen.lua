local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "danymat/neogen"
plugin.loadEvent = "VeryLazy"
plugin.dependencies = {
  "nvim-treesitter/nvim-treesitter",
}
plugin.config = function()
  require("neogen").setup({
    enabled = true,
    languages = {
      lua = {
        template = {
          annotation_convention = "ldoc",
        },
      },
      python = {
        template = {
          annotation_convention = "google_docstrings",
        },
      },
      rust = {
        template = {
          annotation_convention = "rustdoc",
        },
      },
      javascript = {
        template = {
          annotation_convention = "jsdoc",
        },
      },
      typescript = {
        template = {
          annotation_convention = "tsdoc",
        },
      },
      typescriptreact = {
        template = {
          annotation_convention = "tsdoc",
        },
      },
    },
  })

  require("wsain.plugin.whichkey").register({
    { "<leader>c", group = "code" },
    {
      "<leader>cg",
      function()
        require("neogen").generate()
      end,
      desc = "generate doc",
    },
  })
end

return plugin
