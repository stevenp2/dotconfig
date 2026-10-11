local function dap(method)
  return function()
    require("dap")[method]()
  end
end

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
      "leoluz/nvim-dap-go",
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      { "<leader>dc", dap("continue"), desc = "Debug: start or continue" },
      { "<leader>db", dap("toggle_breakpoint"), desc = "Debug: toggle breakpoint" },
      {
        "<leader>dB",
        function()
          vim.ui.input({ prompt = "Breakpoint condition: " }, function(condition)
            if condition and condition ~= "" then
              require("dap").set_breakpoint(condition)
            end
          end)
        end,
        desc = "Debug: conditional breakpoint",
      },
      { "<leader>dC", dap("run_to_cursor"), desc = "Debug: run to cursor" },
      { "<leader>di", dap("step_into"), desc = "Debug: step into" },
      { "<leader>do", dap("step_out"), desc = "Debug: step out" },
      { "<leader>dO", dap("step_over"), desc = "Debug: step over" },
      { "<leader>dP", dap("pause"), desc = "Debug: pause" },
      { "<leader>dl", dap("run_last"), desc = "Debug: run last configuration" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Debug: toggle REPL" },
      { "<leader>dR", dap("restart"), desc = "Debug: restart" },
      { "<leader>dt", dap("terminate"), desc = "Debug: terminate" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Debug: toggle UI" },
      { "<leader>de", function() require("dapui").eval() end, mode = { "n", "v" }, desc = "Debug: evaluate" },
      { "<leader>dG", function() require("stevenp2.plugins.debug").go_file() end, desc = "Debug: current Go file" },
      { "<leader>dT", function() require("stevenp2.plugins.debug").go_test() end, desc = "Debug: nearest Go test" },
      { "<leader>dL", function() require("stevenp2.plugins.debug").go_last_test() end, desc = "Debug: last Go test" },
    },
    config = function()
      require("stevenp2.plugins.debug").setup()
    end,
  },
}
