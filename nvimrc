"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin manager
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
call plug#begin()

Plug 'Valloric/MatchTagAlways', { 'for': 'html' }
Plug 'Valloric/python-indent', { 'for': 'python' }
Plug 'bronson/vim-trailing-whitespace', { 'on': 'FixWhitespace' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'gorodinskiy/vim-coloresque', { 'for': ['css', 'sass', 'scss', 'less'] }
Plug 'haya14busa/incsearch.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-plug'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'othree/javascript-libraries-syntax.vim', { 'for' : 'javascript' }
Plug 'scrooloose/syntastic'
Plug 'sickill/vim-pasta'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'vimwiki/vimwiki'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'alvan/vim-closetag', { 'for': 'html' }
Plug 'romainl/Apprentice'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'gavocanov/vim-js-indent', { 'for': 'javascript' }
Plug 'junegunn/fzf.vim'
Plug 'marijnh/tern_for_vim', { 'for': 'javascript' }
Plug 'jreybert/vimagit'
Plug 'othree/csscomplete.vim', { 'for': 'css' }

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
" show numberlines
set nu

" don't highlight current line as it is really slow
set nocursorline
set nocursorcolumn
set scrolljump=5

" hide buffers instead of closing them
set hidden

" syntax highlighting
syntax enable

" colorscheme
set background=dark
colorscheme apprentice

" copy the previous indentation on autoindenting
set copyindent
if v:version >= 704 && has('patch338')
  set breakindent
endif
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
set wrap
set formatoptions=l

" Syntax highlight shell scripts as per POSIX,
" not the original Bourne shell which very few use.
let g:is_posix = 1

" Set the command window height to 2 lines, to avoid many cases of having to
" press <Enter> to continue
set cmdheight=2

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

" No swap files, thanks
set noswapfile

" Create backup/undo dirs
" FIXME
let backupdir = expand('~/.nvim/backup')
if !isdirectory(backupdir)
  call mkdir(backupdir)
endif

let undodir = expand('~/.nvim/undo')
if !isdirectory(undodir)
  call mkdir(undodir)
endif

" Force backups to be copied from original, not renamed
set backupcopy=yes

"""""""""""""""""""
" Persistent Undo "
"""""""""""""""""""
set undofile                " Save undo's after file closes
set undodir=~/.nvim/undo     " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" use fzf as fuzzy search
set rtp+=~/.fzf

" String to put at the start of lines that have been wrapped "
set linebreak
let &showbreak='↪ '

" Don't update the display while executing macros
set lazyredraw

set showmatch " show matching brackets
set matchtime=2 " reduce blinking time
set list listchars=tab:»•,trail:•,extends:>,precedes:<

" Yank to clipboard
set clipboard+=unnamedplus

" Better handling of large files (no idea why this works though)
set synmaxcol=500

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
nnoremap <leader>tv :sp +te<CR>
nnoremap <leader>th :vs +te<CR>
" navigating splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Make Y behave similar to D and C
nnoremap Y y$
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
nnoremap <leader>ce mmgg"+yG`m
" save read only file
cnoremap w!! w !sudo tee % >/dev/null
" I've had enough
:command W w
:command Q q
" FZF
nnoremap <silent> <c-p> :FZF<cr>
nnoremap <silent> g/. :FZF <c-r>=fnameescape(expand("%:p:h"))<cr><cr>

tnoremap <ESC> <C-\><C-n>
nnoremap <leader>t <c-w><c-w>i<UP><c-\><c-n>:sleep 100m<CR>i<CR><c-\><c-n><c-w><c-w>

nnoremap <leader>r :History<CR>
nnoremap <leader>b :Buffers<CR>

" Don't move on * From sjl dotfiles
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

iabbrev date- <c-r>=strftime("%Y-%m-%d")<cr>

" Don't overwrite register when deleting single letters
noremap <silent> x "_d<Right>
noremap <silent> X "_d<Left>

nnoremap <leader>me  :<c-u><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
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

if has('vim_starting') && has('reltime')
  let g:startuptime = reltime()
  augroup vimrc-startuptime
    autocmd! VimEnter * let g:startuptime = reltime(g:startuptime) | redraw
      \ | echomsg 'startuptime: ' . reltimestr(g:startuptime)
  augroup END
endif

" disable unnecessary default plugins
let g:loaded_gzip              = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:loaded_rrhelper          = 1
let g:loaded_2html_plugin      = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1

" Visually indicate when we're in insert mode.
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
let g:incsearch#consistent_n_direction = 1

" augroup statusline
"   autocmd!
"   autocmd BufWinEnter,WinEnter,VimEnter * let w:getcwd = getcwd()
" augroup END

" function! StatuslineTag()
"   if exists('b:git_dir')
"     let dir = fnamemodify(b:git_dir[:-6], ':t')
"     return dir." branch:".fugitive#head(7)
"   else
"     return fnamemodify(getwinvar(0, 'getcwd', getcwd()), ':t')
"   endif
" endfunction

" let &statusline = " %{StatuslineTag()} "
" let &statusline .= "\ue0b1 %<%f "
" let &statusline .= "%{&readonly ? \"\ue0a2 \" : &modified ? '+ ' : ''}"
" let &statusline .= "%=\u2571 %{&filetype == '' ? 'unknown' : &filetype} "
" let &statusline .= "\u2571 %l:%2c \u2571 %p%% "

" %< Where to truncate
" %n buffer number
" %F Full path
" %m Modified flag: [+], [-]
" %r Readonly flag: [RO]
" %y Type:          [vim]
" fugitive#statusline()
" %= Separator
" %-14.(...)
" %l Line
" %c Column
" %V Virtual column
" %P Percentage
" %#HighlightGroup#

set statusline=%<[%n]\ %F\ %m%r%y\ %{exists('g:loaded_fugitive')?fugitive#head(7):''}\ %=%-14.(%l,%c%V%)\ %P

if version >= 700
    au InsertEnter * highlight StatusLine ctermfg=203 ctermbg=236
    au InsertLeave * highlight StatusLine ctermfg=118 ctermbg=236
endif

" syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_javascript_checkers = ['jshint']

" closetag
let g:closetag_filenames = "*.html,*.xhtml,*.phtml"

" css complete
autocmd FileType css set omnifunc=csscomplete#CompleteCSS noci
