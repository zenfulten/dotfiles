return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre", -- uncomment for format on save
		lazy = true,
		opts = {
			formatters_by_ft = {

				lua = { "stylua" },
				dart = { "dartls" },
				go = { "goimports", "gofumpt" },
				python = { "ruff" },
				cpp = { "clang_format" },
				c = { "clang_format" },
				-- css = { "prettier" },
				-- html = { "prettier" },
			},

			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},
}
