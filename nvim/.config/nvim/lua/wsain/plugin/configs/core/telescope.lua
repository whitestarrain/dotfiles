local plugin = require("wsain.plugin.template"):new()
local utils = require("wsain.utils")

plugin.shortUrl = "nvim-telescope/telescope.nvim"
plugin.loadEvent = "VeryLazy"
plugin.dependencies = {
  "GustavoKatel/telescope-asynctasks.nvim",
}

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
        "^.git",
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
      preview = false,
    },
    path_display = { "truncate" },
    winblend = 0,
    extensions = {},
  })

  require("telescope").load_extension("asynctasks")
end
plugin.globalMappings = {
  { "n", "<leader>f", name = "find" },
  { "n", "<leader>ff", ":Telescope find_files hidden=true<CR>", "file" },
  { "n", "<leader>fm", ":Telescope man_pages sections=ALL<CR>", "man_pages" },
  { "n", "<leader>fa", ":Telescope find_files no_ignore=true hidden=true<CR>", "all file" },
  { "n", "<leader>/", ":Telescope buffers sort_mru=true<CR>", "buffer" },
  { "n", "<leader>fc", ":Telescope command_history<CR>", "command_history" },
  { "n", "<leader>fp", ":Telescope<CR>", "telescope buildin" },
  { "n", "<leader>fg", ":Telescope live_grep preview=true<CR>", "grep" },
  { "n", "<leader>fr", ":Telescope resume initial_mode=normal<CR>", "resume" },
  { "n", "<leader>ft", ":Telescope asynctasks all<CR>", "asynctasks" },

  { "v", "<leader>f", name = "find" },
  {
    "v",
    "<leader>ff",
    function()
      require("telescope.builtin").find_files({
        search_file = utils.get_visual_selection_text()[1],
      })
    end,
    "file",
  },
  {
    "v",
    "<leader>fa",
    function()
      require("telescope.builtin").find_files({
        search_file = utils.get_visual_selection_text()[1],
        hidden = true,
        no_ignore = true,
      })
    end,
    "all file",
  },
  {
    "v",
    "<leader>fg",
    function()
      require("telescope.builtin").grep_string({
        search = utils.get_visual_selection_text()[1],
      })
    end,
    "grep",
  },
}

return plugin
