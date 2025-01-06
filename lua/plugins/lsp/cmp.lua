return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "L3MON4D3/LuaSnip" },
        { "saadparwaiz1/cmp_luasnip" },
        { "luckasRanarison/tailwind-tools.nvim" },
        { "onsails/lspkind.nvim" }, -- symbols in dropdown
        { "xzbdmw/colorful-menu.nvim", config = true },
    },

    config = function()
        local cmp = require("cmp")
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

        cmp.setup({
            completion = {
                -- auto-select the first item
                completeopt = "menu,menuone,noinsert",
            },
            formatting = {
                -- enable colorful completion menu
                format = function(entry, vim_item)
                    local completion_item = entry:get_completion_item()
                    local highlights_info = require("colorful-menu").highlights(completion_item, vim.bo.filetype)

                    -- error, such as missing parser, fallback to use raw label.
                    if highlights_info == nil then
                        vim_item.abbr = completion_item.label
                    else
                        vim_item.abbr_hl_group = highlights_info.highlights
                        vim_item.abbr = highlights_info.text
                    end

                    -- colorize tailwind colors
                    local kind = require("lspkind").cmp_format({
                        before = require("tailwind-tools.cmp").lspkind_format,
                        mode = "symbol_text",
                    })(entry, vim_item)
                    local strings = vim.split(kind.kind, "%s", { trimempty = true })
                    vim_item.kind = " " .. (strings[1] or "") .. " "
                    vim_item.menu = ""

                    return vim_item
                end,
            },
            window = {
                completion = {
                    winhighlight = "CursorLine:Visual",
                },
            },
            -- don't allow LSPs to preselect a dropdown option
            preselect = "None",
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
                { name = "luasnip", priority_weight = 1000 },
                { name = "nvim_lsp", priority_weight = 500 },
                { name = "buffer", priority_weight = 200 },
                { name = "path", priority_weight = 200 },
            }),
            sorting = {
                priority_weight = 1,
                comparators = {
                    -- cmp.config.compare.score_offset, -- not good at all
                    cmp.config.compare.exact,
                    cmp.config.compare.locality,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
                    cmp.config.compare.offset,
                    cmp.config.compare.order,
                    -- cmp.config.compare.scopes, -- what?
                    -- cmp.config.compare.sort_text,
                    -- cmp.config.compare.kind,
                    -- cmp.config.compare.length, -- useless
                },
            },
        })
    end,
}
