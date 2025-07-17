-- Taken from:
-- https://github.com/Neelfrost/nvim-config/blob/main/lua/user/plugins/config/vimtex.lua

-- Disable imaps (using Ultisnips)
vim.g.vimtex_imaps_enabled = 0
-- Do not open pdfviwer on compile
vim.g.vimtex_view_automatic = 0
-- Disable conceal
vim.g.vimtex_syntax_conceal_disable = 1

-- Disable quickfix auto open
-- vim.g.vimtex_quickfix_ignore_mode = 0

-- get os
function os.capture(cmd, raw)
  local handle = assert(io.popen(cmd, 'r'))
  local output = assert(handle:read('*a'))

  handle:close()

  if raw then
      return output
  end

  output = string.gsub(
      string.gsub(
          string.gsub(output, '^%s+', ''),
          '%s+$',
          ''
      ),
      '[\n\r]+',
      ' '
  )

 return output
end

local os = os.capture("echo $(uname)", false)


-- PDF viewer settings
if os == "Linux" then
  vim.g.vimtex_view_general_viewer = "zathura"
else
  vim.g.vimtex_view_general_viewer = "/Applications/Skim.app/Contents/SharedSupport/displayline"
  vim.g.vimtex_view_general_options = "-r @line @pdf @tex"
end


-- Do not auto open quickfix on compile erros
-- vim.g.vimtex_quickfix_mode = 0
-- Latex warnings to ignore
-- vim.g.vimtex_quickfix_ignore_filters = {
--     "Command terminated with space",
--     "LaTeX Font Warning: Font shape",
--     "Package caption Warning: The option",
--     [[Underfull \\hbox (badness [0-9]*) in]],
--     "Package enumitem Warning: Negative labelwidth",
--     [[Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in]],
--     [[Package caption Warning: Unused \\captionsetup]],
--     "Package typearea Warning: Bad type area settings!",
--     [[Package fancyhdr Warning: \\headheight is too small]],
--     [[Underfull \\hbox (badness [0-9]*) in paragraph at lines]],
--     "Package hyperref Warning: Token not allowed in a PDF string",
--     [[Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in paragraph at lines]],
-- }
