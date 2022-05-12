local dap = require('dap')

local get_pid_and_name = function(exec_name)
  local pattern = string.format("-ef | grep -v grep | grep %s", exec_name)
  local output = vim.fn.system({'ps', pattern})
  local lines = vim.split(output, '\n')
  local procs = {}
  for _, line in pairs(lines) do
    -- output format
    --    " 107021 pts/4    Ss     0:00 /bin/zsh <args>"
    local parts = vim.fn.split(vim.fn.trim(line), ' \\+')
    local pid = parts[1]
    local name = table.concat({unpack(parts, 5)}, ' ')
    if pid and pid ~= 'PID' then
      pid = tonumber(pid)
      if pid ~= vim.fn.getpid() then
        table.insert(procs, { pid = pid, name = name })
      end
    end
  end
  local label_fn = function(proc)
    return string.format("id=%d name=%s", proc.pid, proc.name)
  end
  local result = require('dap.ui').pick_one_sync(procs, "Select process", label_fn)
  return result.pid and result.name or nil

end

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = "executable",
  command = os.getenv('HOME') .. '/.config/nvim/lua/user/dap/debugger/ms-vscode.cpptools-1.7.1/debugAdapters/bin/OpenDebugAD7',
}
dap.configurations.cpp = {
-- launch exe
{
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
    setupCommands = {
    {
        description =  'enable pretty printing',
        text = '-enable-pretty-printing',
        ignoreFailures = false
      },
    },
},
-- attach process
{
    name = "Attach process",
    type = "cppdbg",
    request = "attach",
    -- processId = function()
    --   local pid = vim.fn.input('input attach pid: ')
    --   return tonumber(pid)
    -- end,
    -- program = function()
    --   return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    -- end,
    processId, program = function()
      local exec_name = vim.fn.input('exec name: ')
      return get_pid_and_name(exec_name)
    end,
    cwd = "${workspaceFolder}",
    setupCommands = {
    {
        description =  'enable pretty printing',
        text = '-enable-pretty-printing',
        ignoreFailures = false
      },
    },
},
-- attach server
{
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb', cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description =  'enable pretty printing',
        ignoreFailures = false
      },
    },
  },
}

-- setup other language
dap.configurations.c = dap.configurations.cpp



