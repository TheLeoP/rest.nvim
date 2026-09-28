---@diagnostic disable: invisible
if vim.fn.has("nvim-0.10.1") ~= 1 then
    vim.notify_once("[rest.nvim] rest.nvim requires at least Neovim >= 0.10.1 in order to work")
    return
end

if vim.g.loaded_rest_nvim then
    return
end

-- Locate dependencies
local dependencies = {
    ["nvim-nio"] = "rest.nvim will not work asynchronously",
}
for dep, err in pairs(dependencies) do
    local found_dep
    if dep == "nvim-nio" then
        found_dep = package.searchpath("nio", package.path)
    end

    -- If the dependency could not be find in the Lua package.path then try to load it using pcall
    -- in case it has been installed through a regular plugin manager and not rocks.nvim
    if not found_dep then
        local found_dep2
        -- Both nvim-nio and lua-curl has a different Lua module name
        if dep == "nvim-nio" then
            found_dep2 = pcall(require, "nio")
        else
            found_dep2 = pcall(require, dep)
        end

        if not found_dep2 then
            vim.notify(
                "WARN: Dependency '" .. dep .. "' was not found. " .. err,
                vim.log.levels.ERROR,
                { title = "rest.nvim" }
            )
        end
    end
end

require("rest-nvim.autocmds").setup()
require("rest-nvim.commands").setup()
vim.treesitter.language.register("http", "rest_nvim_result")

-- setup highlight groups
require("rest-nvim.ui.highlights")

vim.g.loaded_rest_nvim = true
