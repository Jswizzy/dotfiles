" Lucas's .vimrc

" VUNDLE PLUGINS {{{

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Utilities
Plugin 'Chiel92/vim-autoformat'
Plugin 'Raimondi/delimitMate'
Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'christoomey/vim-sort-motion'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'sickill/vim-pasta'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Language-specific plugin
Plugin 'ap/vim-css-color'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'digitaltoad/vim-pug'
Plugin 'elzr/vim-json'
Plugin 'gavocanov/vim-js-indent'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'mattn/emmet-vim'
Plugin 'mxw/vim-jsx'
Plugin 'othree/html5.vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'othree/yajs.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'rstacruz/sparkup'
Plugin 'vim-syntastic/syntastic'
call vundle#end()

" }}}

" PLUGINS CONFIG {{{

" CtrlP
let g:ctrlp_cmd='CtrlPMixed'
let g:ctrlp_dotfiles=1
let g:ctrlp_working_path_mode = 'ra'

" Vim Indent Guides
let g:indent_guides_auto_colors=0
let g:indent_guides_enable_on_vim_startup=1
set ts=2
set sw=2 et

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=233

" Vim Airline
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts=1
let g:airline_skip_empty_sections=1

" Syntastic
let g:syntastic_javascript_checkers = ['eslint']

" Editorconfig
let g:EditorConfig_exec_path = '~/.editorconfig'

" JSX
" Allow JSX in normal JS files
let g:jsx_ext_required = 0

" }}}

" DEFAULT SETTINGS {{{

filetype plugin on " Detect filetype
set nocompatible " Use vim features
set encoding=utf-8 " Set encoding
set history=5000 " Increase command line history
let mapleader="," " Set leader key to ,
set clipboard=unnamed " Use OS clipboard by default
set autoindent " Copy indent to the new line
set wildmenu " Enhance command-line completion
set path+=** " Search down into subfolders
set tabstop=2 " Make tabs as wide as two spaces
set hlsearch " Highlight searches
set ignorecase " Ignore case of searches
set incsearch " Search as characters are entered
set showmatch " Show matching brackets when text indicator is over them
set backupcopy=yes " Prevent VIM from renaming files

" Visible whitespace prettier
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" No sound errors
set noerrorbells
set novisualbell
set ai " Auto indent
set si " Smart indent

" Use relative numbers
if exists("&relativenumber")
	set relativenumber
	au BufReadPost * set relativenumber
endif

" }}}

" KEY REMAPING {{{

" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" Space opens/closes folds
nnoremap <space> za
" Replace ESC key
inoremap jk <ESC>
" disable Ex mode
noremap Q <NOP>
" switch between current and last buffer
nmap <leader>. <c-^>
" next quicklist result
nnoremap ]q :cnext<CR>
" previuos quicklist result
nnoremap [q :cprev<CR>
" kill all open buffers
nnoremap <leader>bd :bufdo bdelete<CR>

" Quick panel navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Quick tabs switching
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

" Line navigation ignores line wrap
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Start search command
nnoremap \ :Search<CR>

" Search word under cursor
nnoremap K :silent grep <cword> \| copen<CR><C-l>

" }}}

" FOLDING {{{

set foldenable " Enable folding
set foldlevelstart=10 " Open most folds by default
set foldnestmax=10 " 10 nested fold max
set foldmethod=indent " Fold based on indent level

" }}}

" SILVER SEARCHER {{{

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --vimgrep
  set grepformat^=%f:%l:%c:%m   " file:line:column:message
endif

" }}}

" FUNCTIONS {{{

function! MySearch()
  let grep_term = input("grep: ")
  if !empty(grep_term)
    execute 'silent grep' grep_term | copen
  else
    echo "Empty search term"
  endif
  redraw!
endfunction

command! Search call MySearch()

" }}}

" TAB {{{

set expandtab " insert spaces for tabbed content
set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=2 " the visible width of tabs
set softtabstop=2 " edit as if the tabs are 2 characters wide
set shiftwidth=2 " number of spaces to use for indent and unindent
set shiftround " round indent to a multiple of 'shiftwidth'
set completeopt+=longest

" Defines indentation for HTML files
autocmd FileType html setlocal expandtab shiftwidth=4 softtabstop=4

" }}}

" VISUAL {{{

syntax on " Enable syntax highlight

" Set theme
set t_Co=256
colorscheme Benokai
highlight Normal term=bold cterm=NONE ctermfg=white ctermbg=NONE

set laststatus=2 " Show status line
set showmode " Show what mode you're currently in
set showcmd " Show what commands you're typing
set modelines=1 " Enable modelines
set number " Show line number

" Hightlight line color
hi CursorLine cterm=NONE ctermbg=234

hi TabLineFill ctermfg=231 ctermbg=16
hi TabLine ctermfg=250 ctermbg=16
hi TabLineSel ctermfg=231 ctermbg=240

" Custom line number theme
highlight LineNr term=bold cterm=NONE ctermfg=242 ctermbg=234

set title " Show file title in terminal tab
set cursorline " Highlight current line
set ruler " Show cursor position

" Set manualy foldmethod to marker specifically for .vimrc
" vim:foldmethod=marker:foldlevel=0
