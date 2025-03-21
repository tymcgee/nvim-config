local function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

local function capitalize(args)
    -- args is the text from i(1) here, so {{"text"}}
    return firstToUpper(args[1][1])
end

-- stylua: ignore start
return {
    s(
        "useState",
        fmt("const [{}, set{}] = useState({})", {
            i(1),
            f(capitalize, { 1 }),
            i(2),
        })
    ),
}
