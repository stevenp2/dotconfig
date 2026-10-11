local M = {}

local function delve_available()
  if vim.fn.executable("dlv") == 1 then
    return true
  end
  vim.notify("Delve is required for Go debugging. Run: go install github.com/go-delve/delve/cmd/dlv@latest", vim.log.levels.ERROR)
  return false
end

function M.setup()
  local dap = require("dap")
  local dapui = require("dapui")

  vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", numhl = "DiagnosticError" })
  vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn", numhl = "DiagnosticWarn" })
  vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DiagnosticError" })
  vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DiagnosticInfo" })
  vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "Visual", numhl = "DiagnosticOk" })

  dapui.setup({
    controls = { enabled = true },
    layouts = {
      {
        elements = {
          { id = "scopes", size = 0.35 },
          { id = "stacks", size = 0.25 },
          { id = "breakpoints", size = 0.20 },
          { id = "watches", size = 0.20 },
        },
        position = "right",
        size = 48,
      },
      {
        elements = {
          { id = "repl", size = 0.55 },
          { id = "console", size = 0.45 },
        },
        position = "bottom",
        size = 12,
      },
    },
  })

  require("nvim-dap-virtual-text").setup({
    commented = true,
    highlight_changed_variables = true,
    only_first_definition = true,
    virt_text_pos = "inline",
  })

  require("dap-go").setup({
    delve = {
      path = "dlv",
      detached = vim.fn.has("win32") == 0,
    },
    tests = { verbose = true },
  })

  dap.listeners.before.attach.stevenp2_dapui = function()
    dapui.open()
  end
  dap.listeners.before.launch.stevenp2_dapui = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.stevenp2_dapui = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.stevenp2_dapui = function()
    dapui.close()
  end
end

function M.go_file()
  if not delve_available() then
    return
  end
  require("dap").run({
    type = "go",
    name = "Debug current Go file",
    request = "launch",
    program = "${file}",
  })
end

function M.go_test()
  if delve_available() then
    require("dap-go").debug_test()
  end
end

function M.go_last_test()
  if delve_available() then
    require("dap-go").debug_last_test()
  end
end

return M
