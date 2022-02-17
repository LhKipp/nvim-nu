local null_ls = require("null-ls")
local log = require("nu.log")
local vim = vim

local function cmds_to_check(content, row, col)
    local cur_row = string.sub(content[row], 0, col + 1) -- Only until col is necessary
    log.trace("Completing line:", cur_row)
    local tokens = {}
    for token in string.gmatch(cur_row, "[^%s]+") do
       table.insert(tokens, token)
    end
    local result = {}
    local tokens_len = #tokens
    if tokens_len >= 2 then -- if more than 2 elements
        table.insert(result, {
            cmd_text = tokens[tokens_len - 1] .. " " .. tokens[tokens_len],
            is_sub_cmd = true
        })
    end
    if tokens_len >= 1 then
        table.insert(result, {
            cmd_text = tokens[tokens_len],
            is_sub_cmd = false
        })
    end
    log.trace("Found following tokens to complete", vim.inspect(result))
    return result
end  

local all_cmds = { "alias", "all", "any", "append", "binary", "bool", "build-string", "cal", "cd", "char", "collect", "columns", "command", "compact", "cp", "date date", "date format", "date humanize", "date list-timezone", "date now", "date parser", "datetime", "date to-table", "date to-timezone", "date utils", "debug", "decimal", "decode", "def", "default", "def-env", "describe", "detect-columns", "dfr aggregate", "dfr all-false", "dfr all-true", "dfr append", "dfr arg-max", "dfr arg-min", "dfr arg-sort", "dfr arg-true", "dfr arg-unique", "dfr column", "dfr command", "dfr concatenate", "dfr contains", "dfr cumulative", "dfr describe", "dfr drop", "dfr drop-duplicates", "dfr drop-nulls", "dfr dtypes", "dfr dummies", "dfr filter-with", "dfr first", "dfr get", "dfr get-day", "dfr get-hour", "dfr get-minute", "dfr get-month", "dfr get-nanosecond", "dfr get-ordinal", "dfr get-second", "dfr get-week", "dfr get-weekday", "dfr get-year", "dfr groupby", "dfr is-duplicated", "dfr is-in", "dfr is-not_null", "dfr is-null", "dfr is-unique", "dfr join", "dfr last", "dfr melt", "dfr n-null", "dfr not", "dfr n-unique", "dfr open", "dfr pivot", "dfr rename", "dfr rename", "dfr replace", "dfr replace-all", "dfr rolling", "dfr sample", "dfr set", "dfr set-with_idx", "dfr shape", "dfr shift", "dfr slice", "dfr sort", "dfr strftime", "dfr str-lengths", "dfr str-slice", "dfr take", "dfr to-csv", "dfr to-df", "dfr to-lowercase", "dfr to-nu", "dfr to-parquet", "dfr to-uppercase", "dfr unique", "dfr value-counts", "dfr with-column", "do", "drop column", "drop drop", "drop nth", "each", "each-group", "each-window", "echo", "empty", "env", "error-make", "every", "fetch", "filesize", "find", "first", "flatten", "fmt", "for", "from command", "from csv", "from delimited", "from eml", "from ics", "from ini", "from json", "from ods", "from ssv", "from toml", "from tsv", "from url", "from vcf", "from xlsx", "from xml", "from yaml", "generators", "get", "group-by", "hash base64", "hash generic-digest", "hash hash", "hash md5", "hash sha256", "help", "hide", "history", "if", "ignore", "int", "keep ", "keep until", "keep while", "last", "length", "let", "let-env", "lines", "load-env", "ls", "math abs", "math avg", "math ceil", "math eval", "math floor", "math math", "math max", "math median", "math min", "math mode", "math product", "math reducers", "math round", "math sqrt", "math stddev", "math sum", "math utils", "math variance", "merge", "metadata", "mkdir", "module", "move", "mv", "open", "par-each", "par-each group", "parse", "path basename", "path dirname", "path exists", "path expand", "path join", "path parse", "path path", "path relative-to", "path split", "path type", "prepend", "random bool", "random chars", "random decimal", "random dice", "random integer", "random random", "random uuid", "range", "reduce", "register", "reject", "rename", "reverse", "rm", "rotate", "save", "select", "seq", "seq-date", "shells enter", "shells exit", "shuffle", "size", "skip skip", "skip skip-until", "skip skip-while", "sort-by", "source", "split-by", "split chars", "split column", "split command", "split row", "str camel-case", "str capitalize", "str collect", "str contains", "str downcase", "str ends-with", "str find-replace", "str index-of", "string", "str kebab-case", "str length", "str lpad", "str pascal-case", "str reverse", "str rpad", "str screaming-snake_case", "str snake-case", "str starts-with", "str str", "str substring", "str trim/trim", "str upcase", "to command", "to csv", "to delimited", "to html", "to json", "to md", "to toml", "to tsv", "touch", "to url", "to xml", "to yaml", "transpose", "tutor", "uniq", "update", "update cells", "url host", "url path", "url query", "url scheme", "url url", "use", "version", "where", "with-env", "wrap", "zip", "end", }

local function find_commands(text)
    local results = {}
    local text_first_char = text:sub(1,1)
    for _, cmd in ipairs(all_cmds) do 
        if string.find(cmd, text) ~= nil then
            table.insert(results, cmd)
        end
        if cmd:sub(1,1) > text_first_char then
            break
        end
    end
    log.trace("Found", #results, "matching cmds for", text, "(", vim.inspect(results), ")")
    return results
end

local nu_lsp = {
    name = "nu_lsp",
    method = null_ls.methods.COMPLETION,
    filetypes = { "nu" },
    generator = {
        fn = function(params)
            local cmd_prefixes = cmds_to_check(params.content, params.row, params.col)
            for _, cmd_prefix in ipairs(cmd_prefixes) do
                local matching_cmds = find_commands(cmd_prefix.cmd_text)
                if next(matching_cmds) ~= nil then
                    local cmd_items = {}
                    for _, matched_cmd in ipairs(matching_cmds) do
                        local matched_cmd_txt = ""
                        if cmd_prefix.is_sub_cmd then -- we remove first part of cmd, if its a subcommand
                            for sub_cmd in string.gmatch(matched_cmd, "[^%s]+") do
                                matched_cmd_txt = sub_cmd
                            end
                        else
                            matched_cmd_txt = matched_cmd
                        end
                        table.insert(cmd_items, {label = matched_cmd_txt, insertText = matched_cmd_txt})
                    end
                    return {
                        {
                            items = cmd_items,
                            isIncomplete = true,
                        },
                    }
                end
            end
        end,
    },
}

null_ls.register(nu_lsp)
