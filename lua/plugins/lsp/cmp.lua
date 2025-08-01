return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "L3MON4D3/LuaSnip" },
        { "saadparwaiz1/cmp_luasnip" },
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
                format = require("lspkind").cmp_format({
                    before = function(entry, vim_item)
                        local highlights_info = require("colorful-menu").cmp_highlights(entry)

                        -- if highlight_info==nil, which means missing ts parser, let's fallback to use default `vim_item.abbr`.
                        -- What this plugin offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
                        if highlights_info ~= nil then
                            vim_item.abbr_hl_group = highlights_info.highlights
                            vim_item.abbr = highlights_info.text
                        end

                        return vim_item
                    end,
                }),
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
                {
                    name = "nvim_lsp",
                    priority_weight = 500,
                    -- it took me hours to figure how to stop python from suggesting things after pressing "["
                    -- this probably is slow as shit
                    entry_filter = function(entry, ctx)
                        return ctx.filetype ~= "python" or string.sub(ctx.cursor_before_line, -1) ~= "["
                    end,
                },
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
