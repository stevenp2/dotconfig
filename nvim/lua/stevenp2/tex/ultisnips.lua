return function()
    -- Disable snipmate plugins to avoid duplicate snippets
    vim.g.UltiSnipsEnableSnipMate = 0
    vim.g.UltiSnipsRemoveSelectModeMappings = 0
    vim.g.UltiSnipsExpandTrigger = "<tab>"
    vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
    vim.g.UltiSnipsJumpBackwardTrigger = "<S-tab>"
end
