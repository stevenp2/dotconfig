return {
  settings = {
    pyright = {
      -- use ruff's import organiser
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- use ruff for linting
        ignore = { "*" }
      }
    }
  }
}
