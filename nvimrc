" vim:foldmethod=marker

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
call plug#begin()

" Vim plug {{{
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
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'meain/vim-package-info', { 'do': 'npm install' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'heavenshell/vim-jsdoc', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'rhysd/git-messenger.vim'
Plug 'thaerkh/vim-workspace'
Plug 'wakatime/vim-wakatime'
Plug 'sheerun/vim-polyglot'
Plug 'liuchengxu/vista.vim'
Plug 'mg979/vim-visual-multi'
Plug 'vimwiki/vimwiki'
Plug 'scrooloose/nerdtree'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'alvan/vim-closetag', { 'for': 'html' }
Plug 'gavocanov/vim-js-indent', { 'for': 'javascript' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug '2072/PHP-Indenting-for-VIm', { 'for': 'php' }
if has('nvim') || v:version > 800
  if !exists("g:gui_oni")
    Plug 'w0rp/ale'
  endif
  Plug 'romainl/vim-cool'
  Plug 'machakann/vim-highlightedyank'
  Plug 'fcpg/vim-showmap'
endif
if !exists('g:gui_oni')
    Plug 'othree/csscomplete.vim', { 'for': 'css' }
endif
Plug 'dominikduda/vim_current_word'
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'
Plug 'mhinz/vim-signify'
if !has('nvim')
    Plug 'xtal8/traces.vim'
endif
Plug 'ntpeters/vim-better-whitespace'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'airblade/vim-rooter'
Plug 'rlue/vim-getting-things-down'
Plug 'cdata/vim-tagged-template'
Plug 'metakirby5/codi.vim'

call plug#end()
" }}}
" General settings {{{
filetype plugin indent on
" show numberlines
set nu

set encoding=utf-8

" don't highlight current line as it is really slow
set cursorline
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
  colorscheme OceanicNext
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
if has('nvim')
  set wildoptions=pum
endif

augroup resize
  autocmd!
  " let terminal resize scale the internal windows
  autocmd VimResized * :wincmd =
augroup END

set autoread
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime

" backspace
if !has('nvim')
  set backspace=2
  set backspace=indent,eol,start
endif

" remove numbers from preview window
augroup PreviewAutocmds
  autocmd!
  autocmd WinEnter * if &previewwindow | setlocal nonumber nornu | endif
augroup END

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

" Auto insert mode when entering terminal window
autocmd BufEnter term://* startinsert
" No line numbers in terminal
if has('nvim')
  au TermOpen * setlocal nonumber norelativenumber
endif

" }}}
" Keybinds {{{
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
" }}}
" Custom functions {{{
inoremap <silent><expr> <TAB>
\ pumvisible() ? "\<C-n>" :
\ <SID>check_back_space() ? "\<TAB>" :
\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" jump to last known cursos position when reopening a buffer
function! s:JumpToLastKnownCursorPosition()
    if line("'\"") <= 1 | return | endif
    if line("'\"") > line("$") | return | endif
    " Ignore git commit messages and git rebase scripts
    if expand("%") =~# '\(^\|/\)\.git/' | return | endif
    execute "normal! g`\"" |
endfunction

" send yank to TMUX
if exists('$TMUX')
    augroup TmuxYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system('tmux set-buffer ' . shellescape(@0)) | endif
    augroup END
endif
" }}}
" Plugins {{{
" coc.nvim {{{
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
autocmd CursorHoldI,CursorMovedI * silent! call CocAction('showSignatureHelp')

nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-emmet',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-jest',
  \ 'coc-snippets',
  \ 'coc-tag',
  \ 'coc-python',
  \ 'coc-yaml',
  \ 'coc-tsserver',
  \ 'coc-phpls',
  \ 'coc-stylelint'
\ ]

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" coc-prettier {{{
command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>pr  <Plug>(coc-format-selected)
nmap <leader>pr  <Plug>(coc-format-selected)
" }}}
" }}}
" {{{ vista
let g:vista_default_executive = 'coc'
" }}}
" netrw {{{
let g:netrw_liststyle=3
" }}}
" vimwiki {{{
let vimwikidir = expand('~/Dropbox/vimwiki')
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki', 'syntax': 'markdown', 'ext': '.wiki'}]
let g:vimwiki_hl_headers = 1
" }}}
" statusline {{{
function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf(
        \ 'W:%d E:%d',
        \ l:all_non_errors,
        \ l:all_errors
        \)
endfunction

function! GitInfo()
  let git = fugitive#head()
  if git != ''
    return ' '.fugitive#head()
  else
    return ''
endfunction

set statusline=\ 
set statusline+=%{GitInfo()}
set statusline+=\ %f 
set statusline+=%{LinterStatus()}
set statusline+=%m
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=
" }}}
" closetag {{{
let g:closetag_filenames = "*.html,*.xhtml,*.phtml"
" }}}
" css complete {{{
autocmd FileType css set omnifunc=csscomplete#CompleteCSS noci
" }}}
" vim current word {{{
let g:vim_current_word#highlight_current_word = 0
" }}}
" signify {{{
let g:signify_vcs_list = ['git']
let g:signify_sign_add = '┃'
let g:signify_sign_delete = '┃'
let g:signify_sign_change = '┃'
" }}}
" ALE {{{
if !exists("g:gui_oni")
  let g:ale_fixers = {
        \ 'javascript': ['eslint', 'prettier'],
        \}
endif
let g:ale_virtualtext_cursor = 1
" }}}
" tagged template {{{
let g:taggedtemplate#tagSyntaxMap = {
\ "html": "html",
\ "md":   "markdown",
\ "css":  "css" }

autocmd FileType javascript,typescript : call taggedtemplate#applySyntaxMap()
autocmd FileType html : call taggedtemplate#applySyntaxMap()
" }}}
" fzf {{{
" use fzf as fuzzy search
set rtp+=~/.fzf

nnoremap <silent> <c-p> :GFiles<cr>
nnoremap <leader>ff :Files<cr>
nnoremap <leader>pf :GFiles<cr>

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang Commits call fzf#vim#commits({'options': '--preview'}, <bang>0)

if executable('rg')
  nnoremap <leader>fw :Rg <C-R><C-W><CR>
  command! -bang -nargs=* Rg
        \ call fzf#vim#grep('rg --line-number --ignore-case --fixed-strings --glob "!.git/*" --color "always"
        \ '.shellescape(<q-args>), 1, <bang>0)
endif

if !executable('rg')
  nnoremap <leader>fw :Gg <C-R><C-W><CR>
endif

command! -bang -nargs=* Gg
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
" }}}
" rooter {{{
let g:rooter_patterns = ['.git/']
" }}}
" vim-workspace {{{
let g:workspace_session_directory = $HOME . '/.config/nvim/sessions/'
" }}}
" projectionist {{{
let g:projectionist_heuristics = {
\   '*': {
\     '*.c': {
\       'alternate': '{}.h',
\       'type': 'source'
\     },
\     '*.h': {
\       'alternate': '{}.c',
\       'type': 'header'
\     },
\     '*.js': {
\       'alternate': [
\         '{dirname}/{basename}.test.js',
\         '{dirname}/__tests__/{basename}-test.js',
\         '{dirname}/__tests__/{basename}-mocha.js'
\       ],
\       'type': 'source'
\     },
\     '*.test.js': {
\       'alternate': '{basename}.js',
\       'type': 'test',
\     },
\     '**/__tests__/*-mocha.js': {
\       'alternate': '{dirname}/{basename}.js',
\       'type': 'test'
\     },
\     '**/__tests__/*-test.js': {
\       'alternate': '{dirname}/{basename}.js',
\       'type': 'test'
\     },
\     '*.jsx': {
\       'alternate': [
\         '{dirname}/{basename}.test.jsx',
\         '{dirname}/__tests__/{basename}-test.jsx',
\         '{dirname}/__tests__/{basename}-mocha.jsx',
\         'components/__tests__/{basename}.test.jsx'
\       ],
\       'type': 'source'
\     },
\     '*.test.jsx': {
\       'alternate': '{basename}.jsx',
\       'type': 'test',
\     },
\     '**/__tests__/*-mocha.jsx': {
\       'alternate': '{dirname}/{basename}.jsx',
\       'type': 'test'
\     },
\     '**/__tests__/*-test.jsx': {
\       'alternate': '{dirname}/{basename}.jsx',
\       'type': 'test'
\     },
\     '*.lua': {
\       'alternate': 'spec/{basename}_spec.lua',
\       'type': 'source',
\     },
\     '*_spec.lua': {
\       'alternate': 'src/{basename}.lua',
\       'type': 'test',
\     },
\   }
\ }
" }}}
" Languages {{{
" PHP {{{
let php_sql_query = 1
let php_htmlInStrings = 1
" }}}
" Python {{{
let python_highlight_all = 1
let g:python_host_prog = 'python'
let g:python3_host_prog = 'python3'
" }}}
" Go {{{
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
nnoremap <leader>gr :GoRun<cr><esc>
" }}}
" }}}
" }}}
