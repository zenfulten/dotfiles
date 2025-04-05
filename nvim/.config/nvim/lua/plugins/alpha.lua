return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set header
		dashboard.section.header.val = {

			"                                                           ",
			"   ██████╗ ██╗███╗   ██╗██████╗ ███████╗███████╗██╗  ██╗   ",
			"   ██╔══██╗██║████╗  ██║██╔══██╗██╔════╝██╔════╝██║  ██║   ",
			"   ██████╔╝██║██╔██╗ ██║██║  ██║█████╗  ███████╗███████║   ",
			"   ██╔══██╗██║██║╚██╗██║██║  ██║██╔══╝  ╚════██║██╔══██║   ",
			"   ██████╔╝██║██║ ╚████║██████╔╝███████╗███████║██║  ██║   ",
			"   ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝   ",
			"                                                           ",
		}

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("n", "  > New File", "<cmd>ene<CR>"),
			dashboard.button("SPC e", "  > Toggle file explorer", "<cmd>Neotree filesystem reveal left<CR>"),
			dashboard.button("SPC fp", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("SPC fg", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
			dashboard.button("l", "󰒲  >" .. " Lazy", "<cmd> Lazy <cr>"),
			dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
		}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		vim.api.nvim_create_autocmd("User", {
			once = true,
			pattern = "LazyVimStarted",
			callback = function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				dashboard.section.footer.val = "⚡ Neovim loaded "
					.. stats.loaded
					.. "/"
					.. stats.count
					.. " plugins in "
					.. ms
					.. "ms"
				pcall(vim.cmd.AlphaRedraw)
			end,
		})

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
