return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		plugins = { spelling = true },
		defaults = {
			mode = { "n", "v" },
			["g"] = { name = "+goto" },
			["gz"] = { name = "+surround" },
			["<leader>c"] = { name = "+code" },
			["<leader>g"] = { name = "+git" },
			["<leader>s"] = { name = "+search" },
			["<leader>f"] = { name = "+files" },
			["<leader>q"] = { name = "+quit" },
			["<leader>r"] = { name = "+run" },
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.register(opts.defaults)
	end,
}
