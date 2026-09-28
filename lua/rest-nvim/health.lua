---@mod rest-nvim.health rest.nvim healthcheck
---
---@brief [[
---
---Healthcheck module for rest.nvim
---
---@brief ]]

local health = {}

local function formatter_health()
    vim.health.start("Response body formatters")

    -- Formatter checking
    for _, ft in ipairs({ "json", "xml", "html" }) do
        local formatexpr = vim.api.nvim_get_option_value("formatexpr", { filetype = ft })
        local formatprg = vim.api.nvim_get_option_value("formatprg", { filetype = ft })
        if formatexpr == "" and formatprg == "" then
            vim.health.warn("Options 'formatexpr' or 'formatprg' are not set for " .. ft .. " filetype")
        else
            if formatexpr ~= "" then
                vim.health.ok(("Option 'formatexpr' is set to `%s` for %s filetype"):format(formatexpr, ft))
            else
                vim.health.ok(("Option 'formatprg' is set to `%s` for %s filetype"):format(formatexpr, ft))
            end
        end
    end
    vim.health.info("You can set formatter for each filetype via 'formatexpr' or 'formatprg' option")
end

function health.check()
    formatter_health()
end

return health
