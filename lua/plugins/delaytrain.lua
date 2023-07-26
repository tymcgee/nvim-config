return {
	"ja-ford/delaytrain.nvim",
    enabled = false,
	opts = {
		ignore_filetypes = {
			"minifiles",
			"mason",
			"lazy",
			"markdown", -- for hoverable things
			"sagacodeaction",
		},
		keys = {
			["nv"] = { "h", "j", "k", "l", "w", "b" },
		},
		grace_period = 2,
		delay_ms = 1000,
	},
}
