return {
	{
		"echasnovski/mini.ai",
		config = function()
			require("mini.ai").setup()
		end,
	},
	{
		"echasnovski/mini.comment",
		config = function()
			require("mini.comment").setup()
		end,
	},
	{
		"echasnovski/mini.cursorword",
		config = function()
			require("mini.cursorword").setup()
		end,
	},
	{
		"echasnovski/mini.move",
		config = function()
			require("mini.move").setup()
		end,
	},
	{
		"echasnovski/mini.bufremove",
		keys = {
			{
				"<s-q>",
				function()
					require("mini.bufremove").delete()
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>bD",
				function()
					require("mini.bufremove").delete(0, true)
				end,
				desc = "Force Delete Buffer",
			},
		},
		config = function()
			require("mini.bufremove").setup()
		end,
	},
	{
		"echasnovski/mini.surround",
		opts = {
			mappings = {
				add = "gza", -- Add surrounding in Normal and Visual modes
				delete = "gzd", -- Delete surrounding
				find = "gzf", -- Find surrounding (to the right)
				find_left = "gzF", -- Find surrounding (to the left)
				highlight = "gzh", -- Highlight surrounding
				replace = "gzr", -- Replace surrounding
				update_n_lines = "gzn", -- Update `n_lines`
			},
			n_lines = 300,
		},
		config = function(_, opts)
			require("mini.surround").setup(opts)
		end,
	},
	{
		"echasnovski/mini.pairs",
		opts = {
			mappings = {
				-- This works as a two-character pattern.
				-- Only match if the character to the left isn't \
				-- and the character to the right isn't alphanumeric (%w means alphanumeric, %W is the complement).
				["("] = { neigh_pattern = "[^\\]%W" },
				["["] = { neigh_pattern = "[^\\]%W" },
				["{"] = { neigh_pattern = "[^\\]%W" },
				["<"] = { action = "open", pair = "<>", neigh_pattern = "[^\\]%W" },
				[">"] = { action = "close", pair = "<>", neigh_pattern = "[^\\]%W" },
				['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\]%W" },
				["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\]%W" },
				["`"] = { action = "openclose", pair = "``", neigh_pattern = "[^\\]%W" },
			},
		},
		config = function(_, opts)
			require("mini.pairs").setup(opts)
		end,
	},
	{
		"echasnovski/mini.files",
		lazy = false,
		keys = {
			{
				"<leader>e",
				function()
					require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
				end,
				desc = "Open mini.files (directory of current file)",
			},
			{
				"<leader>E",
				function()
					require("mini.files").open(vim.loop.cwd(), true)
				end,
				desc = "Open mini.files (cwd)",
			},
		},
		opts = {
			options = {
				use_as_default_explorer = true,
			},
		},
	},
}
