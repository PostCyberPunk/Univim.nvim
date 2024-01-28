local M = {}
local socketPath = '/tmp/Univim'
local uv = require('luv')

M.setup = function()
  vim.api.nvim_create_user_command('UnivimQutiPlayMode', function()
    M.sendMsg('stop')
  end, {})
  vim.api.nvim_create_user_command('UnivimEnterPlayMode', function()
    M.sendMsg('play')
  end, {})
  vim.api.nvim_create_user_command('UnivimPausePlayMode', function()
    M.sendMsg('pause')
  end, {})
  vim.api.nvim_create_user_command('UnivimCompile', function()
    M.sendMsg('comp')
  end, {})
end

function M.sendMsg(msg)
  local pipe = uv.new_pipe()
	-- TODO: still cannot get disconnected status
  pipe:connect(socketPath, function(err)
    if not err then
      pipe:write(msg)
      pipe:close()
    else
      vim.notify("Univim:Can't connect to Unity.", vim.log.levels.WARN)
    end
  end)
end

return M
