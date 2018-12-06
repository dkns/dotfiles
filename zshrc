autoload -Uz compinit promptinit
autoload -U colors && colors
compinit
promptinit

if [ -f ~/.zsh.local ]; then
  source ~/.zsh.local
fi

bindkey -e
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
HISTTIMEFORMAT="%h/%d/%y - %H:%M:%S "
setopt inc_append_history
setopt share_history
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP
setopt promptsubst

export BROWSER="firefox"
export EDITOR="vim"
export TERM="xterm-256color"
export GOPATH=$HOME/go
export PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$HOME/.local/bin:$HOME/dotfiles/bin:$HOME/dotfiles/bin/dasht"

LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

# fixes tmux/vim issues

if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
fi

if [ -f ~/bin/tmux-gitbar.sh ]; then
  source ~/bin/tmux-gitbar.sh
fi

LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

bk() {
  cp -a "$1" "${1}_$(date --iso-8601=seconds)"
}

##
# Completion system
#

autoload -Uz compinit
compinit

zstyle ":completion:*" auto-description "specify: %d"
zstyle ":completion:*" completer _expand _complete _correct _approximate _match
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ":completion:*" format "Completing %d"
zstyle ":completion:*" group-name ""
zstyle ":completion:*" menu select=2
zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS}
zstyle ":completion:*" list-colors ""
zstyle ":completion:*" list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ":completion:*" matcher-list "" "m:{a-z}={A-Z}" "m:{a-zA-Z}={A-Za-z}" "r:|[._-]=* r:|=* l:|=*"
zstyle ":completion:*" menu select=long
zstyle ":completion:*" select-prompt %SScrolling active: current selection at %p%s
zstyle ":completion:*" verbose true
zstyle ':completion:*' use-cache 1
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' squeeze-slashes true
zstyle ":completion:*:*:kill:*:processes" list-colors "=(#b) #([0-9]#)*=0=01;31"
zstyle ":completion:*:kill:*" command "ps -u $USER -o pid,%cpu,tty,cputime,cmd"
zstyle -e ':completion:*:approximate:*' \
        max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

# version control info
autoload -Uz vcs_info
zstyle ":vcs_info:*" enable git svn
zstyle ":vcs_info:*" get-revision true
zstyle ":vcs_info:*" check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{28}●'
zstyle ':vcs_info:*' unstagedstr '%F{11}●'
zstyle ':vcs_info:git*' actionformats "%s %b (%a) %m %u %c"

# allow editing commands in vim
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

if [ -f /usr/share/autojump/autojump.sh ]; then
  source /usr/share/autojump/autojump.sh
fi

# pure prompt
if [ -f $HOME/dotfiles/pure/async.zsh ]; then
  source $HOME/dotfiles/pure/async.zsh
fi

if [ -f $HOME/dotfiles/pure/pure.zsh ]; then
  source $HOME/dotfiles/pure/pure.zsh
fi

autoload -Uz async && async
autoload -Uz pure

# FZF
export FZF_DEFAULT_OPTS='--extended'
v() {
  local file
  file=$(sed '1d' $HOME/.cache/neomru/file |
          fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && nvim $file
}

# vd - cd to most recent used directory by vim
vd() {
  local dir
  dir=$(sed '1d' $HOME/.cache/neomru/directory |
        fzf --query="$1" --select-1 --exit-0) && cd "$dir"
}

fgs() {
  local out shas sha q k
  while out=$(
      git log --graph --color=always \
          --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
      fzf --ansi --multi --no-sort --reverse --query="$q" \
          --print-query --expect=ctrl-d --toggle-sort=\`); do
    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    [ -z "$shas" ] && continue
    if [ "$k" = ctrl-d ]; then
      git diff --color=always $shas | less -R
    else
      for sha in $shas; do
        git show --color=always $sha | less -R
      done
    fi
  done
}

# fkill - kill process
fkill() {
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}

wgetnc() {
  cd /tmp/
  dir=$(basename $1 | cut -d. -f1)
  mkdir "moodle_$dir"
  cd "moodle_$dir"
  wget --no-check-certificate "$1"
  tar -xvf $(ls)
}

p() {
  project=$(ls ~/projects | fzf)
  if [[ -n "$project" ]]; then
    cd ~/projects/$project
  fi
}

fga() {
  git add $(git status | grep modified | awk -F ' ' '{print $2}' | fzf)
}

fgap() {
  git add -p $(git status | grep modified | awk -F ' ' '{print $2}' | fzf)
}

fgd() {
  git diff $(git status | grep modified | awk -F ' ' '{print $2}' | fzf)
}

function time_since_last_commit() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  git log -1 --pretty=format:"%ar" | sed 's/\([0-9]*\) \(.\).*/\1\2/'
}

function g {
  if [[ $# > 0 ]]; then
    git "$@"
  else
    echo "Last commit: $(time_since_last_commit) ago"
    git status --short --branch
  fi
}

################################################################################
# aliases
################################################################################

alias ll='ls -lah'
alias gd='git diff'
alias gst='git status'
alias ls='ls --color=auto --human-readable --classify'
alias gptar='gitptar.sh'
alias nvi="/usr/local/bin/nvim"
alias slp="sudo sh -c \"echo mem > /sys/power/state\""
alias fullup="sudo apt-get -y update && sudo apt-get -y upgrade"
alias tv="terminal_velocity ~/Dropbox/notes"
alias tl="todo ls"
alias -g G="| grep"
alias -g L="| less"
alias ehosts="sudo -e /etc/hosts"
alias moodlectags="ctags -R --languages=php --exclude="CVS" --php-kinds=f \
--regex-PHP='/abstract class ([^ ]*)/\1/c/' \
--regex-PHP='/interface ([^ ]*)/\1/c/' \
--regex-PHP='/(public |static |abstract |protected |private )+function ([^ (]*)/\2/f/'"
alias svnall="svn add --force ./*"
alias bye="sudo shutdown -hP now"
alias rsync="rsync -v --info=progress2"
alias td="nvi ~/Dropbox/todo.md"
alias grep="grep --color=auto"
alias chmod='chmod --preserve-root -v'
alias chown='chown --preserve-root -v'
alias v="$HOME/dotfiles/bin/nvim-client"
alias screenshot="scrot -s '/tmp/%F_%T_$wx$h.png' -e 'xclip -selection clipboard -target image/png -i $f'"
alias pogoda='curl -s wttr.in/Szczecin'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
