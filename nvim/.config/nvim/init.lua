-- Autocmd Setup
require("tsupdate")

-- Plugins
vim.pack.add({
	-- Treesitter
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },

	-- Nvim LSPConfig
	{ src = 'https://github.com/neovim/nvim-lspconfig' },

	-- Render Markdown
	{ src = 'https://github.com/nvim-tree/nvim-web-devicons' },
	{ src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },

	-- Nvim Cmp
	{ src = 'https://github.com/hrsh7th/vim-vsnip' },
	{ src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
	{ src = 'https://github.com/hrsh7th/cmp-buffer' },
	{ src = 'https://github.com/hrsh7th/cmp-path' },
	{ src = 'https://github.com/hrsh7th/cmp-vsnip' },
	{ src = 'https://github.com/hrsh7th/nvim-cmp' },

	-- Onedark Theme
	{ src = 'https://github.com/navarasu/onedark.nvim'},
})

-- LSP Servers
vim.diagnostic.config({
	update_in_insert = true,
	virtual_text = true,
})

vim.lsp.config['lua_ls'] = {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.git' },
  settings = { Lua = { diagnostics = { globals = { "vim" } } } }
}

local caps = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('*', {
	capabilities = caps,
})

local servers = {
	'bashls',			--Bash
	'ccls',				--C/C++
	'rust_analyzer',	--Rust
	'pyright',			--Python
	'lua_ls',			--Lua
	'quick_lint_js',	--Javascript
	'html',				--html
	'cssls'				--css
}
vim.lsp.enable(servers)

-- Completion Config
local cmp = require('cmp')
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn['vsnip#anonymous'](args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<Tab>'] = cmp.mapping.confirm({select = true}),
	}),
	sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'vsnip' },
		},
		{
			{ name = 'buffer' },
		}
	),
})

-- Markdown Config
require('render-markdown').setup({
	code = { style = 'full' },
	latex = { enabled = false },
	win_options = { conceallevel = { rendered = 2 } },
})

require('onedark').setup({
	style = 'deep',
})
require('onedark').load()

-- Settings
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
