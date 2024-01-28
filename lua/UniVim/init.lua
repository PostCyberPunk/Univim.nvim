local M = {}
local chanID = 0
local socketPath = '/tmp/Univim'

M.setup = function()
  vim.api.nvim_create_user_command('UnityQutiPlayMode', function()
    M.sendMsg('stop')
  end, {})
  vim.api.nvim_create_user_command('UnityEnterPlayMode', function()
    M.sendMsg('play')
  end, {})
  vim.api.nvim_create_user_command('UnityPausePlayMode', function()
    M.sendMsg('pause')
  end, {})
  vim.api.nvim_create_user_command('UnityHello', function()
    M.sendMsg('hello')
  end, {})
  vim.api.nvim_create_user_command('UnivimReconnect', function()
		chanID = 0;
  end, {})
end

function M.sendMsg(msg)
  if M.checkID() then
    vim.fn.chansend(chanID, msg)
  else
    vim.notify(
      "Univim:Can't connect to Unity. Please check if univim.unity is running.",
      vim.log.levels.WARN
    )
  end
end

function M.connectUnity()
  chanID = vim.fn.sockconnect('pipe', socketPath)
	print(chanID)
end
function M.checkID()
  if chanID ~= 0 then
    return true
  end
  if pcall(M.connectUnity) then
    return true
  else
    return false
  end
end

return M
