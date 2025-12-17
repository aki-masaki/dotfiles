vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.clipboard = "unnamedplus"

vim.g.mapleader = " "
vim.cmd.set("timeout timeoutlen=3000 ttimeoutlen=100")

vim.cmd.set("scl=no")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local keyset = vim.keymap.set

local Plug = vim.fn["plug#"]

vim.call("plug#begin")

Plug("windwp/nvim-autopairs")
Plug("nvim-treesitter/nvim-treesitter")
Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim")
Plug("stevearc/conform.nvim")
Plug("rebelot/kanagawa.nvim")
Plug("smoka7/hop.nvim")

vim.call("plug#end")

vim.cmd.colorscheme("kanagawa-dragon")

require("nvim-autopairs").setup({})

vim.lsp.enable("html")
vim.lsp.enable("cssls")
vim.lsp.enable("clangd")

keyset("n", "<leader>ve", "* <Lua 27: ~/.config/nvim/init.lua:29")

local builtin = require("telescope.builtin")
keyset("n", "<leader>f", builtin.find_files, {})
keyset("n", "<leader>fb", builtin.buffers, {})

local hop = require("hop")
local directions = require("hop.hint").HintDirection

keyset("n", "f", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true })

keyset("n", "F", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true })

keyset("n", "l", function()
	hop.hint_lines_skip_whitespace({ direction = directions.AFTER_CURSOR })
end, { remap = true })

keyset("n", "L", function()
	hop.hint_lines_skip_whitespace({ direction = directions.BEFORE_CURSOR })
end, { remap = true })

hop.setup()

require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		c = { "clang-format" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
