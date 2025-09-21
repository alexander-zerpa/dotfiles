return {
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			{
				"tiagovla/scope.nvim",
				optional = true,
				opts = {
					hooks = {
						pre_tab_leave = function()
							vim.api.nvim_exec_autocmds("User", { pattern = "ScopeTabLeavePre" })
						end,
						post_tab_enter = function()
							vim.api.nvim_exec_autocmds("User", { pattern = "ScopeTabEnterPost" })
						end,
					},
				},
			},
		},
        lazy = false,
		keys = {
			{ "<Tab>", "<cmd>BufferNext<CR>", desc = "Next buffer" },
			{ "<S-Tab>", "<cmd>BufferPrevious<CR>", desc = "Previus buffer" },

			{ "<C-.>", "<cmd>BufferMoveNext<CR>", desc = "Move buffer next" },
			{ "<C-,>", "<cmd>BufferMovePrevious<CR>", desc = "Move buffer prev" },
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			sidebar_filetypes = {
				NvimTree = {
					event = "BufWinLeave",
					text = "NvimTree",
					align = "center",
				},
			},
		},
		opts_extends = { "icons" },
	},
	{
		"tiagovla/scope.nvim",
		config = true,
		opts_extends = { "hooks" },
	},
}
