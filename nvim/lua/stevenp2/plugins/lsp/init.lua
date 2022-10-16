local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("stevenp2.plugins.lsp.cmp")
require("stevenp2.plugins.lsp.lsp-installer")
require("stevenp2.plugins.lsp.trouble")
require("stevenp2.plugins.lsp.handlers").setup()
