local plugin = require("wsain.plugin.template"):new()
local utils = require("wsain.utils")

plugin.shortUrl = "nvim-telescope/telescope.nvim"
plugin.loadEvent = "VeryLazy"
plugin.dependencies = {
  "GustavoKatel/telescope-asynctasks.nvim",
  "nvim-telescope/telescope-live-grep-args.nvim",
}

plugin.config = function()
  local actions = require("telescope.actions")
  local mappings = {
    n = {
      ["q"] = actions.close,
      ["/"] = function()
        vim.cmd("startinsert")
      end,
      ["h"] = actions.cycle_history_prev,
      ["l"] = actions.cycle_history_next,
      ["<C-k>"] = require("telescope.actions.layout").toggle_preview,
    },
    i = {
      ["<C-k>"] = require("telescope.actions.layout").toggle_preview,
    },
  }

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
        preview_cutoff = 0,
      },
      initial_mode = "insert",
      --  can use <C-l> in insert mode to cycle/complete tags, i.e. either diagnostic severity or symbols (classes, functions, methods, ...)
      mappings = mappings,
      preview = {
        hide_on_startup = true, -- hide previewer when picker starts
      },
    },
    path_display = { "truncate" },
    winblend = 0,
    extensions = {},
  })

  require("telescope").load_extension("asynctasks")
  require("telescope").load_extension("live_grep_args")

  require("wsain.plugin.whichkey").register({
    { "<leader>f", group = "find", mode = "v" },
    { "<leader>f", group = "find", mode = "n" },
    { "<leader>ff", ":Telescope find_files hidden=true<CR>", desc = "file" },
    {
      "<leader>fm",
      ":Telescope man_pages sections=ALL<CR>",
      desc = "man_pages",
    },
    {
      "<leader>fa",
      ":Telescope find_files no_ignore=true hidden=true<CR>",
      desc = "all file",
    },
    { "<leader>k", ":Telescope buffers sort_mru=true<CR>", desc = "buffer" },
    { "<leader>fe", ":Telescope buffers sort_mru=true<CR>", desc = "buffer" },
    {
      "<leader>fc",
      ":Telescope command_history<CR>",
      desc = "command_history",
    },
    {
      "<leader>fp",
      ":Telescope<CR>",
      desc = "telescope buildin",
    },
    { "<leader>fg", ":Telescope live_grep<CR>", desc = "grep" },
    {
      "<leader>fG",
      function()
        require("telescope").extensions.live_grep_args.live_grep_args({ mappings = mappings })
      end,
      desc = "grep with args",
    },
    {
      "<leader>fr",
      function()
        require("telescope.builtin").resume({ initial_mode = "normal" })
      end,
      desc = "resume",
    },
    {
      "<leader>ft",
      ":Telescope asynctasks all<CR>",
      desc = "asynctasks",
    },
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files({ search_file = utils.get_visual_selection_text()[1] })
      end,
      desc = "file",
      mode = "v",
    },
    {
      "<leader>fa",
      function()
        require("telescope.builtin").find_files({
          search_file = utils.get_visual_selection_text()[1],
          hidden = true,
          no_ignore = true,
        })
      end,
      desc = "all file",
      mode = "v",
    },
    {
      "<leader>fg",
      function()
        require("telescope.builtin").grep_string({ search = utils.get_visual_selection_text()[1] })
      end,
      desc = "grep",
      mode = "v",
    },
    { "<leader>c", group = "code", mode = "n" },
    {
      "<leader>cj",
      function()
        require("telescope.builtin").lsp_document_symbols()
      end,
      desc = "symbol jump(document)",
      mode = "n",
    },
    {
      "<leader>cJ",
      function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols()
      end,
      desc = "symbol jump(workspace)",
      mode = "n",
    },
  })
end

return plugin
