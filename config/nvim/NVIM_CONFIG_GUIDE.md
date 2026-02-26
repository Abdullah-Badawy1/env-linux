# Neovim Configuration Guide

A comprehensive LazyVim-based Neovim configuration with multiple themes, transparency support, and custom features.

## 📁 File Architecture

```
~/.config/nvim/
├── init.lua                    # Entry point - bootstraps lazy.nvim and LazyVim
├── lazy-lock.json             # Plugin version lockfile (managed by lazy.nvim)
├── lazyvim.json               # LazyVim configuration and enabled extras
├── stylua.toml                # Lua code formatting configuration
├── .gitignore                 # Git ignore patterns for nvim config
├── .neoconf.json              # Neoconf settings for LSP configuration
├── LICENSE                    # License file
├── README.md                  # LazyVim default readme
├── lua/
│   ├── config/                # Core configuration files
│   │   ├── autocmds.lua       # Custom autocommands
│   │   ├── keymaps.lua        # Custom keymaps and shortcuts
│   │   ├── lazy.lua           # Lazy.nvim plugin manager setup
│   │   └── options.lua        # Neovim options and settings
│   └── plugins/               # Custom plugin configurations
│       ├── all-themes.lua     # Multiple theme plugins (lazy-loaded)
│       ├── example.lua        # LazyVim example configurations (disabled)
│       ├── omarchy-theme-hotreload.lua  # Custom theme hot-reload system
│       └── snacks-animated-scrolling-off.lua  # Disable scroll animations
└── plugin/
    └── after/
        └── transparency.lua   # Transparency settings for UI elements
```

## 🚀 Features

### Core Features (LazyVim)
- **Plugin Management**: Lazy.nvim for fast, lazy-loaded plugin management
- **LSP Integration**: Built-in Language Server Protocol support with Mason
- **Syntax Highlighting**: Treesitter-based syntax highlighting
- **File Explorer**: Neo-tree file manager
- **Fuzzy Finding**: Telescope for file/text search
- **Git Integration**: Gitsigns for git status indicators
- **Completion**: Blink.cmp for autocompletion
- **Linting & Formatting**: Built-in linter and formatter integration
- **Status Line**: Lualine for informative status line
- **Buffer Management**: Bufferline for tab-like buffer management

### Custom Features
- **Multiple Themes**: 11 different colorschemes available
- **Theme Hot-reload**: Dynamic theme switching without restart
- **Transparency Support**: Comprehensive transparency for all UI elements
- **Disabled Animations**: Smooth scrolling disabled for better performance
- **Custom Keymaps**: Personalized key bindings (inherits LazyVim defaults)

## 🎨 Available Themes

Your configuration includes 11 different colorschemes:

1. **Bamboo** - `ribru17/bamboo.nvim`
2. **Catppuccin** - `catppuccin/nvim`
3. **Everforest** - `sainnhe/everforest`
4. **Flexoki** - `kepano/flexoki-neovim`
5. **Gruvbox** - `ellisonleao/gruvbox.nvim`
6. **Kanagawa** - `rebelot/kanagawa.nvim`
7. **Matte Black** - `tahayvr/matteblack.nvim`
8. **Monokai Pro** - `loctvl842/monokai-pro.nvim`
9. **Nord** - `shaunsingh/nord.nvim`
10. **Rose Pine** - `rose-pine/neovim`
11. **Tokyo Night** - `folke/tokyonight.nvim` (default)

### Switching Themes
To change themes, you need to create a `lua/plugins/theme.lua` file:

```lua
return {
  -- Add your preferred theme plugin
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
  },
  
  -- Configure LazyVim to use the theme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night", -- or any available colorscheme
    },
  },
}
```

Available colorscheme names:
- `bamboo`, `catppuccin`, `catppuccin-latte`, `catppuccin-frappe`, `catppuccin-macchiato`, `catppuccin-mocha`
- `everforest`, `flexoki-dark`, `flexoki-light`
- `gruvbox`, `kanagawa`, `kanagawa-wave`, `kanagawa-dragon`, `kanagawa-lotus`
- `matteblack`, `monokai-pro`, `monokai-pro-classic`, `monokai-pro-machine`, `monokai-pro-octagon`, `monokai-pro-ristretto`, `monokai-pro-spectrum`
- `nord`, `rose-pine`, `rose-pine-main`, `rose-pine-moon`, `rose-pine-dawn`
- `tokyonight`, `tokyonight-night`, `tokyonight-storm`, `tokyonight-day`, `tokyonight-moon`

## ⚙️ Configuration Files

### `init.lua`
Entry point that bootstraps the configuration by requiring `config.lazy`.

### `lua/config/lazy.lua`
- Installs lazy.nvim plugin manager if not present
- Configures plugin loading from LazyVim and custom plugins
- Sets up auto-update checking and performance optimizations
- Default colorscheme fallback: `tokyonight`, `habamax`

### `lua/config/options.lua`
Custom Neovim options:
- `vim.opt.relativenumber = false` - Disables relative line numbers

### `lua/config/keymaps.lua`
Currently inherits all keymaps from LazyVim defaults. Add custom keymaps here.

### `lua/config/autocmds.lua`
Currently inherits all autocommands from LazyVim defaults. Add custom autocommands here.

## 🔧 Plugin Configurations

### All Themes (`lua/plugins/all-themes.lua`)
Loads all 11 colorschemes as lazy-loaded plugins, making them available for the hot-reload system.

### Theme Hot-reload (`lua/plugins/omarchy-theme-hotreload.lua`)
Advanced theme switching system that:
- Listens for LazyVim reload events
- Clears highlight groups and syntax
- Unloads theme modules from memory
- Applies new colorscheme dynamically
- Reloads transparency settings
- Triggers UI updates for all plugins

### Transparency (`plugin/after/transparency.lua`)
Comprehensive transparency settings for:
- Normal windows and floating windows
- Popup menus and borders
- File explorers (Neo-tree, NvimTree)
- Telescope fuzzy finder
- Notification popups
- Terminal windows

### Scroll Animations (`lua/plugins/snacks-animated-scrolling-off.lua`)
Disables smooth scrolling animations from the Snacks plugin for better performance.

## 📦 Plugin Management

### Installing New Plugins
Add plugins to `lua/plugins/` directory. Create new `.lua` files:

```lua
return {
  {
    "plugin-author/plugin-name",
    lazy = true, -- or false
    config = function()
      -- plugin configuration
    end,
  }
}
```

### Updating Plugins
- `:Lazy update` - Update all plugins
- `:Lazy sync` - Sync plugins with lockfile
- `:Lazy clean` - Remove unused plugins

### Plugin Lockfile
`lazy-lock.json` contains exact plugin versions. Commit this file to ensure consistent plugin versions across installations.

## 🛠️ Maintenance

### When to Update

**Daily/Weekly:**
- `:Lazy update` - Update plugins (automatic checking enabled)
- `:Mason` - Update LSP servers, linters, formatters

**Monthly:**
- Review `lazy-lock.json` changes
- Test new LazyVim features in `lazyvim.json`
- Clean up unused plugins with `:Lazy clean`

**As Needed:**
- Update LazyVim extras in `lazyvim.json`
- Modify theme selection
- Add new keymaps or options

### When to Edit Files

**Edit `lua/config/options.lua` when:**
- Changing Neovim behavior (line numbers, tabs, search, etc.)
- Setting up project-specific options

**Edit `lua/config/keymaps.lua` when:**
- Adding custom key bindings
- Overriding LazyVim defaults
- Creating leader key shortcuts

**Edit `lua/config/autocmds.lua` when:**
- Setting up file-type specific behavior
- Creating custom automation
- Handling specific events

**Edit plugin files when:**
- Installing new plugins
- Configuring plugin behavior
- Disabling unwanted features

**Edit `plugin/after/transparency.lua` when:**
- Adjusting transparency settings
- Adding support for new plugins
- Fixing transparency issues with themes

### Troubleshooting

**Plugin Issues:**
1. `:Lazy check health` - Check plugin status
2. `:checkhealth` - General health check
3. `:Lazy restore` - Restore from lockfile

**Theme Issues:**
1. Check if theme plugin is loaded: `:Lazy`
2. Verify theme name in colorscheme list: `:colorscheme <Tab>`
3. Test without transparency: comment out `transparency.lua`

**Performance Issues:**
1. `:Lazy profile` - Check plugin load times
2. Disable unused features in plugin configs
3. Use lazy loading for non-essential plugins

## 🔑 Key Default Features (LazyVim)

**Essential Shortcuts:**
- `<leader>` = `<Space>`
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>e` - Toggle file explorer
- `<leader>gg` - LazyGit
- `<leader>xx` - Trouble diagnostics

**Window Management:**
- `<C-h/j/k/l>` - Navigate splits
- `<leader>-` - Split horizontal
- `<leader>|` - Split vertical

**Code Navigation:**
- `gd` - Go to definition
- `gr` - Go to references
- `K` - Show hover info
- `<leader>ca` - Code actions

## 💡 Tips

1. **Learning LazyVim**: Check `:LazyVim` for available commands and help
2. **Plugin Documentation**: Use `:help plugin-name` for plugin documentation
3. **Key Bindings**: Use `<leader>?` or `:WhichKey` to see available shortcuts
4. **Theme Preview**: All themes are loaded, so you can test any with `:colorscheme name`
5. **Transparency Toggle**: Modify `transparency.lua` and `:source %` to test changes

## 🔗 Resources

- [LazyVim Documentation](https://lazyvim.github.io/)
- [Lazy.nvim Plugin Manager](https://github.com/folke/lazy.nvim)
- [Neovim Documentation](https://neovim.io/doc/)

---

*This configuration provides a solid foundation for modern Neovim usage with extensive customization options and professional development features.*