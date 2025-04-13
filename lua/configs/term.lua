local api = vim.api
local M = {}
local terminals = {} -- { id = { buf, win, pos, size } }

local function create_window(opts, term)
  -- 执行分屏命令（使用用户传入的 pos）
  vim.cmd(opts.pos)
  local win = api.nvim_get_current_win()

  -- 设置窗口尺寸
  local size = opts.size or (term and term.size) or 0.3
  if opts.pos:find("vsp") then
    api.nvim_win_set_width(win, math.floor(vim.o.columns * size))
  else
    api.nvim_win_set_height(win, math.floor(vim.o.lines * size))
  end

  -- 绑定缓冲区（复用已有或新建）
  local buf = term and term.buf or api.nvim_create_buf(false, true)
  api.nvim_win_set_buf(win, buf)

  -- 如果是新缓冲区则启动终端
  if not term then
    vim.fn.termopen(vim.o.shell)
    vim.cmd("startinsert")
  end

  return win, buf
end

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
      local win, _ = create_window(opts, term)
      terminals[id].win = win
    end
  else
    -- 创建新终端
    local win, buf = create_window(opts)
    terminals[id] = {
      buf = buf,
      win = win,
      pos = opts.pos,
      size = opts.size or 0.3
    }
  end
end

return M