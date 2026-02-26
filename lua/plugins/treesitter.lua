local fileEntered = { "BufReadPost", "BufWritePost", "BufNewFile" }
return {
    { "nvim-treesitter/nvim-treesitter-context", config = true, event = fileEntered },
    { "folke/ts-comments.nvim", opts = {}, event = fileEntered, enabled = vim.fn.has("nvim-0.10.0") == 1 },
    { "andymass/vim-matchup", event = fileEntered },

    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")
            local parsers = {
                "json",
                "yaml",
                "toml",
                "csv",
                "xml",
                "python",
                "lua",
                "luadoc",
                "rust",
                "bash",
                "javascript",
                "markdown",
                "markdown_inline",
                "regex",
                "typescript",
                "tsx",
                "gitcommit",
                "gitignore",
                "git_config",
                "sql",
                "css",
                "scss",
                "html",
                "htmldjango",
                "go",
                "gomod",
                "gosum",
                "gotmpl",
                "http",
                "svelte",
                "templ",
                "vimdoc",
                "fish",
                "c",
                "cpp",
                "make",
                "ssh_config",
                "caddy",
                "java",
                "javadoc",
                "terraform",
            }

            -- this is a no-op for parsers that are already installed
            ts.install(parsers)

            local patterns = {}
            for _, parser in ipairs(parsers) do
                local parser_patterns = vim.treesitter.language.get_filetypes(parser)
                for _, pp in pairs(parser_patterns) do
                    table.insert(patterns, pp)
                end
            end

            vim.treesitter.language.register("groovy", "Jenkinsfile")

            local start = function()
                vim.treesitter.start()
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
            Config.new_autocmd("FileType", patterns, start, "Enable treesitter")
        end,
    },
}
