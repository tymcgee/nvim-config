return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				indent = {
					enable = true,
					disable = { "python" },
				},
				ensure_installed = {
					"json",
					"yaml",
					"python",
					"lua",
					"rust",
					"bash",
					"javascript",
					"markdown",
					"markdown_inline",
					"regex",
					"typescript",
					"tsx",
					"gitcommit",
					"toml",
				},
			})
		end,
	},

	{ "nvim-treesitter/nvim-treesitter-context", config = true },
}
