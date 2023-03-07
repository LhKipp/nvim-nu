local v = vim
local M = {}

local function defaultConfig()
    return {
        use_lsp_features = true,
        all_cmd_names = [[nu -c 'help commands | get name | str join "\n"']]
    }
end

function M.setup(options)
    M.options = v.tbl_extend("keep", options or {}, defaultConfig())
end

local is_initialised = false
function M._init()
    if is_initialised then
        return
    end
    is_initialised = true

    if M.options and M.options.use_lsp_features then
        require 'nu.lsp'.init(M.options.all_cmd_names)
    end
end

return M
