local opt = vim.opt
local o = vim.o
local g = vim.g

---------------------------------neovide-------------------------------------------------
if g.neovide then
	g.neovide_refresh_rate = 65
	g.neovide_transparency = 0.8
	g.neovide_cursor_animation_length = 0.13
	g.neovide_cursor_trail_length = 0.00
	g.neovide_cursor_trail_size = 0.3
	g.neovide_cursor_vfx_mode = "railgun"
	g.neovide_remember_dimensions = true
	g.neovide_remember_window_size = true

	-- neovide boarders
	g.neovide_padding_top = 0
	g.neovide_padding_bottom = 0
	g.neovide_padding_right = 0
	g.neovide_padding_left = 0

	--scroll animation length
	g.neovide_scroll_animation_length = 0.3

	--refresh rate
	g.neovide_refresh_rate = 60

	--border-radius
	g.neovide_floating_corner_radius = 0.8

	--curently mac only
	g.neovide_show_border = false

	---hide mouse when typing
	g.neovide_hide_mouse_when_typing = true
	---theme
	g.neovide_theme = "auto"
end
-------------------------------------- options ------------------------------------------

opt.swapfile = false

o.laststatus = 3
o.showmode = false

o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "number"

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.number = true
o.numberwidth = 2
o.ruler = false

-- disable nvim intro
opt.shortmess:append("sI")

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

g.mapleader = " "
g.background = "light"

vim.wo.number = true
