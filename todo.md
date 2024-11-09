todo:

- [x] nvim
  - bigfile
  - [x] treesitter default disable, enable through event
    - [x] treesitter should be disable by BufReaPre
    <!-- - [ ] abstract as feature -->
    - [x] autocmd support `once` param, create BufReadPost event in BufReaPre callback
    - [x] skip nobuflisted buffer
    - [ ] big file trim space too slow, default disable trim
    - [x] java single file run
    - [x] replace netrw: [nvim dired](https://github.com/X3eRo0/dired.nvim)
      - [x] fork and add file type support: socket, pipe, byte service, char service
      - [x] don't change cwd
      - [ ] fix: python venv cursor position
      - [ ] go_up function, history
      - [ ] nvim_set_current_dir
  - lsp
    - [ ] lsp rename file support: [nvim-lsp-file-operations](https://github.com/antosha417/nvim-lsp-file-operations)
  - others
    - [x] compile mode, autocomplete (update plugin)
    - [x] vim-matchup, bash can't complete 'for'
  - treesitter
    - [treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
- bash
  - [x] history drop dup
  - [ ] parse markdown, repo collect
- tmux
  - [ ] color theme
  - [x] iterm2 osc, mac need set clipboard

    ```tmux
    # set -as terminal-overrides ',tmux*:Ms=\\E]52;%p1%s;%p2%s\\007'
    # set -as terminal-overrides ',screen*:Ms=\\E]52;%p1%s;%p2%s\\007'
    set -s set-clipboard on
    ```
  - terminfo support delete_line

- [ ] md-section-number plugin, create command through lua rather than vimscript
  - vimscript can't hold lazy.nvim's VeryLazy event


