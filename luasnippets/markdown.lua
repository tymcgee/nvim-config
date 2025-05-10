local function date()
    return os.date("%A %Y-%m-%d")
end

return {
    s("date", f(date)),
}
