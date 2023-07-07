return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "▌" },
			change = { text = "▌" },
			topdelete = { text = "▔" },
			delete = { text = "▁" },
			changedelete = { text = "▁" },
			untracked = { text = "▌" },
		},
	},
}
