" vim:foldmethod=marker

if exists('g:vscode')
  let mapleader=" "
  nnoremap <silent> <leader>K <Cmd>call VSCodeCall('editor.action.showHover')<CR>
  nnoremap <silent> <leader>v <Cmd>call VSCodeCall('workbench.action.splitEditorOrthogonal')<CR>
  nnoremap <silent> <leader>h <Cmd>call VSCodeCall('workbench.action.splitEditor')<CR>

  set hlsearch
  set incsearch
  set ignorecase
  set smartcase

  finish
endif

if empty(glob('~/.config/nvim/autoload/plug.vim')) && has('unix')
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
if has('nvim')
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
endif
Plug 'reedes/vim-colors-pencil'
Plug 'puremourning/vimspector'
Plug 'axelf4/vim-strip-trailing-whitespace'
Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'kkvh/vim-docker-tools'
Plug 'cohama/lexima.vim'
if has('python3') || has('python')
  Plug 'https://gitlab.com/code-stats/code-stats-vim.git', { 'tag': 'v0.6.0' }
endif
Plug 'junegunn/vim-plug'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'hzchirs/vim-material'
Plug 'sickill/vim-pasta'
Plug 'neoclide/coc.nvim', {'tag': '*'}
if has('nvim')
  Plug 'meain/vim-package-info', { 'do': 'npm install' }
endif
Plug 'diepm/vim-rest-console'
Plug 'junegunn/goyo.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-dispatch'
Plug 'AndrewRadev/linediff.vim'
Plug 'inside/vim-search-pulse'
if has('nvim')
  Plug 'kizza/ask-vscode.nvim'
  Plug 'kizza/actionmenu.nvim'
endif
if (executable('rg') == 1)
  Plug 'alok/notational-fzf-vim'
endif
Plug 'heavenshell/vim-jsdoc', { 'for': ['typescript', 'javascript', 'javascript.jsx'] }
Plug 'rhysd/git-messenger.vim'
Plug 'wakatime/vim-wakatime'
Plug 'sheerun/vim-polyglot'
Plug 'liuchengxu/vista.vim'
Plug 'mg979/vim-visual-multi'
Plug 'wellle/tmux-complete.vim'
if !empty(glob('~/Dropbox/vimwiki'))
    Plug 'vimwiki/vimwiki'
endif
Plug 'scrooloose/nerdtree'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'alvan/vim-closetag', { 'for': 'html' }
Plug 'nanotech/jellybeans.vim'
Plug 'junegunn/fzf.vim'
if has('python3') == 1
  Plug 'TaDaa/vimade'
endif
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'romainl/vim-devdocs'
if has('nvim') || v:version > 800
  Plug 'w0rp/ale'
  Plug 'romainl/vim-cool'
  Plug 'machakann/vim-highlightedyank'
  Plug 'fcpg/vim-showmap'
endif
Plug 'othree/csscomplete.vim', { 'for': 'css' }
Plug 'dominikduda/vim_current_word'
Plug 'dominikduda/vim_yank_with_context'
Plug 'mhartington/oceanic-next'
if !has('nvim')
    Plug 'xtal8/traces.vim'
endif
Plug 'ntpeters/vim-better-whitespace'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'airblade/vim-rooter'
Plug 'cdata/vim-tagged-template'
Plug 'metakirby5/codi.vim'
Plug 'janko/vim-test'

call plug#end()
" }}}
" General settings {{{
filetype plugin indent on
" show numberlines
set nu
set rnu

set encoding=utf-8

set updatetime=400

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
  set guifont=Iosevka:h10
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
if has('nvim')
  set termguicolors
endif
set background=dark
colorscheme vim-material
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

set fillchars=vert:┃ " for vsplits
set fillchars+=fold:· " for folds

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
set list
set listchars=tab:»•,trail:•,extends:>,precedes:<
set listchars+=eol:↴

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
augroup TermSetup
  autocmd BufEnter term://* startinsert
augroup END
" No line numbers in terminal
if has('nvim')
  au TermOpen * setlocal nonumber norelativenumber
endif

augroup PlaintextFiles
  autocmd!
  autocmd FileType vim-plug,docker-tools set nonumber norelativenumber
augroup END

if has('nvim-0.3.2') || has("patch-8.1.0360")
  " better diff algorithm
  set diffopt=filler,internal,algorithm:histogram,indent-heuristic
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
" (c)opy (e)verything to clipboard
nnoremap <leader>ce :%y<CR>
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

nnoremap <leader>ev :e $HOME/dotfiles/nvimrc<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>

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
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
" navigate chunks
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap <leader>cgd <Plug>(coc-git-chunkinfo)
" show blame for current line
nmap <leader>cgc <Plug>(coc-git-commit)
" Remap keys for gotos
nmap <silent> <leader>cd <Plug>(coc-definition)
nmap <silent> <leader>ctd <Plug>(coc-type-definition)
nmap <silent> <leader>ci <Plug>(coc-implementation)
nmap <silent> <leader>cr <Plug>(coc-references)
" Use K for show documentation in preview window
nnoremap <silent> <leader>K :call <SID>show_documentation()<CR>
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>cpl :CocList project<CR>
" Show all diagnostics
nnoremap <silent> <space>cld  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>cle  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>clc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>clo  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>cls  :<C-u>CocList -I symbols<cr>

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
  \ 'coc-lists',
  \ 'coc-yank',
  \ 'coc-python',
  \ 'coc-yaml',
  \ 'coc-tsserver',
  \ 'coc-phpls',
  \ 'coc-lua',
  \ 'coc-vimlsp',
  \ 'coc-stylelint',
  \ 'coc-import-cost',
  \ 'coc-git',
  \ 'coc-diagnostic',
  \ 'coc-docker',
  \ 'coc-marketplace',
  \ 'coc-project',
  \ 'coc-sh',
  \ 'coc-lit-html',
  \ 'coc-angular',
  \ 'coc-explorer'
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
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki'}]
let g:vimwiki_hl_headers = 1
let wiki = {}
let wiki.path = '~/Dropbox/vimwiki'
" }}}
" closetag {{{
let g:closetag_filenames = "*.html,*.xhtml,*.phtml"
" }}}
" ALE {{{
let g:ale_set_signs = 0
" }}}
" vim-test {{{
if has('nvim')
  let test#strategy = "neovim"
endif
nnoremap <leader>ts :TestSuite<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>tn :TestNearest<CR>
nnoremap <leader>tl :TestLast<CR>
" }}}
" vim current word {{{
let g:vim_current_word#highlight_current_word = 0
" }}}
" fzf {{{
" use fzf as fuzzy search
set rtp+=~/.fzf

if executable('bat')
  let g:fzf_file_options = "--preview 'bat --color \"always\" {}'"
endif

nnoremap <silent> <c-p> :Files<cr>
nnoremap <leader>pf :GFiles<cr>

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 ruler

command! -bang Commits call fzf#vim#commits({'options': '--preview'}, <bang>0)

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
" notational-fzf-vim {{{
let g:nv_search_paths = ['~/Dropbox/vimwiki']
" }}}
" editorconfig-vim {{{
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']
" }}}
" statusline {{{
set statusline=
set statusline+=%#Special#
set statusline+=%#LineNr#
set statusline+=\ %f%r
set statusline+=%m
set statusline+=%=
set statusline+=%#Comment#
set statusline+=%{&filetype}
set statusline+=\ \[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%-4c
" }}}
" actionmenu.nvim {{{
let s:code_actions = []

func! ActionMenuCodeActions() abort
  let s:code_actions = CocAction('codeActions')
  let l:menu_items = map(copy(s:code_actions), { index, item -> item['title'] })
  call actionmenu#open(l:menu_items, 'ActionMenuCodeActionsCallback')
endfunc

func! ActionMenuCodeActionsCallback(index, item) abort
  if a:index >= 0
    let l:selected_code_action = s:code_actions[a:index]
    let l:response = CocAction('doCodeAction', l:selected_code_action)
  endif
endfunc

nnoremap <silent> <Leader>ac :call ActionMenuCodeActions()<CR>
" }}}
" vim-rest-console {{{
let g:vrc_set_default_mapping = 0
let g:vrc_horizontal_split = 1
nnoremap <leader>re :call VrcQuery()<CR>
" }}}
" {{{ code-stats-vim
let g:codestats_api_key = 'SFMyNTY.Wkd0dWN3PT0jI05qWXlPQT09.RyIB_9tEmw2WImkKtn83Ifco5-XSbVMMdgexHy6G5YQ'
" }}}
" {{{ indentLine
let g:indentLine_char = '▏'
" }}}
" {{{ indent-blankline.nvim
let g:indent_blankline_char = '▏'
" }}}
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
\     '*.ts': {
\       'alternate': '{basename}.test.ts',
\       'type': 'source'
\     },
\     '*.test.ts': {
\       'alternate': '{basename}.ts',
\       'type': 'test'
\     },
\   }
\ }
" }}}
" Languages {{{
augroup customfiletypes
  au BufRead,BufNewFile .env set filetype=conf
augroup END
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
