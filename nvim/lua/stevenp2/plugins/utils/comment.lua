local M = {}

function M.setup()
  local status_ok, comment = pcall(require, "Comment")
  if not status_ok then
    return
  end

  comment.setup {
    mappinngs = {
      extra = true,
    },
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
  }
  end

return M
