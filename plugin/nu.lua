local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.nu = {
    install_info = {
        url = "https://github.com/LhKipp/tree-sitter-nu",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "main",
        revision = "ef943c6f2f7bfa061aad7db7bcaca63a002f354c",
    },
    filetype = "nu"
}

vim.filetype.add({
    extension = {
        nu = "nu"
    }
})
