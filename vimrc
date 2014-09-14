" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle install
filetype off                   " must be off before Vundle has run

if !isdirectory(expand("~/.vim/bundle/Vundle.vim/.git"))
    !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
endif

set runtimepath+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'Valloric/YouCompleteMe'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'scrooloose/syntastic'
Plugin 'Raimondi/delimitMate'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'sheerun/vim-polyglot'
Plugin 'bling/vim-airline'
Plugin 'Valloric/MatchTagAlways'
Plugin 'tpope/vim-commentary'
Plugin 'Yggdroot/indentLine'

call vundle#end()
filetype plugin indent on " and turn it back on!

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" show numberlines
set nu
" set relative numbers
set rnu

" syntax highlighting
syntax enable

" colorscheme
set background=dark
colorscheme solarized
set t_ut=

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

set scrolloff=5

" Show partial commands in the last line of the screen
set showcmd

" Start highlighting search as soon as you begin typing
" Use case insensitive search, except when using capital letters
set hlsearch
set incsearch
set ignorecase
set smartcase

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Syntax highlight shell scripts as per POSIX, not the original Bourne shell which very few use.
let g:is_posix = 1

" Set the command window height to 2 lines, to avoid many cases of having to
" press <Enter> to continue
set cmdheight=2

" Better command-line completion
set wildmenu

" highlight current line
set cursorline

" fancier statusline
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P

" open new splits to the right and below
set splitright
set splitbelow

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

" String to put at the start of lines that have been wrapped "
let &showbreak='↪ '
set colorcolumn=80 " Draws a vertical line at column 80 "

" Don't update the display while executing macros
set lazyredraw

set showmatch " show matching brackets
set matchtime=2 " reduce blinking time
set list listchars=tab:▸\ ,trail:-,extends:>,precedes:<,eol:¬

" Allow backspacing over lines and stuff
set backspace=indent,eol,start

" Automatically reload file in vim if it was changed outside of vim
set autoread

" Yank to clipboard
set clipboard+=unnamed

if has('gui_running')
    set guioptions-=m " remove menu bar
    set guioptions-=T " remove toolbar
    set guioptions-=r " remove right-hand scroll bar
    set guioptions-=L " remove left-hand scroll bar
endif

" I've had enough
:command W w
:command Q q

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keybinds
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set leader key
let mapleader=" "
" Check for syntax errors using syntastic
nnoremap <silent> <F9> :w<CR>:SyntasticCheck<CR>
inoremap <silent> <F9> <Esc>:w<CR>:SyntasticCheck<CR>a
" opening new splits
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>h :split<CR>
" clear the last search (instead of typing /asdfghjkl)
nnoremap <leader>c :noh<CR>
" navigating splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Make Y behave similar to D and C
nnoremap Y y$
" Search
nnoremap <leader>t :FZF
" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv
" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk
" User H and L to move to beginning and end of the line
noremap H ^
noremap L $
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Airline
let g:airline#extensions#tabline#enabled = 1

" Syntastic
let g:syntastic_warning_symbol='W>'
let g:syntastic_style_warning_symbol='s>'
let g:syntastic_error_symbol='E>'
let g:syntastic_style_error_symbol='S>'

" Better php completion
let g:phpcomplete_relax_static_constraint = 1
let g:phpcomplete_search_tags_for_variables = 1
let g:phpcomplete_parse_docblock_comments = 1
let g:phpcomplete_cache_taglists = 1
let g:phpcomplete_enhance_jump_to_definition = 1

" Use better syntax highlighting for php
function! PhpSyntaxOverride()
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
endfunction
augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
