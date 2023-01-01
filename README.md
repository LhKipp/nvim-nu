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
- [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim) if nu-command names shall be suggested

# Installation

You can install `nvim-nu` with your favorite package manager (or using the native `package` feature of vim, see `:h packages`).

E.g., if you are using [vim-plug](https://github.com/junegunn/vim-plug), put this in your `init.vim` file:

```vim
Plug 'LhKipp/nvim-nu', {'do': ':TSInstall nu'}
```

Don't forget to call setup :smirk:
```lua
require('nu').setup{}
```

## Configuration
(Default values are shown)
```lua
require('nu').setup({
    complete_cmd_names = true, -- requires https://github.com/jose-elias-alvarez/null-ls.nvim
    cmd_list = <see below>, -- table of string, containing all command to be used in completion
})
```

`cmd_list` allow user to make their own list of commands, generate command list
at each start up can make completion more environment aware. The default value
is:

```lua
local cmd_list
local cmd = [[nu -c 'help commands | get name | str join "\n"']]
local help_output = vim.fn.system(cmd)
if vim.v.shell_error == 0 then
    cmd_list = vim.fn.split(help_output, "\n")
end
```

If you want to include your customize commands in completion, you can do:

```lua
local cmd = [[nu --config <path-to-your-config> -c 'help commands | get name | str join "\n"']]
```
