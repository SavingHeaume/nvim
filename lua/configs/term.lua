local api = vim.api
local M = {}
local terminals = {} -- { id = { buf, win, pos, size } }
local g = vim.g

-- 终端位置和尺寸相关的数据
local pos_data = {
  sp = { resize = "height", area = "lines" },
  vsp = { resize = "width", area = "columns" },
  ["bo sp"] = { resize = "height", area = "lines" },
  ["bo vsp"] = { resize = "width", area = "columns" },
}

-- 默认配置
local default_config = {
  sizes = {
    sp = 0.3,
    vsp = 0.3,
    ["bo sp"] = 0.3,
    ["bo vsp"] = 0.3,
  },
  float = {
    relative = "editor",
    border = "rounded",
    width = 0.8,
    height = 0.7,
    row = 0.1,
    col = 0.1,
  },
  winopts = {
    number = false,
    relativenumber = false,
    cursorline = false,
    signcolumn = "no",
  }
}

-- 创建浮动窗口
local function create_float(buffer, float_opts)
  local opts = vim.tbl_deep_extend("force", default_config.float, float_opts or {})

  opts.width = math.ceil(opts.width * vim.o.columns)
  opts.height = math.ceil(opts.height * vim.o.lines)
  opts.row = math.ceil(opts.row * vim.o.lines)
  opts.col = math.ceil(opts.col * vim.o.columns)

  return api.nvim_open_win(buffer, true, opts)
end

-- 格式化命令（支持字符串或函数类型的命令）
local function format_cmd(cmd)
  return type(cmd) == "string" and cmd or cmd()
end

-- 创建或显示窗口
local function display_window(opts)
  local win

  if opts.pos == "float" then
    win = create_float(opts.buf, opts.float_opts)
  else
    vim.cmd(opts.pos)
    win = api.nvim_get_current_win()

    -- 设置窗口尺寸
    local pos_type = pos_data[opts.pos]
    if pos_type then
      local size = opts.size or default_config.sizes[opts.pos] or 0.3
      local new_size = vim.o[pos_type.area] * size
      api["nvim_win_set_" .. pos_type.resize](win, math.floor(new_size))
    end
  end

  -- 绑定缓冲区
  api.nvim_win_set_buf(win, opts.buf)

  -- 设置缓冲区和窗口选项
  vim.bo[opts.buf].buflisted = false
  vim.bo[opts.buf].ft = "MyTerm_" .. (opts.pos:gsub(" ", "") or "default")

  -- 应用窗口选项
  local winopts = vim.tbl_deep_extend("force", default_config.winopts, opts.winopts or {})
  for k, v in pairs(winopts) do
    vim.wo[win][k] = v
  end

  return win
end

-- 创建新终端
local function create_terminal(opts)
  -- 创建或复用缓冲区
  local buf_exists = opts.buf and api.nvim_buf_is_valid(opts.buf)
  opts.buf = buf_exists and opts.buf or api.nvim_create_buf(false, true)

  -- 创建窗口
  local win = display_window(opts)

  -- 如果缓冲区是新创建的，启动终端进程
  if not buf_exists then
    -- 处理命令
    local shell = vim.o.shell
    local cmd = shell

    if opts.cmd then
      cmd = { shell, "-c", format_cmd(opts.cmd) .. "; " .. shell }
    else
      cmd = { shell }
    end

    -- 启动终端
    local termopen_opts = vim.tbl_extend("force", opts.termopen_opts or {}, { detach = false })
    vim.fn.termopen(cmd, termopen_opts)
  end

  -- 立即进入插入模式
  vim.cmd("startinsert")

  -- 保存终端信息
  terminals[opts.id] = {
    buf = opts.buf,
    win = win,
    pos = opts.pos,
    size = opts.size
  }

  return terminals[opts.id]
end

-- 向终端发送命令
local function send_command(term_id, cmd)
  local term = terminals[term_id]
  if term and api.nvim_buf_is_valid(term.buf) then
    local job_id = vim.b[term.buf].terminal_job_id
    if job_id then
      api.nvim_chan_send(job_id, cmd .. "\n")
      return true
    end
  end
  return false
end

-- 公开的API函数

-- 创建新终端
function M.new(opts)
  return create_terminal(opts)
end

-- 切换终端显示状态
function M.toggle(opts)
  local id = opts.id
  local term = terminals[id]

  -- 如果终端已存在且有效
  if term and api.nvim_buf_is_valid(term.buf) then
    local winid = vim.fn.bufwinid(term.buf)

    if winid ~= -1 then
      -- 关闭现有窗口（保留缓冲区）
      api.nvim_win_close(winid, true)
      terminals[id].win = nil
    else
      -- 重新打开窗口（复用原有缓冲区）
      opts.buf = term.buf
      local win = display_window(opts)
      terminals[id].win = win
      vim.cmd("startinsert")
    end
  else
    -- 创建新终端
    create_terminal(opts)
  end
end

-- 创建或复用终端并执行命令
function M.runner(opts)
  local id = opts.id
  local term = terminals[id]
  local clear_cmd = opts.clear_cmd or "clear; "

  -- 如果终端不存在或无效，创建新终端
  if not term or not api.nvim_buf_is_valid(term.buf) then
    create_terminal(opts)
  else
    -- 如果窗口不可见，显示窗口
    if vim.fn.bufwinid(term.buf) == -1 then
      opts.buf = term.buf
      term.win = display_window(opts)
    end

    -- 执行命令
    if opts.cmd then
      local cmd = format_cmd(opts.cmd)
      send_command(id, clear_cmd .. cmd)
    end

    -- 如果不是当前窗口，切换到该窗口
    if api.nvim_get_current_win() ~= term.win then
      api.nvim_set_current_win(term.win)
    end

    vim.cmd("startinsert")
  end
end

-- 终端关闭时清理资源
api.nvim_create_autocmd("TermClose", {
  callback = function(args)
    for id, term in pairs(terminals) do
      if term.buf == args.buf then
        terminals[id] = nil
        break
      end
    end
  end,
})

return M
