-- Set up lspconfig, mason, CMP, and null-ls
return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v3.x",
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
		local lsp_zero = require("lsp-zero")
		local lspconfig = require("lspconfig")

		lsp_zero.on_attach(function(client, bufnr)
			lsp_zero.default_keymaps({ buffer = bufnr, omit = { "<F2>", "<F4>", "gd" } })
			-- Define keymaps here
			vim.keymap.set(
				"n",
				"<leader>cf",
				"<cmd>lua vim.lsp.buf.format({async = true})<cr>",
				{ desc = "Format Document" }
			)
			-- use the active server
			-- (if there's more than one active server, they will both run formatting)
			lsp_zero.buffer_autoformat()
		end)

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"pyright",
				"html",
				"jsonls",
				"svelte",
				"tsserver",
			},
			-- Put server configurations in here
			handlers = {
				lsp_zero.default_setup,

				lua_ls = function()
					local lua_opts = lsp_zero.nvim_lua_ls()
					lspconfig.lua_ls.setup(lua_opts)
				end,

				html = function()
					lspconfig.html.setup({
						settings = {
							html = {
								format = {
									indentInnerHtml = true,
								},
							},
						},
					})
				end,

				svelte = function()
					lspconfig.svelte.setup({
						settings = {
							svelte = {
								plugin = {
									svelte = {
										format = {
											config = {
												printWidth = 120,
												svelteSortOrder = "options-scripts-styles-markup",
											},
										},
									},
								},
								enable_ts_plugin = true,
							},
						},
					})
				end,
			},
		})

		-- Set up lspsaga things
		vim.keymap.set("n", "<leader>cr", "<cmd>Lspsaga rename<cr>", { desc = "Rename Variable" })
		vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<cr>", { desc = "Perform Code Action" })
		vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<cr>", { desc = "Go to Definition" })
		vim.keymap.set("n", "gD", "<cmd>Lspsaga peek_definition<cr>", { desc = "Peek Definition" })
		vim.keymap.set("n", "gr", "<cmd>Lspsaga finder ref+def+imp<cr>", { desc = "Go to references" })
		vim.keymap.set("n", "gl", "<cmd>Lspsaga show_line_diagnostics<cr>", { desc = "Line Diagnostics" })
		vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", { desc = "Hover documentation" })
		vim.keymap.set("n", "<leader>ft", "<cmd>Lspsaga term_toggle<cr>", { desc = "Toggle a terminal popup" })

		-- Set up null-ls
		-- TODO: remove this, null-ls is archived
		local nls = require("null-ls")
		nls.setup({
			sources = {
				nls.builtins.formatting.stylua,
				nls.builtins.diagnostics.luacheck,
				nls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
				-- nls.builtins.diagnostics.ruff,
				nls.builtins.formatting.shfmt,
				nls.builtins.formatting.yamlfmt,
				nls.builtins.formatting.fixjson,
				nls.builtins.formatting.rustfmt,
				-- nls.builtins.code_actions.typescript,
			},
		})

		-- Set up CMP
		local cmp = require("cmp")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

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
