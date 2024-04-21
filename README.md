# nvim-nu - Basic editor support for the nushell language

![nu example](assets/nu-example.png)

---

**Info: This plugin was made for nu version ~0.45. As nushell evolves quickly, the plugin might not work perfectly for later versions. PR's are welcome**

---

### Table of contents

* [Requirements](#requirements)
* [Installation](#installation)
* [Configuration](#installation)
---

# Requirements

- Neovim version >= 0.5
- A [nu](https://github.com/nushell/nushell/releases) binary in your path
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter/blob/master/README.md#quickstart) installed
- Optionally [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim) to enable lsp features like hover (aka help) or command completion

# Installation

You can install `nvim-nu` with your favorite package manager (or using the native `package` feature of vim, see `:h packages`).

E.g., if you are using [vim-plug](https://github.com/junegunn/vim-plug), put this in your `init.vim` file:

```vim
Plug 'LhKipp/nvim-nu', {'do': ':TSInstall nu'}
```

Don't forget to call setup :smirk:
```lua
require'nu'.setup{}
```

## LSP Features

[null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim) needs to be installed to have lsp features available. Currently only command name completion and hover (aka help) are supported.

Make sure to have a mapping set up for hover in nushell files! E.G. in your `ftplugin/nu.lua`
```lua
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = true })
```

## Configuration
(Default values are shown)
```lua
require'nu'.setup{
    use_lsp_features = true, -- requires https://github.com/jose-elias-alvarez/null-ls.nvim
    -- lsp_feature: all_cmd_names is the source for the cmd name completion.
    -- It can be
    --  * a string, which is evaluated by nushell and the returned list is the source for completions (requires plenary.nvim)
    --  * a list, which is the direct source for completions (e.G. all_cmd_names = {"echo", "to csv", ...})
    --  * a function, returning a list of strings and the return value is used as the source for completions
    all_cmd_names = [[help commands | get name | str join "\n"]]
}
```

## Known issues (PR's welcome)

* Calling `vim.lsp.buf.hover` on a subcommand does not show the help for the subcommand
