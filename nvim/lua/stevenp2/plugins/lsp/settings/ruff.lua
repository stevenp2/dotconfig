return {
  --  https://docs.astral.sh/ruff/editors/settings/
  init_options = {
    settings = {
      lint = {
        select = {
          "D",   -- pydoc
          "ANN", -- type annocations
          "SIM", -- simplify
          "B",   -- bugs
          "F",   -- pyflakes
          "PL",  -- pylint
          "TC"   -- typecheck
        },
        ignore = {
          "D104", -- docstring in import
        }
      },
      format = {
        ["quote-style"] = "double"
      },
      configurationPerference = "editorFirst"
    }
  }
}
