return {
	"saghen/blink.cmp",
	lazy = false, -- lazy loading handled internally
	version = "v0.*",
	---@module 'blink.cmp'
	opts = {
		keymap = { preset = "default" },
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		completion = {
			menu = {
				border = "single",
				draw = {
					components = {
						kind_icon = {
							text = function(ctx)
								local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
								return kind_icon
							end,
							highlight = function(ctx)
								local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
								return hl
							end,
						},
						kind = {
							highlight = function(ctx)
								local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
								return hl
							end,
						},
					},
				},
			},
			documentation = { window = { border = "single" } },
		},
		signature = { enabled = true, window = { border = "single" } },
	},
	opts_extend = { "sources.default" },
}
