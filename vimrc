"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin manager
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let iCanHazPlugged=1
let vim_plug_file=expand("~/.vim/autoload/plug.vim")
if !filereadable(vim_plug_file)
    echo "Installing vim-plug"
    echo ""
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let iCanHazPlugged=0
endif

call plug#begin()

Plug 'junegunn/vim-plug'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary',
Plug 'Valloric/YouCompleteMe'
Plug 'Valloric/MatchTagAlways', { 'for': 'html' }
Plug 'justinmk/vim-matchparenalways'
Plug 'altercation/vim-colors-solarized'
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
Plug 'bronson/vim-trailing-whitespace', { 'on': 'FixWhitespace' }
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/syntastic'
Plug 'Konfekt/FastFold'
Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'vimwiki/vimwiki'
Plug 'sickill/vim-pasta'
Plug 'airblade/vim-rooter'
Plug 'Valloric/python-indent'
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'tpope/vim-sleuth'
Plug 'jaxbot/browserlink.vim'
"Plug 'ludovicchabant/vim-gutentags'
Plug 'christoomey/vim-tmux-navigator'
Plug 'gorodinskiy/vim-coloresque'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
" show numberlines
set nu
" set relative numbers
set rnu

" hide buffers instead of closing them
set hidden

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" syntax highlighting
syntax enable

" colorscheme
set background=dark
colorscheme solarized
set t_ut=

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
" smart tab handling for indenting
set smarttab
" smart auto indent
set smartindent
" copy the previous indentation on autoindenting
set copyindent
" remember copy registers after quitting in the .viminfo file -- 20 jump links, regs up to 500 lines'
set viminfo='20,\"500

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

" Word wrap without breaking words in the middle
set formatoptions=l

" Syntax highlight shell scripts as per POSIX,
" not the original Bourne shell which very few use.
let g:is_posix = 1

" Set the command window height to 2 lines, to avoid many cases of having to
" press <Enter> to continue
set cmdheight=2

" Better command-line completion
set wildmenu

" highlight current line
set cursorline

" open new splits to the right and below
set splitright
set splitbelow

"Don't display warning about found swap file
set shortmess+=A

" Look for tags in directory above
set tags=./tags;/
" enable mouse in all modes
set mouse=a

"Default indenting
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" No swap files, thanks
set noswapfile

" Create backup/undo dirs
let backupdir = expand('~/.vim/backup')
if !isdirectory(backupdir)
  call mkdir(backupdir)
endif

let undodir = expand('~/.vim/undo')
if !isdirectory(undodir)
  call mkdir(undodir)
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

"add snipets to path
set rtp+=~/dotfiles/snips

" String to put at the start of lines that have been wrapped "
set linebreak
let &showbreak='↪ '

" Don't update the display while executing macros
set lazyredraw

set showmatch " show matching brackets
set matchtime=2 " reduce blinking time
set list listchars=tab:»•,trail:•,extends:>,precedes:<

" Allow backspacing over lines and stuff
set backspace=indent,eol,start

" Automatically reload file in vim if it was changed outside of vim
set autoread

" Yank to clipboard
set clipboard+=unnamedplus

" Better handling of large files (no idea why this works though)
set synmaxcol=180

if has('gui_running')
    set guifont=Inconsolata\ 11
    set guioptions-=m " remove menu bar
    set guioptions-=T " remove toolbar
    set guioptions-=r " remove right-hand scroll bar
    set guioptions-=L " remove left-hand scroll bar
    set guicursor=a:blinkon0
endif

" statusline
set statusline=%<[%n]\ %F\ %m%r%y\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}\ %=%-14.(%l,%c%V%)\ %P
" Show absolute line numbers when the window isn't in focus.
au WinEnter * setl rnu | au WinLeave * setl nornu
" ignore files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.py[co],*.pyc,*.jpg,*.mp3,*.wav,*.pdf

augroup resize
  autocmd!
  " let terminal resize scale the internal windows
  autocmd VimResized * :wincmd =
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keybinds
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set leader key
let mapleader=" "
" opening new splits
nnoremap <leader>v :split<CR>
nnoremap <leader>h :vsplit<CR>
" navigating splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Make Y behave similar to D and C
nnoremap Y y$
" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv
" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
" Use jk to exit insert mode
imap jk <ESC>
" use arrows to resize window
noremap <up>    <C-W>+
noremap <down>  <C-W>-
noremap <left>  3<C-W><
noremap <right> 3<C-W>>
" Easier pasting from clipboard
nnoremap <leader>p "+p
" (c)opy (e)verything to clipboard
nnoremap <leader>ce ggVG"+y
" save read only file
cnoremap w!! w !sudo tee % >/dev/null
" delete to blackhole register
nnoremap <leader>d "_d
vnoremap <leader>d "_d
" I've had enough
:command W w
:command Q q
" FZF
nnoremap <silent> <c-p> :FZF<cr>
nnoremap <silent> g/. :FZF <c-r>=fnameescape(expand("%:p:h"))<cr><cr>
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

" Don't move on * From sjl dotfiles
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" sudo apt-get install wmctrl for this to work
" function Maximize_Window()
"   silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
" endfunction
" au GUIEnter * call Maximize_Window()
" jump to last known cursos position when reopening a buffer
function! s:JumpToLastKnownCursorPosition()
    if line("'\"") <= 1 | return | endif
    if line("'\"") > line("$") | return | endif
    " Ignore git commit messages and git rebase scripts
    if expand("%") =~# '\(^\|/\)\.git/' | return | endif
    execute "normal! g`\"" |
endfunction

augroup bufread
  autocmd!
  autocmd BufReadPost * call s:JumpToLastKnownCursorPosition()
augroup END
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_autoclose_preview_window_after_completion = 1
" CtrlP
" let g:ctrlp_extensions = ['tag', 'buffertag', 'dir',
"                           \ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']
" let g:ctrlp_custom_ignore = '\v\.(mp3|m3u|jpg|jpeg|png|bpm|wav)$'
" let g:ctrlp_cmd = 'CtrlPMixed'

" vimwiki
let vimwikidir = expand('~/Dropbox/vimwiki')
if !isdirectory(vimwikidir)
  call mkdir(vimwikidir)
endif
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki'}]

" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
let g:incsearch#consistent_n_direction = 1
