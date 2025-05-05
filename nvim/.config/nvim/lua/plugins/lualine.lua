return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local colors = {
			bg = "#161617",
			fg = "#c9c7cd",
			subtext1 = "#b4b1ba",
			subtext2 = "#9f9ca6",
			subtext3 = "#8b8693",
			subtext4 = "#6c6874",
			bg_dark = "#131314",
			black = "#27272a",
			red = "#ea83a5",
			green = "#90b99f",
			yellow = "#e6b99d",
			purple = "#aca1cf",
			magenta = "#e29eca",
			orange = "#f5a191",
			blue = "#92a2d5",
			cyan = "#85b5ba",
			bright_black = "#353539",
			bright_red = "#f591b2",
			bright_green = "#9dc6ac",
			bright_yellow = "#f0c5a9",
			bright_purple = "#b9aeda",
			bright_magenta = "#ecaad6",
			bright_orange = "#ffae9f",
			bright_blue = "#a6b6e9",
			bright_cyan = "#99c9ce",
			gray0 = "#18181a",
			gray1 = "#1b1b1c",
			gray2 = "#2a2a2c",
			gray3 = "#313134",
			gray4 = "#3b3b3e",
			-- Special
			none = "NONE",
		}

		local icons = {
			misc = {
				dots = "󰇘",
			},
			ft = {
				octo = "",
			},
			dap = {
				Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
				Breakpoint = " ",
				BreakpointCondition = " ",
				BreakpointRejected = { " ", "DiagnosticError" },
				LogPoint = ".>",
			},
			diagnostics = {
				Error = " ",
				Warn = " ",
				Hint = " ",
				Info = " ",
			},
			git = {
				added = " ",
				modified = " ",
				removed = " ",
			},
			kinds = {
				Array = " ",
				Boolean = "󰨙 ",
				Class = " ",
				Codeium = "󰘦 ",
				Color = " ",
				Control = " ",
				Collapsed = " ",
				Constant = "󰏿 ",
				Constructor = " ",
				Copilot = " ",
				Enum = " ",
				EnumMember = " ",
				Event = " ",
				Field = " ",
				File = " ",
				Folder = " ",
				Function = "󰊕 ",
				Interface = " ",
				Key = " ",
				Keyword = " ",
				Method = "󰊕 ",
				Module = " ",
				Namespace = "󰦮 ",
				Null = " ",
				Number = "󰎠 ",
				Object = " ",
				Operator = " ",
				Package = " ",
				Property = " ",
				Reference = " ",
				Snippet = "󱄽 ",
				String = " ",
				Struct = "󰆼 ",
				Supermaven = " ",
				TabNine = "󰏚 ",
				Text = " ",
				TypeParameter = " ",
				Unit = " ",
				Value = " ",
				Variable = "󰀫 ",
			},
		}
		local modecolor = {
			n = colors.red,
			i = colors.cyan,
			v = colors.purple,
			[""] = colors.purple,
			V = colors.red,
			c = colors.yellow,
			no = colors.red,
			s = colors.yellow,
			S = colors.yellow,
			[""] = colors.yellow,
			ic = colors.yellow,
			R = colors.green,
			Rv = colors.purple,
			cv = colors.red,
			ce = colors.red,
			r = colors.cyan,
			rm = colors.cyan,
			["r?"] = colors.cyan,
			["!"] = colors.red,
			t = colors.bright_red,
		}
		local modes = {
			"mode",
			color = function()
				local mode_color = modecolor
				return { bg = mode_color[vim.fn.mode()], fg = colors.bg_dark, gui = "bold" }
			end,
			separator = { left = "", right = "" },
			icon = "",
		}
		local branch = {
			"branch",
			icon = "",
			color = { bg = colors.green, fg = colors.bg, gui = "bold" },
			separator = { left = "", right = "" },
		}

		local space = {
			function()
				return " "
			end,
			color = { bg = colors.bg_dark, fg = colors.blue },
		}
		-- configure lualine with modified theme
		lualine.setup({
			options = {
				theme = require("themes/lualine_theme").theme(),
				icons_enabled = true,
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = true,
			},
			sections = {
				lualine_a = { modes },
				lualine_b = { space, branch },
				lualine_c = {
					{
						"diagnostics",
						symbols = {
							error = icons.diagnostics.Error,
							warn = icons.diagnostics.Warn,
							info = icons.diagnostics.Info,
							hint = icons.diagnostics.Hint,
						},
					},
					{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
						"diff",
						symbols = {
							added = icons.git.added,
							modified = icons.git.modified,
							removed = icons.git.removed,
						},
					},
					-- { "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
				lualine_y = {
					{ "progress", separator = " ", padding = { left = 1, right = 0 } },
					{ "location", separator = { left = "", right = "" }, icon = "" },
				},
				lualine_z = {
					function()
						return " " .. os.date("%R")
					end,
				},
			},
		})
	end,
}
