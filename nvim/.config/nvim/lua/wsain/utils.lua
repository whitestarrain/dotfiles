---@diagnostic disable: param-type-mismatch, cast-local-type
local M = {}

M.colors = {
  dark_blue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
  dark_red = "#BE5046",
  diff_red = "#2c1517",
  dark_green = "#59843b",
  dimm_green = "#41602b",
  diff_green = "#1e2718",
  yellow = "#E5C07B",
  diff_yellow = "#3e2e1e",
  dark_yellow = "#D19A66",
  dimm_blue = "#0d4c7f",
  purple = "#C678DD",
  dimm_purple = "#633c6e",
  diff_purple = "#27182C",
  cyan = "#008080",
  white = "#ABB2BF",
  black = "#1f1f1f",
  dimm_black = "#1c1c1c",
  dark_black = "#1a1a1a",
  grey = "#4e4e4e",
  comment_grey = "#5C6370",
  gutter_fg_grey = "#4B5263",
  cursor_grey = "#2C323C",
  dimm_cursor_grey = "#21262d",
  dark_cursor_grey = "#1d2228",
  visual_grey = "#3E4452",
  special_grey = "#3B4048",
  bracket_grey = "#7C828C",
}

-- common function --

function M.emptyFun() end

function M.defaultIfNil(value, default)
  if value == nil then
    return default
  end
  return value
end

function M.merge_tb(origin_tb, custom_tb)
  -- use right table's value when conflict
  origin_tb = origin_tb or {}
  custom_tb = custom_tb or {}
  return vim.tbl_deep_extend("force", origin_tb, custom_tb)
end

function M.list_unique(t)
  local check = {}
  local result = {}
  for _, value in ipairs(t) do
    if not check[value] then
      table.insert(result, value)
      check[value] = true
    end
  end
  return result
end

-- string function --

function M.literalize(str)
  return str:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", function(c)
    return "%" .. c
  end)
end

function M.str_split(inputstr, sep)
  inputstr = inputstr or ""
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

-- system function --

function M.getOs()
  if vim.fn.has("macunix") == 1 then
    return "mac"
  end
  if vim.fn.has("win32") == 1 then
    return "win"
  end
  if vim.fn.has("wsl") == 1 then
    return "wsl"
  end
  return "linux"
end

function M.getOpenCommand()
  local os = M.getOs()
  if os == "win" then
    return {
      cmd = "cmd",
      args = { "/c", "start" },
    }
  end
  if os == "mac" then
    return {
      cmd = "open",
      args = {},
    }
  end
  return {
    cmd = "xdg-open",
    args = {},
  }
end

function M.systemOpen(link)
  local openCmd = M.getOpenCommand()
  local process = {
    cmd = openCmd.cmd,
    args = openCmd.args,
    errors = "\n",
    stderr = vim.loop.new_pipe(false),
  }
  table.insert(process.args, link)
  process.handle, process.pid = vim.loop.spawn(
    process.cmd,
    { args = process.args, stdio = { nil, nil, process.stderr }, detached = true },
    function(code)
      process.stderr:read_stop()
      process.stderr:close()
      process.handle:close()
      if code ~= 0 then
        print(string.format("system_open failed with return code %d: %s", code, process.errors))
      end
    end
  )
  if not process.handle then
    print(string.format("system_open failed to spawn command '%s': %s", process.cmd, process.pid))
    return
  end
  vim.loop.read_start(process.stderr, function(err, data)
    if err then
      return
    end
    if data then
      process.errors = process.errors .. data
    end
  end)
  vim.loop.unref(process.handle)
end

-- file function --

function M.openFileUnderCursor()
  local filePath = vim.fn.expand("<cfile>")
  if filePath == nil or string.len(filePath) < 1 then
    return
  end
  local relatePath
  if string.len(filePath) > 4 and string.sub(filePath, 1, 4) == "http" then
    relatePath = filePath
  else
    local currentFilePath = vim.fn.expand("%:p")
    relatePath = string.sub(currentFilePath, 1, string.len(currentFilePath) - string.len(vim.fn.expand("%:t")) - 1)
    relatePath = relatePath .. "/" .. filePath
    relatePath = vim.fn.substitute(relatePath, "\\", "/", "")
    relatePath = vim.fn.substitute(relatePath, "\\", "/", "")
  end
  M.systemOpen(relatePath)
end

function M.openCurrentFile()
  local filePath = vim.fn.expand("%:p")
  if filePath == nil or string.len(filePath) < 1 then
    return
  end
  M.systemOpen(filePath)
end

function M.check_file_exist(file_path)
  local f = io.open(file_path, "r")
  local flag = false
  if f ~= nil then
    flag = true
    io.close(f)
  end
  return flag
end

function M.get_file_size(file_path)
  local f = io.open(file_path, "rb")
  local size = nil
  if f ~= nil then
    size = f:seek("end")
    io.close(f)
  end
  return size
end

function M.get_download_file_command(url, file_path, timeout, proxy)
  timeout = timeout or 30
  local command = {
    "curl",
    "--connect-timeout",
    timeout,
    url,
    "-s",
    "-o",
    file_path,
  }
  if proxy ~= nil and proxy ~= "" then
    table.insert(command, 2, "--proxy")
    table.insert(command, 3, proxy)
  end
  return command
end

function M.check_dir_or_create(dir_path)
  local os = M.getOs()
  if os == "win" then
    vim.fn.system(string.format([[if not exist "%s" mkdir "%s"]], dir_path, dir_path))
    return
  end
  vim.fn.system(string.format("[[ ! -d %s ]] && mkdir -p %s", dir_path, dir_path))
end

function M.get_default_url_image_name(url)
  if url == nil then
    return
  end
  local param_position = string.find(url, "?", nil, true)
  if param_position ~= nil and param_position > 0 then
    url = string.sub(url, 0, param_position - 1)
  end
  -- image extention name
  local image_extention_name = "png"
  for _, extention_name in ipairs({ "png", "jpg", "jpeg", "gif", "bmp", "svg", "webp" }) do
    local e_start, _ = string.find(url, string.format("%%.%s$", extention_name))
    if e_start ~= nil then
      image_extention_name = extention_name
      break
    end
  end
  -- image name
  local image_name = string.lower(
    string.format(
      "%s-%s-%s.%s",
      vim.fn.expand("%:t:r"),
      os.date("%Y%m%d%H%M%S"),
      math.floor((os.clock() % 1) * 1000000),
      image_extention_name
    )
  )
  return image_name
end

function M.save_markdown_url_images(input_proxy, start_line, end_line)
  local buf_num = vim.api.nvim_get_current_buf()
  local lines
  if start_line ~= nil and end_line ~= nil then
    lines = vim.api.nvim_buf_get_lines(buf_num, start_line - 1, end_line, false)
  else
    lines = vim.api.nvim_buf_get_lines(buf_num, 0, -1, false)
  end
  if lines == nil or #lines == 0 then
    return
  end

  -- get image dir path
  local relative_path = vim.fn.expand("%:h")
  local image_dir = vim.g.mdip_imgdir or "./image"
  local relative_image_path = relative_path .. "/" .. image_dir

  -- ensure dir exist
  M.check_dir_or_create(relative_image_path)

  -- proxy
  local proxy
  if input_proxy then
    proxy = vim.fn.input("proxy: ", "127.0.0.1:7890")
  end

  for line_number, line_content in ipairs(lines) do
    line_number = ((start_line or 1) - 1) + line_number
    local line_index = line_number - 1
    if line_content == nil or line_content == "" or string.sub(line_content, 1, #"<!--") == "<!--" then
      goto continue
    end
    local _, _, md_img_url_text, url = string.find(line_content, "(!%[.-%]%((.-)%))")
    if url == nil or string.sub(url, 1, #"http") ~= "http" then
      goto continue
    end

    local image_name = M.get_default_url_image_name(url)
    local image_path = relative_image_path .. "/" .. image_name
    image_path = vim.fn.substitute(image_path, "\\", "/", "")

    vim.fn.jobstart(M.get_download_file_command(url, image_path, 10, proxy), {
      stdout_buffered = true,
      on_stdout = function()
        local image_size = M.get_file_size(image_path)
        if image_size == nil or image_size < 1024 then
          print(string.format("Download image failed, line %s", line_number))
          if image_size ~= nil then
            os.remove(image_path)
          end
          return
        end
        vim.schedule(function()
          local cur_line_content = vim.api.nvim_buf_get_lines(buf_num, line_index, line_index + 1, false)[1]
          local start_pos, end_pos = string.find(cur_line_content, url, 1, true)
          if start_pos == nil or end_pos == nil then
            print("Image url position changed")
            return
          end
          local md_img_text = string.format("![%s](%s)", image_name, image_dir .. "/" .. image_name)
          local image_line_text = string.gsub(cur_line_content, M.literalize(md_img_url_text), md_img_text)
          vim.api.nvim_buf_set_lines(buf_num, line_index, line_index + 1, false, { image_line_text })
          print(string.format("Download image success, line %s", line_number))
        end)
      end,
    })
    ::continue::
  end
end

-- get a function check whether a buffer open a big file
function M.get_check_bigfile_function(max_length, max_line_length, excluede_file_types)
  return function(bufnr)
    local file_path = vim.api.nvim_buf_get_name(bufnr)
    if file_path == nil or file_path == "" then
      return false
    end
    local common_file_flag = (string.find(file_path, "://") == nil) and (string.find(file_path, ":\\\\") == nil)
    if not common_file_flag then
      return false
    end
    max_length = max_length or 10000
    max_line_length = max_line_length or 1000
    excluede_file_types = excluede_file_types or {}
    local default_excluede_file_types = {
      "NvimTree",
      "fugitive",
      "msnumber",
    }
    for _, file_type in ipairs(default_excluede_file_types) do
      excluede_file_types[#excluede_file_types + 1] = file_type
    end

    local current_file_type = vim.filetype.match({ buf = bufnr })
    local expand_name = vim.fn.expand("%:e")
    for _, file_type in ipairs(excluede_file_types) do
      if current_file_type == file_type then
        return false
      end
      if expand_name == file_type then
        return false
      end
    end
    local getfsize_status, file_size = pcall(vim.fn.getfsize, file_path)
    if not getfsize_status then
      return false
    end
    if file_size < 0 or file_size > 1024 * 1024 then
      return true
    end
    -- you can't use `nvim_buf_line_count` because this runs on BufReadPre
    local readfile_status, file_contents = pcall(vim.fn.readfile, file_path)
    if not readfile_status then
      return false
    end
    local file_length = #file_contents

    if file_length > max_length then
      return true
    end

    for _, line_content in ipairs(file_contents) do
      if #line_content > max_line_length then
        return true
      end
    end
  end
end

-- vim api function --

function M.highlight(group, options)
  local guifg = options.fg or "NONE"
  local guibg = options.bg or "NONE"
  local guisp = options.sp or "NONE"
  local gui = options.gui or "NONE"
  local blend = options.blend or 0
  local ctermfg = options.ctermfg or "NONE"

  vim.cmd(
    string.format(
      "highlight %s guifg=%s ctermfg=%s guibg=%s guisp=%s gui=%s blend=%d",
      group,
      guifg,
      ctermfg,
      guibg,
      guisp,
      gui,
      blend
    )
  )
end

-- https://github.com/Nauticus/dotfiles/blob/master/.config/nvim/lua/config/core/utils.lua
function M.get_visual_selection_text()
  local modeInfo = vim.api.nvim_get_mode()
  local mode = modeInfo.mode

  local cursor = vim.api.nvim_win_get_cursor(0)
  local cline, ccol = cursor[1], cursor[2]
  local vline, vcol = vim.fn.line("v"), vim.fn.col("v")

  local sline, scol
  local eline, ecol
  if cline == vline then
    if ccol <= vcol then
      sline, scol = cline, ccol
      eline, ecol = vline, vcol
      scol = scol + 1
    else
      sline, scol = vline, vcol
      eline, ecol = cline, ccol
      ecol = ecol + 1
    end
  elseif cline < vline then
    sline, scol = cline, ccol
    eline, ecol = vline, vcol
    scol = scol + 1
  else
    sline, scol = vline, vcol
    eline, ecol = cline, ccol
    ecol = ecol + 1
  end

  if mode == "V" or mode == "CTRL-V" or mode == "\22" then
    scol = 1
    ecol = nil
  end

  local lines = vim.api.nvim_buf_get_lines(0, sline - 1, eline, false)
  if #lines == 0 then
    return
  end

  local startText, endText
  if #lines == 1 then
    startText = string.sub(lines[1], scol, ecol)
  else
    startText = string.sub(lines[1], scol)
    endText = string.sub(lines[#lines], 1, ecol)
  end

  local selection = { startText }
  if #lines > 2 then
    vim.list_extend(selection, vim.list_slice(lines, 2, #lines - 1))
  end
  table.insert(selection, endText)

  return selection
end

function M.check_buffer_open(buffer_filetype)
  local win_list =
    vim.fn.filter(vim.fn.range(1, vim.fn.winnr("$")), 'getwinvar(v:val, "&ft") == "' .. buffer_filetype .. '"')
  return next(win_list) ~= nil
end

function M.check_quickfix_open()
  return M.check_buffer_open("qf")
end

-- plugin related function --

function M.addCommandBeforeSaveSession(command)
  local tmp = vim.g.startify_session_before_save or {}
  table.insert(tmp, command)
  vim.g.startify_session_before_save = tmp
end

-- https://github.com/prettier/vim-prettier/blob/master/autoload/prettier/job/runner.vim
function M.prettier_range_format(bufnr, range_start, range_end)
  local start_index = range_start > 0 and range_start - 1 or 0
  local end_index = range_end > 0 and range_end - 1 or 0
  if vim.fn.executable("prettier") ~= 1 then
    return
  end
  local format_cmd = {
    "prettier",
    "--parser=" .. vim.o.filetype,
    "--stdin-filepath=" .. vim.fn.expand("%"),
  }
  local file_path = vim.fn.expand("%")
  if file_path == "" then
    return
  end
  local cmd = table.concat(format_cmd, " ")
  local input_lines = vim.api.nvim_buf_get_lines(bufnr, start_index, end_index + 1, false)
  local output_lines = vim.fn.split(vim.fn.system(cmd, input_lines), "\n")
  vim.api.nvim_buf_set_lines(bufnr, start_index, end_index + 1, false, output_lines)
end

function M.get_current_mapping(key, mode)
  local mapping_list = vim.api.nvim_get_keymap(mode)
  local mapping_map = {}
  for _, mapping in ipairs(mapping_list) do
    mapping_map[mapping["lhs"]] = mapping
  end
  if mapping_map[key] ~= nil then
    if mapping_map[key]["callback"] ~= nil then
      return mapping_map[key]["callback"]
    else
      return function()
        vim.fn.execute(mapping_map[key]["rhs"])
      end
    end
  end
end

-- history function --

function M.recoverLostRuntimepath()
  local rtpBak = vim.api.nvim_list_runtime_paths()
  return function()
    local rtp = vim.api.nvim_list_runtime_paths()
    local markTbl = {}
    for _, value in ipairs(rtp) do
      markTbl[value] = true
    end
    for _, value in ipairs(rtpBak) do
      if markTbl[value] == nil then
        vim.opt.rtp:append(value)
      end
    end
  end
end

function M.visualRange()
  local first_line = vim.fn.line("v")
  local last_line = vim.fn.getpos(".")[2]
  if first_line > last_line then
    return { last_line, first_line }
  end
  return { first_line, last_line }
end

return M
