-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false

-- Basic settings (converted from your vimrc)
vim.opt.hidden = true -- Enable hidden buffers
vim.cmd("syntax on") -- Enable syntax highlighting
vim.opt.wildmenu = true -- Enable navigable menu
vim.opt.wildmode = "full" -- Cycle through all matches
vim.opt.path:append("**") -- Provides tab-completion for file-related tasks
vim.opt.number = true -- Show line numbers
vim.opt.conceallevel = 2 -- Concealment level
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.mouse = "a" -- Enable mouse support in all modes
vim.opt.hlsearch = true -- Highlight search results
vim.opt.incsearch = true -- Show incremental search results
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Unless search contains uppercase
vim.opt.encoding = "utf-8" -- Set file encoding
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = { "utf-8", "latin1" }
vim.opt.history = 300 -- Command history length
vim.opt.backup = false -- Disable backup files
vim.opt.writebackup = false -- Disable write backup
vim.opt.swapfile = false -- Disable swap files
vim.opt.autoread = true -- Auto read changed files
vim.opt.updatetime = 300 -- Reduce time before writing swap
vim.opt.showcmd = true -- Display incomplete commands
vim.opt.ruler = true -- Show cursor position
vim.opt.list = false -- Disable special EOF chars
vim.opt.fillchars = { eob = " " } -- Space for end-of-buffer
vim.opt.laststatus = 2 -- Always show status line
vim.opt.cmdheight = 2 -- Height of command bar
vim.opt.spell = false -- Disable spelling by default
vim.opt.spelllang = "en_us" -- Set spelling language
vim.opt.termguicolors = true -- True color support
vim.opt.background = "dark" -- Dark background
vim.opt.cursorline = true -- Highlight current line
vim.opt.signcolumn = "yes" -- Always show sign column (for LSP diagnostics)
vim.opt.expandtab = true -- Expand tabs to spaces (Python standard)
vim.opt.autoindent = true -- Auto indent
vim.opt.tabstop = 4 -- Tab width (Python standard)
vim.opt.shiftwidth = 4 -- Indent width (Python standard)
vim.opt.smartindent = true -- Smart indentation
vim.opt.softtabstop = 4 -- Soft tab stop
vim.opt.cindent = true -- C indentation
-- Disable folding completely for better performance
vim.opt.foldenable = false -- Disable folding
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
