local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "nvim-telescope/telescope.nvim"
plugin.loadEvent = "VeryLazy"

plugin.config = function()
  local actions = require("telescope.actions")

  require("telescope").setup({
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },
      -- lua regex
      file_ignore_patterns = {
        ".git",
        "%.png",
        "%.jpg",
        "%.jpeg",
        "%.exe",
        "%.pdf",
        "%.doc",
        "%.docx",
        "%.tux",
        "%.cache",
        "%.gif",
        "%.mm",
      },
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      prompt_prefix = "❯ ",
      layout_config = {
        prompt_position = "top",
        vertical = {
          mirror = false,
        },
        preview_cutoff = 120,
      },
      initial_mode = "insert",
      --  can use <C-l> in insert mode to cycle/complete tags, i.e. either diagnostic severity or symbols (classes, functions, methods, ...)
      mappings = {
        n = {
          ["q"] = actions.close,
          ["/"] = function()
            vim.cmd("startinsert")
          end,
          ["h"] = actions.cycle_history_prev,
          ["l"] = actions.cycle_history_next,
        },
      },
    },
    path_display = { "truncate" },
    winblend = 0,
    extensions = {},
    preview = {
      timeout = 500,
    },
  })
end
plugin.globalMappings = {
  { "n", "<leader>ff", ":Telescope find_files<CR>", "file" },
  { "n", "<leader>fa", ":Telescope find_files no_ignore=true hidden=true<CR>", "all file" },
  { "n", "<leader>/", ":Telescope buffers sort_mru=true<CR>", "buffer" },
  { "n", "<leader>fc", ":Telescope commands<CR>", "command" },
  { "n", "<leader>fp", ":Telescope<CR>", "telescope buildin" },
  { "n", "<leader>fg", ":Telescope live_grep<CR>", "grep" },
  { "n", "<leader>fr", ":Telescope resume initial_mode=normal<CR>", "resume" },
}

return plugin
