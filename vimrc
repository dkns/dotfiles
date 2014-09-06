" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" show numberlines
set nu

" syntax highlighting
syntax enable

set background=dark
colorscheme solarized
" colorscheme tomorrow-night-eighties
se t_Co=16

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

set scrolloff=5

" Show partial commands in the last line of the screen
set showcmd

" Start highlighting search as soon as you begin typing
set hlsearch
set incsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Set the command window height to 2 lines, to avoid many cases of having to
" press <Enter> to continue
set cmdheight=2

" Better command-line completion
set wildmenu

" highlight current line
set cursorline

" set leader key
let mapleader=" "

" fancier statusline
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P

" navigating splits 
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" open new splits to the right and below
set splitright
set splitbelow

"Use TAB to complete when typing words, else inserts TABs as usual.
"Uses dictionary and source files to find matching words to complete.

"See help completion for source,
"Note: usual completion is on <C-n> but more trouble to press all the time.
"Never type the same word twice and maybe learn a new spellings!
"Use the Linux dictionary when spelling is in doubt.
"Window users can copy the file to their machine.
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words"

"Don't display warning about found swap file
set shortmess+=A

"Default indenting
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

"Python indenting
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
"html indenting
autocmd FileType html setlocal ts=2 et sts=2 sw=2

" Create backup/undo dirs
let swapdir = expand('~/.vim/swap')
if !isdirectory(swapdir)
  call mkdir(swapdir)
endif

let backupdir = expand('~/.vim/backup')
if !isdirectory(backupdir)
  call mkdir(backupdir)
endif

let backupdir = expand('~/.vim/undo')
if !isdirectory(backupdir)
  call mkdir(backupdir)
endif

" Force backups to be copied from original, not renamed
set backupcopy=yes

"""""""""""""""""""
" Persistent Undo "
"""""""""""""""""""
set undofile                " Save undo's after file closes
set undodir=~/.vim/undo     " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" use fzf as fuzzy search
set rtp+=~/.fzf

" Custom keybinds
" Error checking
autocmd FileType php nmap <buffer> <F5> :w<Esc>:!php -l %<CR>
autocmd FileType python nmap <buffer> <F5> :w<Esc>:exec '!python' shellescape(@%, 1)<CR>
" Make Y behave similar to D and C
nnoremap Y y$
" Search
nnoremap <leader>t :FZF<CR>

" String to put at the start of lines that have been wrapped "
let &showbreak='↪ '
set colorcolumn=80 " Draws a vertical line at column 80 "

" Don't update the display while executing macros
set lazyredraw

set showmatch " show matching brackets
set list listchars=tab:▸\ ,trail:-,extends:>,precedes:<,eol:¬

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" Allow backspacing over lines and stuff
set backspace=indent,eol,start

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Automatically reload file in vim if it was changed outside of vim
set autoread

" User H and L to move to beginning and end of the line
noremap H ^
noremap L $

nnoremap <leader>v :vsplit<CR>
nnoremap <leader>h :split<CR>
