return {
	"MeanderingProgrammer/render-markdown.nvim",
	opts = {
		heading = { position = "inline", width = "block" },
		checkbox = {
			checked = { icon = "✔ ", scope_highlight = "@markup.strikethrough" },
			unchecked = { icon = "✘ " },
			custom = {
				important = {
					raw = "[~]",
					rendered = "󰓎 ",
					highlight = "DiagnosticWarn",
				},
			},
		},
		code = { style = "language", width = "block" },
		pipe_table = { preset = "round" },
		link = {
			email = " ",
			custom = {
				python = {
					pattern = "%.py$",
					icon = "󰌠 ",
				},
			},
		},
	},
}
