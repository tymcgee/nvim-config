return {
    "Jezda1337/nvim-html-css",
    dependencies = { "hrsh7th/nvim-cmp", "nvim-treesitter/nvim-treesitter" },
    opts = {
        enable_on = require("html-filetypes"),
        -- style_sheets = {
        --     "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
        --     "https://cdnjs.cloudflare.com/ajax/libs/bulma/1.0.3/css/bulma.min.css",
        --     "./index.css", -- `./` refers to the current working directory.
        -- },
    },
}
