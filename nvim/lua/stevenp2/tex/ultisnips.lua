return function()
    -- Disable snipmate plugins to avoid duplicate snippets
    vim.g.UltiSnipsEnableSnipMate = 0
    vim.g.UltiSnipsRemoveSelectModeMappings = 0
    vim.g.UltiSnipsExpandTrigger = "<tab>"
    vim.g.UltiSnipsJumpForwardTrigger = "C-h"
    vim.g.UltiSnipsJumpBackwardTrigger = "C-l"
end
