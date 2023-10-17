return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	main = "ibl",
	opts = {
		scope = {
			highlight = {
				"label",
			},
		},
		exclude = {
			filetypes = {
				"lspinfo",
				"checkhealth",
				"man",
				"gitcommit",
				"TelescopePrompt",
				"TelescopeResults",
				"help",
				"mason",
				"toggleterm",
				"lazyterm",
				"",
			},
		},
	},
}
