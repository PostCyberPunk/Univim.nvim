local M = {}
local chanID = 0
local socketPath = '/tmp/Univim'

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
  if M.checkConnection() then
    print(chanID)
    vim.fn.chansend(chanID, msg)
  else
    vim.notify("Univim:Can't connect to Unity.", vim.log.levels.WARN)
  end
end

function M.connectUnity()
  chanID = vim.fn.sockconnect('pipe', socketPath)
end
function M.checkConnection()
  if pcall(M.connectUnity) then
    if chanID ~= 0 then
      return true
    else
      return false
    end
  else
    return false
  end
end

return M
