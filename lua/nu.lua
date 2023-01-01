local v = vim
local M = {}

local function defaultConfig()
    return {
        complete_cmd_names = true, -- requires https://github.com/jose-elias-alvarez/null-ls.nvim
    }
end

function M.setup(options)
    M.options = v.tbl_extend("keep", options, defaultConfig())

    if M.options.complete_cmd_names then
        local lsp = require('nu.lsp')

        local cmd_list = M.options.cmd_list
        lsp.set_cmd_list(cmd_list)
    end
end

return M
