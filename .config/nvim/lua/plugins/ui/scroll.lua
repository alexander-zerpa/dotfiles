return {
	{
		"karb94/neoscroll.nvim",
		opts = {},
	},
	{
		"lewis6991/satellite.nvim",
		opts = {},
	},
	{
		"gorbit99/codewindow.nvim",
		keys = {
			{ "<leader>mo", function() require("codewindow").open_minimat() end, desc = "Open minimap" },
			{ "<leader>mc", function() require("codewindow").close_minimap() end, desc = "Close minimap" },
			{ "<leader>mf", function() require("codewindow").toggle_focus() end, desc = "Focus/unfocus minimap" },
			{ "<leader>mm", function() require("codewindow").toggle_minimap() end, desc = "Toggle minimap" },
		},
		opts = {
			z_index = 50,
		},
	},
}
