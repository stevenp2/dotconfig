local M = {}

function M.setup()
  local status_ok, aerial = pcall(require, "aerial")
  if not status_ok then
    return
  end

  aerial.setup {
    autojump = true,
    layout = {
      default_direction = "float"
    },
    manage_folds = true,
  }

end

return M
