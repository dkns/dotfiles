" vim:foldmethod=marker
" Check what OS we're using first

if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

if has("nvim")
  let g:version = "nvim"
else
  let g:version = "vim"
endif

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
call plug#begin()

" Plugins {{{
if has('python')
  Plug 'Valloric/MatchTagAlways', { 'for': 'html' }
endif
Plug 'Valloric/python-indent', { 'for': 'python' }
if !empty($TMUX)
  Plug 'christoomey/vim-tmux-navigator'
endif
Plug 'ap/vim-css-color'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-plug'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'sickill/vim-pasta'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'vimwiki/vimwiki'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'alvan/vim-closetag', { 'for': 'html' }
Plug 'gavocanov/vim-js-indent', { 'for': 'javascript' }
Plug 'junegunn/fzf.vim'
Plug 'jreybert/vimagit'
Plug '2072/PHP-Indenting-for-VIm', { 'for': 'php' }
if has('nvim') || v:version > 800
  if !exists("g:gui_oni")
    Plug 'w0rp/ale'
  endif
  Plug 'romainl/vim-cool'
endif
Plug 'mattn/emmet-vim'
if !exists('g:gui_oni')
    Plug 'sheerun/vim-polyglot'
    Plug 'othree/javascript-libraries-syntax.vim', { 'for' : 'javascript' }
    Plug 'othree/yajs.vim', { 'for': 'javascript' }
    Plug 'othree/html5.vim', { 'for': 'html' }
    Plug 'othree/es.next.syntax.vim', { 'for': 'javascript' }
    Plug 'Glench/Vim-Jinja2-Syntax'
    Plug '2072/vim-syntax-for-PHP', { 'for': 'php' }
    Plug 'othree/csscomplete.vim', { 'for': 'css' }
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'prabirshrestha/asyncomplete-flow.vim'
    Plug 'prabirshrestha/asyncomplete-buffer.vim'
endif
Plug 'dominikduda/vim_current_word'
Plug 'morhetz/gruvbox'
Plug 'mhinz/vim-signify'
Plug 'inside/vim-search-pulse'
Plug 'mhinz/vim-startify'
if !has('nvim')
    Plug 'xtal8/traces.vim'
endif
Plug 'ntpeters/vim-better-whitespace'
Plug 'fatih/vim-go', { 'for': 'go' }
if has('nvim') || v:version > 800
  Plug 'fcpg/vim-showmap'
endif
Plug 'airblade/vim-rooter'
Plug 'rlue/vim-getting-things-down'
Plug 'machakann/vim-highlightedyank'
Plug 'bendavis78/vim-polymer'

call plug#end()
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
" show numberlines
set rnu
set nu

set encoding=utf-8

" don't highlight current line as it is really slow
set nocursorline
set nocursorcolumn
set scrolljump=5

" hide buffers instead of closing them
set hidden

" syntax highlighting
syntax enable

" remove gui
if has('gui')
  set guioptions-=m
  set guioptions-=T
  set guioptions-=r
  set guioptions-=L
  " also set font on windows
  if has("gui_win32")
    set guifont=Consolas
  endif
endif

" colorscheme
set background=dark
if has('nvim')
  set termguicolors
endif
if !exists("g:gui_oni")
  colorscheme gruvbox
endif
set t_co=

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
if has('nvim')
  set inccommand=split
endif

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
let backupdir = expand('~/.config/nvim/backup')
if !isdirectory(backupdir)
  call mkdir(backupdir)
endif

let undodir = expand('~/.config/nvim/undo')
if !isdirectory(undodir)
  call mkdir(undodir)
endif

" Force backups to be copied from original, not renamed
set backupcopy=yes

"""""""""""""""""""
" Persistent Undo "
"""""""""""""""""""
set undofile                " Save undo's after file closes
set undodir=~/.config/nvim/undo     " where to save undo histories
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
set clipboard+=unnamedplus,unnamed

" Better handling of large files (no idea why this works though)
set synmaxcol=500

" ignore files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.py[co],*.pyc,*.jpg,*.mp3,*.wav,*.pdf
set wildignorecase

augroup resize
  autocmd!
  " let terminal resize scale the internal windows
  autocmd VimResized * :wincmd =
augroup END

set autoread
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime

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
nnoremap <silent> <c-p> :Files<cr>
nnoremap <silent> g/. :FZF <c-r>=fnameescape(expand("%:p:h"))<cr><cr>

if has('nvim') || has('terminal')
  tnoremap <ESC> <C-\><C-n>
  nnoremap <leader>t <c-w><c-w>i<UP><c-\><c-n>:sleep 100m<CR>i<CR><c-\><c-n><c-w><c-w>
endif

nnoremap <leader>r :History<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>tn :tabnew<CR>

iabbrev date- <c-r>=strftime("%Y-%m-%d")<cr>

" Don't overwrite register when deleting single letters
noremap <silent> x "_d<Right>
noremap <silent> X "_d<Left>

nnoremap <leader>me  :<c-u><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR> " Trim trailing spaces

" No ex mode
nnoremap Q <nop>

" move lines up and down!
nnoremap <silent> <M-k> :<C-u>move-2<CR>==
nnoremap <silent> <M-j> :<C-u>move+<CR>==
xnoremap <silent> <M-j> :move'>+<CR>gv=gv
xnoremap <silent> <M-k> :move-2<CR>gv=gv
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

" Auto insert mode when entering terminal window
autocmd BufEnter term://* startinsert
" No line numbers in terminal
if has('nvim')
  au TermOpen * setlocal nonumber norelativenumber
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" netrw
let g:netrw_liststyle=3

" vimwiki
let vimwikidir = expand('~/Dropbox/vimwiki')
if !isdirectory(vimwikidir)
  call mkdir(vimwikidir)
endif
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki'}]

augroup statusline
  autocmd!
  autocmd BufWinEnter,WinEnter,VimEnter * let w:getcwd = getcwd()
augroup END

function! StatuslineTag()
  if exists('b:git_dir')
    let dir = fnamemodify(b:git_dir[:-6], ':t')
    return dir." branch:".fugitive#head(7)
  else
    return fnamemodify(getwinvar(0, 'getcwd', getcwd()), ':t')
  endif
endfunction

if exists('g:loaded_fugitive')
    let &statusline = " %{StatuslineTag()} "
endif
let &statusline .= "%<%f"
let &statusline .= " | "
let &statusline .= "%{&readonly ? \"| \" : &modified ? '+ ' : ''}"
let &statusline .= "%=| %{&filetype == '' ? 'unknown' : &filetype} "
let &statusline .= "| %l:%2c | %p%% "

" closetag
let g:closetag_filenames = "*.html,*.xhtml,*.phtml"

" css complete
autocmd FileType css set omnifunc=csscomplete#CompleteCSS noci

" vim current word
let g:vim_current_word#highlight_current_word = 0

" signify
let g:signify_vcs_list = ['git']
let g:signify_sign_add = '┃'
let g:signify_sign_delete = '┃'
let g:signify_sign_change = '┃'
" ALE
if !exists("g:gui_oni")
  let g:ale_fixers = {
        \ 'javascript': ['eslint'],
        \}
endif

let g:lsp_auto_enable = 1

if has('nvim')
  if executable('javascript-typescript-stdio')
      au User lsp_setup call lsp#register_server({
          \ 'name': 'javascript-language-server',
          \ 'cmd': {server_info->['javascript-typescript-stdio']},
          \ 'whitelist': ['javascript', 'javascript.jsx'],
          \ })
  endif

  if executable('go-langserver')
      au User lsp_setup call lsp#register_server({
          \ 'name': 'go-langserver',
          \ 'cmd': {server_info->['go-langserver', '-mode', 'stdio']},
          \ 'whitelist': ['go'],
          \ })
  endif
endif

let g:asyncomplete_auto_popup = 1
let g:asyncomplete_remove_duplicates = 1
set completeopt+=preview

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#flow#get_source_options({
    \ 'name': 'flow',
    \ 'whitelist': ['javascript', 'javascript.jsx'],
    \ 'completor': function('asyncomplete#sources#flow#completor'),
    \ }))
" fzf
if executable('ag')
  command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
endif

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang Commits call fzf#vim#commits({'options': '--preview'}, <bang>0)

if executable('rg')
    command! -bang -nargs=* Rg call fzf#vim#grep('rg --line-number --ignore-case --fixed-strings --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
endif

command! -bang -nargs=* Gg
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
" rooter
let g:rooter_patterns = ['.git/']
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Languages
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PHP
let php_sql_query = 1
let php_htmlInStrings = 1

" python
let python_highlight_all = 1
syntax on
" Go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
nnoremap <leader>gr :GoRun<cr><esc>
