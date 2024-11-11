local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.nu.filetype = "nu"

vim.filetype.add({
    extension = {
        nu = "nu"
    }
})
