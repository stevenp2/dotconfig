local M = {}

function M.setup()
  local actions = require("telescope.actions")

  require("telescope").setup({
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "smart" },
      mappings = {
        n = {
          ["<Esc>"] = actions.close,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,
          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["gg"] = actions.move_to_top,
          ["G"] = actions.move_to_bottom,
          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,
          ["?"] = actions.which_key,
        },
      },
    },
    pickers = {
      buffers = {
        mappings = {
          n = { ["<C-x>"] = actions.delete_buffer + actions.move_to_top },
        },
      },
    },
  })
end

return M
