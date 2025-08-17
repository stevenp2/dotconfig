local M = {}

function M.setup()
  local actions_status_ok, actions = pcall(require, "telescope.actions")
  if not actions_status_ok then
    return
  end

  local status_ok, telescope = pcall(require, "telescope")
  if not status_ok then
    return
  end

  telescope.load_extension('media_files')
  telescope.load_extension('lazygit')

  telescope.setup({
    pickers = {
      buffers = {
        mappings = {
          n = {
            ["<C-x>"] = actions.delete_buffer + actions.move_to_top,
          }
        }
      },

      planets = {
        show_moon = true,
        show_pluto = true,
      },
    },

    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "smart" },

      mappings = {
        n = {
          ["<esc>"] = actions.close,
          ["<CR>"] = actions.select_default,
          ["<C-x>"] = false, -- actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["H"] = actions.move_to_top,
          ["M"] = actions.move_to_middle,
          ["L"] = actions.move_to_bottom,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["gg"] = actions.move_to_top,
          ["G"] = actions.move_to_bottom,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["?"] = actions.which_key,
        },
      },
    },

    extensions = {
      media_files = {
          -- filetypes whitelist
          -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
          filetypes = {"png", "webp", "jpg", "jpeg"},
          find_cmd = "rg" -- find command (defaults to `fd`)
        }
    },
  })

end

return M
