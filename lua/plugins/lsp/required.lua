local is_installed = function(cmd)
    return vim.fn.executable(cmd) == 1
end

-- NOTE: these are mason names, not lspconfig names. in mason, that's the first name (if there are two)
local ensure_installed = {
    -- language servers
    "basedpyright",
    "bash-language-server",
    "json-lsp",
    "css-lsp",
    "taplo", -- note that the default config doesn't activate unless the toml file is in a git repo
    "yaml-language-server",
    "vtsls",
    "lua-language-server",
    "html-lsp",
    "tailwindcss-language-server",
    "docker-compose-language-service",
    "dockerfile-language-server",

    -- tools
    "stylua",
    "fixjson",
    "shfmt",
    "yamlfmt",
    "ruff",
    "prettier",
}

-- go
if is_installed("go") then
    ensure_installed[#ensure_installed + 1] = "gopls"
    ensure_installed[#ensure_installed + 1] = "templ"
    ensure_installed[#ensure_installed + 1] = "gofumpt"
    ensure_installed[#ensure_installed + 1] = "golangci-lint"
end

if is_installed("terraform") then
    ensure_installed[#ensure_installed + 1] = "terraform-ls"
end

-- run this command to sync all packages that aren't installed
vim.api.nvim_create_user_command("MasonInstallAll", function()
    local reg = require("mason-registry")
    for _, value in ipairs(ensure_installed) do
        if not reg.is_installed(value) then
            local pkg = reg.get_package(value)
            pkg:install()
        end
    end
end, {})

return {}
