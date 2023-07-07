return {
	"klen/nvim-test",
	keys = {
		{ "<leader>ct", "<cmd>TestSuite<cr>", desc = "Run tests" },
	},
	-- TODO: make it so that pressing q after a test closes it immediately
	-- right now, you have to enter insert mode in order to do that
	opts = {
		termOpts = {
			direction = "float",
		},
	},
}
