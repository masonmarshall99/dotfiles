local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

--Lazy Plugin Manager Bootstrap
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

--Plugin List
require("lazy").setup({
	{"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate"
	},
	{"neovim/nvim-lspconfig"},
	{"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {"nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons"},
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
	{"ryleelyman/latex.nvim"},
	{"EdenEast/nightfox.nvim"},
	{"navarasu/onedark.nvim"},
})

--Treesitter Config
require('nvim-treesitter.configs').setup({
	auto_install = true,
	highlight = { enable = true },
})

--LSP Config
local lspconfig = require('lspconfig')
lspconfig.bashls.setup{}		--Bash
lspconfig.ccls.setup{} 			--C/C++
lspconfig.rust_analyzer.setup{}	--Rust
lspconfig.pyright.setup{}		--Python
lspconfig.lua_ls.setup{}		--Lua
lspconfig.quick_lint_js.setup{}	--JavaScript
lspconfig.html.setup{}			--HTML
lspconfig.cssls.setup{}			--CSS

--Markdown Renderer Config
require('render-markdown').setup({
	code = {style = 'full'},
	latex = {enabled = false},
	win_options = {conceallevel = {rendered = 2}},
})

--Latex Config
require('latex').setup()

--Colorscheme
--require('nightfox').load()
require('onedark').setup({
	style = 'deep',
})
require('onedark').load()

--Settings
vim.opt.guicursor = "n-v-i-c:block-Cursor"
vim.opt.tabstop = 4
vim.opt.expandtab = false
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.cmd("highlight Normal guibg=none")
vim.cmd("highlight NonText guibg=none")
vim.cmd("highlight Normal ctermbg=none")
vim.cmd("highlight NonText ctermbg=none")
vim.cmd("highlight EndOfBuffer guibg=none")
vim.cmd("highlight EndOfBuffer ctermbg=none")
vim.api.nvim_set_hl(0, "Conceal", {link = "Normal"})
