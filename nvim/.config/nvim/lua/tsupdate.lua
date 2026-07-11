-- AutoCmd TSUpdate
-- calls TSUpdate whenever treesitter is installed/updated

vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("treesitter_update", { clear = true }),
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind

		if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
		vim.cmd("TSUpdate")
		end
	end,
})
