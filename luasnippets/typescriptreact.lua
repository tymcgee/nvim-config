local function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

local function capitalize(args)
    -- args is the text from i(1) here, so {{"text"}}
    return firstToUpper(args[1][1])
end

return {
    s("trig", {
        t("const ["),
        i(1),
        t(", set"),
        f(capitalize, { 1 }),
        t("] = useState("),
        i(2),
        t(")"),
        i(0),
    }),
}
