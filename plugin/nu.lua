local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.nu = {
    install_info = {
        url = "https://github.com/LhKipp/tree-sitter-nu",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "main"
    },
    filetype = "nu"
}
