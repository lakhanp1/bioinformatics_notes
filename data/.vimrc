
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

syntax on
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab

set showmatch " Shows matching brackets
set ruler " Always shows location in file (line#)
set smarttab " Autotabs for certain code
"set smartindent
set autoindent

set wildmenu

filetype plugin indent on
filetype indent on

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" Using vim-plug plugin manager from https://github.com/junegunn/vim-plug
"
" plugings installed from https://vimawesome.com/
"
" vim plug-in list
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
"
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'
"
" vim-plug commands
" `:PlugInstall`    Install plugins
" `:PlugUpdate`     Install or update plugins
" `:PlugClean[!]`   Remove unlisted pluging
"

call plug#begin()

Plug 'preservim/nerdcommenter'
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

Plug 'nathanaelkane/vim-indent-guides'
Plug 'kien/rainbow_parentheses.vim'
Plug 'vim-airline/vim-airline'
" Plug 'valloric/youcompleteme'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'quarto-dev/quarto-vim'

" end of plug-in list
call plug#end()


