local M = {}

function M.setup()
  require("gitsigns").setup({
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "▎" },
    },
    attach_to_untracked = true,
    current_line_blame = false,
    max_file_length = 40000,
    preview_config = {
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "Git: " .. desc })
      end

      map("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, "next hunk")
      map("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, "previous hunk")

      map("n", "<leader>hs", gitsigns.stage_hunk, "stage hunk")
      map("v", "<leader>hs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "stage selected hunk")
      map("n", "<leader>hr", gitsigns.reset_hunk, "reset hunk")
      map("v", "<leader>hr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "reset selected hunk")
      map("n", "<leader>hS", gitsigns.stage_buffer, "stage buffer")
      map("n", "<leader>hu", gitsigns.undo_stage_hunk, "undo staged hunk")
      map("n", "<leader>hR", gitsigns.reset_buffer, "reset buffer")
      map("n", "<leader>hp", gitsigns.preview_hunk, "preview hunk")
      map("n", "<leader>hb", gitsigns.blame_line, "blame line")
      map("n", "<leader>hB", gitsigns.toggle_current_line_blame, "toggle line blame")
      map("n", "<leader>hd", gitsigns.diffthis, "diff against index")
      map("n", "<leader>hD", function()
        gitsigns.diffthis("~")
      end, "diff against previous commit")
      map({ "o", "x" }, "ih", gitsigns.select_hunk, "select hunk")
    end,
  })
end

return M
