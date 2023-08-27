return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
					-- custom_captures = {
					-- Highlight the @foo.bar capture group with the "Identifier" highlight group.
					-- ["foo.bar"] = "Identifier",
					-- },
				},
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
					"sql",
				},
			})
		end,
	},

	{ "nvim-treesitter/nvim-treesitter-context", config = true },
}
