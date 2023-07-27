-- Set up lspconfig, mason, CMP, and null-ls
return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v2.x",
	dependencies = {
		-- LSP Support
		{ "neovim/nvim-lspconfig" },
		{
			"williamboman/mason.nvim",
			build = function()
				pcall(vim.cmd, "MasonUpdate")
			end,
			keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		},
		{ "williamboman/mason-lspconfig.nvim" },

		-- Autocompletion
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "L3MON4D3/LuaSnip" },
		{ "saadparwaiz1/cmp_luasnip" },

		-- Other tools
		{ "jose-elias-alvarez/null-ls.nvim" },
		{ "nvimdev/lspsaga.nvim", config = true },
	},
	config = function()
		-- Set up LSP
		local lsp = require("lsp-zero").preset()
		lsp.on_attach(function(client, bufnr)
			lsp.default_keymaps({ bufnr = bufnr, omit = { "<F2>", "<F4>", "gd" } })
			-- Define keymaps here
			vim.keymap.set(
				"n",
				"<leader>cf",
				"<cmd>lua vim.lsp.buf.format({async = true})<cr>",
				{ desc = "Format Document" }
			)
		end)

		local format_servers = {
			["null-ls"] = { "lua", "python", "rust", "json" },
		}
		lsp.format_mapping("<leader>cf", {
			servers = format_servers,
		})

		lsp.format_on_save({
			servers = format_servers,
		})

		lsp.ensure_installed({
			"lua_ls",
			"rust_analyzer",
			"pyright",
		})

		lsp.setup()

		-- Add in neovim lua stuffs
		require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

		-- Set up lspsaga things
		vim.keymap.set("n", "<leader>cr", "<cmd>Lspsaga rename<cr>", { desc = "Rename Variable" })
		vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<cr>", { desc = "Perform Code Action" })
		vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<cr>", { desc = "Go to Definition" })
		vim.keymap.set("n", "gD", "<cmd>Lspsaga peek_definition<cr>", { desc = "Peek Definition" })
		vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<cr>", { desc = "Go to references" })
		vim.keymap.set("n", "gl", "<cmd>Lspsaga show_line_diagnostics<cr>", { desc = "Line Diagnostics" })
		vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", { desc = "Hover documentation" })
		vim.keymap.set("n", "<leader>ft", "<cmd>Lspsaga term_toggle<cr>", { desc = "Toggle a terminal popup" })

		-- Set up null-ls
		local nls = require("null-ls")
		nls.setup({
			sources = {
				nls.builtins.formatting.stylua,
				nls.builtins.diagnostics.luacheck,
				nls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
				nls.builtins.diagnostics.ruff,
				nls.builtins.formatting.shfmt,
				nls.builtins.formatting.yamlfmt,
				nls.builtins.formatting.fixjson,
				nls.builtins.formatting.rustfmt,
				-- nls.builtins.code_actions.typescript,
			},
		})

		-- Set up CMP
		local cmp = require("cmp")
		cmp.setup({
			-- Uncomment this to auto-select the first item
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			matching = {
				disallow_fuzzy_matching = true,
				disallow_fullfuzzy_matching = true,
				disallow_partial_fuzzy_matching = true,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<S-CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			}),
		})
	end,
}
