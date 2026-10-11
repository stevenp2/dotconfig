return {
  ui = {
    dashboard = true,
    statusline = true,
    window_titles = true,
    indent_guides = true,
    scrollbar = true,
    smooth_scroll = true,
  },

  lsp = {
    format_on_save = {
      go = "gopls",
    },
  },

  completion = {
    min_chars = 2,
    delay = 150,
  },

  snippets = {
    enabled = true,
  },

  treesitter = {
    auto_install = true,
    max_file_size = 1024 * 1024,
    max_lines = 20000,
    parsers = {
      "bash",
      "c",
      "cpp",
      "go",
      "gomod",
      "gosum",
      "gowork",
      "javascript",
      "json",
      "latex",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "rust",
      "terraform",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    },
  },
}
