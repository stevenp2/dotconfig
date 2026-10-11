local M = {}

local config = require("stevenp2.config").treesitter

local filetype_to_parser = {
  javascriptreact = "tsx",
  typescriptreact = "tsx",
}

local foldexpr = "v:lua.vim.treesitter.foldexpr()"
local function set_folds()
  if vim.b.stevenp2_ts_folds then
    vim.wo.foldexpr = foldexpr
    vim.wo.foldmethod = "expr"
  elseif vim.wo.foldexpr == foldexpr then
    vim.wo.foldexpr = vim.go.foldexpr
    vim.wo.foldmethod = vim.go.foldmethod
  end
end

local function has_query(language, name)
  local ok, query = pcall(vim.treesitter.query.get, language, name)
  return ok and query ~= nil
end

local function start(event)
  vim.b[event.buf].stevenp2_ts_folds = false
  if vim.bo[event.buf].indentexpr == "v:lua.require'nvim-treesitter'.indentexpr()" then
    vim.bo[event.buf].indentexpr = ""
  end
  local filetype = vim.bo[event.buf].filetype
  if vim.bo[event.buf].buftype ~= "" or filetype == "" or filetype == "oil" then
    set_folds()
    return
  end
  local lines = vim.api.nvim_buf_line_count(event.buf)
  if lines > config.max_lines or vim.api.nvim_buf_get_offset(event.buf, lines) > config.max_file_size then
    vim.treesitter.stop(event.buf)
    set_folds()
    return
  end
  local language = filetype_to_parser[filetype] or vim.treesitter.language.get_lang(filetype) or filetype
  local ok, available = pcall(vim.treesitter.language.add, language)

  if not ok or not available then
    vim.treesitter.stop(event.buf)
    vim.bo[event.buf].syntax = filetype
    set_folds()
    return
  end

  local started, err = pcall(vim.treesitter.start, event.buf, language)
  if not started then
    vim.treesitter.stop(event.buf)
    vim.bo[event.buf].syntax = filetype
    vim.notify_once("Tree-sitter unavailable for " .. filetype .. ": " .. tostring(err), vim.log.levels.WARN)
    set_folds()
    return
  end
  -- vimtex handles tex indentation and folding
  local vimtex = vim.list_contains({ "tex", "plaintex", "bib" }, filetype)
  if not vimtex and has_query(language, "indents") and pcall(require, "nvim-treesitter") then
    vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
  vim.b[event.buf].stevenp2_ts_folds = not vimtex and has_query(language, "folds")
  set_folds()
end

function M.setup()
  local group = vim.api.nvim_create_augroup("stevenp2-treesitter", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function(event)
      -- run after ftplugins, which may start treesitter themselves
      vim.schedule(function()
        if vim.api.nvim_buf_is_loaded(event.buf) then
          vim.api.nvim_buf_call(event.buf, function() start(event) end)
        end
      end)
    end,
  })
  vim.api.nvim_create_autocmd("BufWinEnter", { group = group, callback = set_folds })
end

function M.setup_installer()
  local treesitter = require("nvim-treesitter")
  treesitter.setup()

  vim.schedule(function()
    if not config.auto_install or vim.fn.executable("tree-sitter") == 0 then
      return
    end

    local installed = treesitter.get_installed()
    local missing = vim.tbl_filter(function(parser)
      return not vim.list_contains(installed, parser)
    end, config.parsers)

    if #missing > 0 then
      treesitter.install(missing):await(vim.schedule_wrap(function(err)
        if err then
          vim.notify("Tree-sitter installation failed: " .. tostring(err), vim.log.levels.ERROR)
          return
        end
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(bufnr) then
            vim.api.nvim_buf_call(bufnr, function() start({ buf = bufnr }) end)
          end
        end
      end))
    end
  end)
end

return M
