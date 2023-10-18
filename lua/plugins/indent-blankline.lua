return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	main = "ibl",
	opts = {
		scope = {
			highlight = {
				-- i suppose these are not all necessarily different colors depending on the theme
				"label",
				"function",
				"string",
				"identifier",
			},
			show_start = false,
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
