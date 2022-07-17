# nvim-preview-svg

This plugin was created for visualizing the SVGs embedded (as HTML) in ReactJS, VueJS or, really, in any file. We hope this saves a lot of headaches (and time) for you.

## Installation

- Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use { 'nmassardot/nvim-preview-svg' }
```

- Using [vim-plug](https://github.com/junegunn/vim-plug)

```lua
Plug 'nmassardot/nvim-preview-svg' -- Then run :PlugInstall
```

## Usage

```lua
require('nvim-preview-svg').setup({
  browser = "Safari", -- it can be any browser you want!
  args = false -- macOS versions newer than BigSur may not work with --args
})
```

Run `:PreviewSvg` and it will open a browser window with the SVG parsed from the active buffer.

## Disclaimer

Currently working fine with SVGs that have only one `stroke` or `fill` property. Manage more than one per SVG is work in progress

## Contributing

Feel free to contribute with anything you like and think that will be useful, through a PR.

Also, if you thought about a new feature, find a bug, or anything, and you don't have enough time to develop it, let us know in the [issues](https://github.com/nmassardot/nvim-preview-svg/issues)

## Acknowledgements

`nvim-preview-svg` was developed by [Nicolás Massardo](https://github.com/nmassardot) and [Ramón Echeverría](https://github.com/rieg-ec)
