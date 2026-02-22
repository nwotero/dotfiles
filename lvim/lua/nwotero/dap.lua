-- lvim.builtin.which_key.mappings["d"] = {
--   name = "Debug",
--   s = {
--     name = "Step",
--     c = { "<cmd>lua require('dap').continue()<CR>", "Continue" },
--     j = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
--     i = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
--     o = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
--   },
--   h = {
--     name = "Hover",
--     h = { "<cmd>lua require('dap.ui.variables').hover()<CR>", "Hover" },
--     v = { "<cmd>lua require('dap.ui.variables').visual_hover()<CR>", "Visual Hover" },
--   },
--   u = {
--     name = "UI",
--     h = { "<cmd>lua require('dap.ui.widgets').hover()<CR>", "Hover" },
--     f = { "<cmd>lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>", "Float" },
--   },
--   r = {
--     name = "Repl",
--     o = { "<cmd>lua require('dap').repl.open()<CR>", "Open" },
--     l = { "<cmd>lua require('dap').repl.run_last()<CR>", "Run Last" },
--   },
--   b = {
--     name = "Breakpoints",
--     c = {
--       "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
--       "Conditional Breakpoint",
--     },
--     m = {
--       "<cmd>lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>",
--       "Log Point Message",
--     },
--     t = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle" },
--   },
--   c = { "<cmd>lua require('dap').scopes()<CR>", "Scopes" },
--   i = { "<cmd>lua require('dap').toggle()<CR>", "Toggle" },
-- }

-- DAP config
local dap = require("dap")
dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "Neovim attach",
    host = function()
      local value = vim.fn.input "Host [127.0.0.1]: "
      if value ~= "" then
        return value
      end
      return "127.0.0.1"
    end,
    port = function()
      local val = tonumber(vim.fn.input "Port: ")
      assert(val, "Please provide a port number")
      return val
    end,
  },
}

dap.adapters.go = function(callback, _)
  local stdout = vim.loop.new_pipe(false)
  local handle
  local pid_or_err
  local port = 38697
  local opts = {
    stdio = { nil, stdout },
    args = { "dap", "-l", "127.0.0.1:" .. port },
    detached = true,
  }
  handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
    stdout:close()
    handle:close()
    if code ~= 0 then
      print("dlv exited with code", code)
    end
  end)
  assert(handle, "Error running dlv: " .. tostring(pid_or_err))
  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require("dap.repl").append(chunk)
      end)
    end
  end)
  -- Wait for delve to start
  vim.defer_fn(function()
    callback { type = "server", host = "127.0.0.1", port = port }
  end, 100)
end
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    program = "${file}",
  },
  {
    type = "go",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}",
  },
  -- works with go.mod packages and sub packages
  {
    type = "go",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}",
  },
}

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/nick/applications/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap.configurations.python = dap.configurations.python or {}
table.insert(dap.configurations.python, {
  type = "python",
  request = "launch",
  name = "launch with options",
  program = "${file}",
  python = function() end,
  pythonPath = function()
    local path
    for _, server in pairs(vim.lsp.buf_get_clients()) do
      if server.name == "pyright" or server.name == "pylance" then
        path = vim.tbl_get(server, "config", "settings", "python", "pythonPath")
        break
      end
    end
    path = vim.fn.input("Python path: ", path or "", "file")
    return path ~= "" and vim.fn.expand(path) or nil
  end,
  args = function()
    local args = {}
    local i = 1
    while true do
      local arg = vim.fn.input("Argument [" .. i .. "]: ")
      if arg == "" then
        break
      end
      args[i] = arg
      i = i + 1
    end
    return args
  end,
  justMyCode = function()
    local yn = vim.fn.input "justMyCode? [y/n]: "
    if yn == "y" then
      return true
    end
    return false
  end,
  stopOnEntry = function()
    local yn = vim.fn.input "stopOnEntry? [y/n]: "
    if yn == "y" then
      return true
    end
    return false
  end,
  console = "integratedTerminal",
})

-- DAP UI config
local dapui = require "dapui"
dapui.setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7"),
  layouts = {
    {
      elements = {
        'scopes',
        'breakpoints',
        'stacks',
        'watches',
      },
      size = 40,
      position = 'left',
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 10,
      position = 'bottom',
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  }
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
