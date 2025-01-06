	" Enable syntax highlighting
syntax on

" Show line numbers
set number
set conceallevel=2
set relativenumber
" Enable mouse support in all modes
set mouse=a

" Highlight search results
set hlsearch

" Show incremental search results as you type
set incsearch

" Case insensitive search...
set ignorecase

" ...unless search query contains uppercase letters
set smartcase

" Set file encoding to UTF-8
set encoding=utf-8

" Increase command history length
set history=300

" Disable creation of backup files
set nobackup

" Disable write backup files
set nowritebackup

" Disable swap files
set noswapfile

" Automatically read files changed outside Vim
set autoread

" Reduce time before writing swap file
set updatetime=300

" Display incomplete commands
set showcmd

" Always show the cursor position
set ruler

" Disable special characters for end-of-line
set nolist

" Use a space for end-of-buffer character
set fillchars+=eob:\ 

" Always display the status line
set laststatus=2

" Height of command bar
set cmdheight=2

" Enable spelling
set spell spelllang=en_us

" Enable true color support
set termguicolors

" Begin plugin section
call plug#begin('~/.vim/plugged')

" Plugin declarations
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
" End plugin section
call plug#end()

" Set colorscheme to gruvbox after plugins are loaded
colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
Plug 'vimwiki/vimwiki'
set background=dark

" Highlight the current line and column
set cursorline
"set cursorcolumn

" Tab and indent settings
set noexpandtab
set autoindent
set tabstop=4
set shiftwidth=4
set smartindent
set softtabstop=4
set cindent

" Folding settings
set foldmethod=syntax
set foldlevelstart=10
set nofoldenable

" Use the system clipboard
set clipboard=unnamedplus

" Set indentLine character
let g:indentLine_char='|'

" Custom key mappings
nnoremap <C-a> ggVG
nnoremap <C-q> :q!<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" Close Vim if NERDTree is the only window left
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Enable filetype detection and indentation
filetype plugin on
filetype indent on


" Yank to clipboard
vnoremap <C-c> :w !xsel --clipboard --input<CR>

" Paste from clipboard
nnoremap <C-v> :r !xsel --clipboard --output<CR>
