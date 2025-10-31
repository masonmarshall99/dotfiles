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
	{"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {"nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons"},
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
	{"neovim/nvim-lspconfig"},
	{"ryleelyman/latex.nvim"},
	{"EdenEast/nightfox.nvim"},
	{"navarasu/onedark.nvim"},
	{"hrsh7th/nvim-cmp", 
		dependencies = {"hrsh7th/cmp-nvim-lsp",
						"hrsh7th/cmp-buffer",
						"hrsh7th/cmp-path",
						"hrsh7th/cmp-vsnip",
						"hrsh7th/vim-vsnip",
			},
		---@module 'nvim-cmp'
	},
	{"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end
	}
})

--Treesitter Config
require('nvim-treesitter.configs').setup({
	auto_install = true,
	highlight = { enable = true },
})

--Completion Config
local cmp = require('cmp')
cmp.setup({
	
	snippet = {
		expand =  function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({select = true}),
	}),
	
	sources = cmp.config.sources({
		{ name = "copilot_cmp" },
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
	}, {
		{ name = 'buffer' },
	}),

})

--LSP Config
local servers = {
	'bashls',		--Bash
	'ccls',			--C/C++
	'rust_analyzer',	--Rust
	'pyright',		--Python
	'lua_ls',		--Lua
	'quick_lint_js',	--Javascript
	'html',			--html
	'cssls'			--css
}

vim.lsp.enable(servers)

local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('*', {
	capabilities = capabilities,
})

vim.diagnostic.config({ virtual_text = true })

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
