local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("stevenp2.lsp.lsp-installer")
require("stevenp2.lsp.trouble")
require("stevenp2.lsp.handlers").setup()
