return {
	"ja-ford/delaytrain.nvim",
	opts = {
		ignore_filetypes = {
			"minifiles",
			"mason",
			"lazy",
			"markdown", -- for hoverable things
		},
		keys = {
			["nv"] = { "h", "j", "k", "l", "w", "b" },
		},
		grace_period = 2,
		delay_ms = 500,
	},
}
