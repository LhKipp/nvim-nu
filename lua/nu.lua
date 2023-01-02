local v = vim
local M = {}

local function defaultConfig()
    return {
        complete_cmd_names = true,
        all_cmd_names = [[nu -c 'help commands | get name | str join "\n"']]
    }
end

function M.setup(options)
    M.options = v.tbl_extend("keep", options, defaultConfig())
end

local is_initialised = false
function M._init()
    if is_initialised then
        return
    end
    is_initialised = true

    if M.options.complete_cmd_names then
        require 'nu.lsp'.init(M.options.all_cmd_names)
    end
end

return M
