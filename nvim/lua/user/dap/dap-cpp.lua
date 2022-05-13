local dap = require('dap')

local get_pid = function(exec_name)
  local output = vim.fn.system({'ps', 'aux'})
  local lines = vim.split(output, '\n')
  local procs = {}
  for _, line in pairs(lines) do
    if string.match(line, exec_name) ~= nil then 
      local parts = vim.fn.split(vim.fn.trim(line), ' \\+')
      local pid = parts[2]
      local name = table.concat({unpack(parts, 11)}, ' ')
      if pid and pid ~= 'PID' then
        pid = tonumber(pid)
        if pid ~= vim.fn.getpid() then
          table.insert(procs, { pid = pid, name = name })
        end
      end
    end
  end
  local label_fn = function(proc)
    return string.format("id=%d name=%s", proc.pid, proc.name)
  end
  local result = require('dap.ui').pick_one_sync(procs, "Select process", label_fn)
  return result.pid
end

local get_exec_name = function()
  local name = vn.fn.getenv('DEBUG_PATH')
  if string.len(name) == '' then
    name = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
  end
  return name
end

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = "executable",
  command = os.getenv('HOME') .. '/.config/nvim/lua/user/dap/debugger/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7',
}
dap.configurations.cpp = {
-- launch exe
{
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = get_exec_name(),
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
    processId = function()
      local exec_name = vim.fn.input('exec name: ')
      return get_pid(exec_name)
    end,
    program = get_exec_name(),
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
    program = get_exec_name(),
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



