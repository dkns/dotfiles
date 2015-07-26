"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin manager
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:prefix = has('nvim') ? 'nvim' : 'vim'
let g:vim_dir = printf('$HOME/.%s', s:prefix)

let vim_plug_file=expand(g:vim_dir . "/autoload/plug.vim")
if !filereadable(vim_plug_file)
    echo "Installing vim-plug"
    echo ""
    silent exec "!mkdir -p " . g:vim_dir . "/autoload"
    silent exec "!curl -fLo " . vim_plug_file . " https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
endif

call plug#begin()

Plug 'Valloric/MatchTagAlways', { 'for': 'html' }
Plug 'Valloric/YouCompleteMe'
Plug 'Valloric/python-indent', { 'for': 'python' }
Plug 'bronson/vim-trailing-whitespace', { 'on': 'FixWhitespace' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'dkns/vim-distinguished'
Plug 'gorodinskiy/vim-coloresque', { 'for': ['css', 'sass', 'scss', 'less'] }
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'jaxbot/browserlink.vim', { 'for': [ 'html', 'css', 'javascript', 'php' ] }
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-plug'
Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'othree/javascript-libraries-syntax.vim', { 'for' : [ 'javascript' ] }
Plug 'scrooloose/syntastic'
Plug 'sickill/vim-pasta'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'vimwiki/vimwiki'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'docunext/closetag.vim', { 'for': 'html' }
Plug 'romainl/Apprentice'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
" show numberlines
set nu
set rnu

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
set t_ut=

" smart auto indent
set smartindent
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
set synmaxcol=180

if has('gui_running')
    set guifont=Inconsolata\ 11
    set guioptions-=m " remove menu bar
    set guioptions-=T " remove toolbar
    set guioptions-=r " remove right-hand scroll bar
    set guioptions-=L " remove left-hand scroll bar
    set guicursor=a:blinkon0
endif

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
nnoremap <leader>ce mmggVG"+y`m
" save read only file
cnoremap w!! w !sudo tee % >/dev/null
" I've had enough
:command W w
:command Q q
" FZF
nnoremap <silent> <c-p> :FZF<cr>
nnoremap <silent> g/. :FZF <c-r>=fnameescape(expand("%:p:h"))<cr><cr>
" Terminal binds (neovim only)
if has('nvim')
  tnoremap <ESC><ESC> <C-\><C-n>
  nnoremap <leader>t <c-w><c-w>i<UP><c-\><c-n>:sleep 100m<CR>i<CR><c-\><c-n><c-w><c-w>
endif

iabbrev date- <c-r>=strftime("%Y-%m-%d")<cr>
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

augroup tmux
  autocmd!
  autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window 'nvim | " . expand("%:t") . "'")
  autocmd VimLeave * call system("tmux rename-window 'tmux'")
augroup END
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_autoclose_preview_window_after_completion = 1

" vimwiki
let vimwikidir = expand('~/Dropbox/vimwiki')
if !isdirectory(vimwikidir)
  call mkdir(vimwikidir)
endif
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki'}]

" incsearch
map /  <Plug>(incsearch-fuzzy-/)
map ?  <Plug>(incsearch-fuzzy-?)
map g/ <Plug>(incsearch-stay)
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
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

" syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_javascript_checkers = ['jshint']

" Unite
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
let g:unite_split_rule = 'botright'
let g:unite_enable_start_insert=1
nnoremap <leader>fw :UniteWithCursorWord file_rec -default-action=split<CR>
nnoremap <leader>lf :Unite file_mru<CR>
nnoremap <silent><leader>b :Unite -auto-resize file file_mru file_rec<cr>
