# nvim-nu - Basic editor support for the nushell language

![nu example](assets/nu-example.png)

---

**Warning: This plugin uses a [tree-sitter grammar](https://github.com/LhKipp/tree-sitter-nu) made for nu version ~0.45. As nushell evolves quickly, the tree-sitter plugin might be outdated by now, resulting in poor tree-sitter related functionality (highlighting, code-folding, ...). PR's are welcome**

---

### Table of contents

* [Requirements](#requirements)
* [Installation](#installation)
---

# Requirements

- Neovim version >= 0.5
- A [nu](https://github.com/nushell/nushell/releases) binary in your path
- A C compiler in your path and libstdc++ installed ([Windows users please read this!](https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support)).
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter/blob/master/README.md#quickstart) installed

# Installation

You can install `nvim-nu` with your favorite package manager (or using the native `package` feature of vim, see `:h packages`).

E.g., if you are using [vim-plug](https://github.com/junegunn/vim-plug), put this in your `init.vim` file:

```vim
Plug 'LhKipp/nvim-nu', {'do': ':TSInstall nu'}
```
