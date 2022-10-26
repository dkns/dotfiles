autoload -Uz compinit promptinit
autoload -U colors && colors
autoload -Uz add-zsh-hook
compinit
promptinit

if [ -f ~/.zsh.local ]; then
  source ~/.zsh.local
fi

bindkey -e

HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP
setopt PROMPTSUBST
setopt AUTO_PARAM_SLASH
setopt AUTO_CD
setopt LIST_PACKED
setopt MENU_COMPLETE
setopt PRINT_EXIT_VALUE
setopt PROMPT_SUBST

export BROWSER="firefox"
export EDITOR="vim"
export GOPATH=$HOME/go
export PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$HOME/.local/bin:$HOME/dotfiles/bin:$HOME/dotfiles/bin/dasht"
export PATH=$PATH:/snap/bin

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
zstyle ':vcs_info:*' formats " %b"

# allow editing commands in vim
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

if [ -f /usr/share/autojump/autojump.sh ]; then
  source /usr/share/autojump/autojump.sh
fi

# pure prompt
# if [ -f $HOME/dotfiles/pure/async.zsh ]; then
#   source $HOME/dotfiles/pure/async.zsh
# fi

# if [ -f $HOME/dotfiles/pure/pure.zsh ]; then
#   source $HOME/dotfiles/pure/pure.zsh
# fi

# autoload -Uz async && async
# autoload -Uz pure

# FZF
export FZF_DEFAULT_OPTS="--extended --border"

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

function _tmux() {
  local current_dir=$(basename $(pwd))
  local active_session=$(tmux ls | grep $current_dir)

  if [ -z "${active_session// }" ]; then
    tmux new -s $current_dir
  else
    tmux attach -t $current_dir
  fi
}

function _dcssh() {
  docker exec $(docker-compose ps | grep Up | awk '{ print $1 }' | fzf) /bin/bash
}

function _get_changelog() {
  local format='short'
  if [ ! -z "$3" ]; then
    format="$3"
  fi
  git log "$1"..."$2" --format="$format" --no-merges --reverse
}

# tm [SESSION_NAME | FUZZY PATTERN] - create new tmux session, or switch to existing one.
# Running `tm` will let you fuzzy-find a session mame
# Passing an argument to `ftm` will switch to that session if it exists or create it otherwise
ftm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

# tm [SESSION_NAME | FUZZY PATTERN] - delete tmux session
# Running `tm` will let you fuzzy-find a session mame to delete
# Passing an argument to `ftm` will delete that session if it exists
ftmk() {
  if [ $1 ]; then
    tmux kill-session -t "$1"; return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux kill-session -t "$session" || echo "No session found to delete."
}

take_screenshot() {
  scrot -s '/tmp/%F_%T_$wx$h.png' -e 'xclip -selection clipboard -target image/png -i $f'
}

################################################################################
# aliases
################################################################################

alias ll='ls -lah'
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias ls='ls -F --color=auto'
else
  alias ls='ls --color=auto --human-readable --classify'
fi
alias gptar='gitptar.sh'
alias nvi="/usr/local/bin/nvim"
alias slp="sudo sh -c \"echo mem > /sys/power/state\""
alias fullup="sudo apt-get -y update && sudo apt-get -y upgrade"
alias -g G="| grep"
alias -g L="| less"
alias ehosts="sudo -e /etc/hosts"
alias bye="sudo shutdown -hP now"
alias rsync="rsync -v"
alias grep="grep --color=auto"
alias chmod='chmod --preserve-root -v'
alias chown='chown --preserve-root -v'
alias screenshot="take_screenshot"
alias pogoda='curl -s wttr.in/Szczecin'
alias tmx='_tmux'
alias dcssh='_dcssh'
# From Gary Bernhardt's dofiles
alias churn="git log --all -M -C --name-only --format='format:' "$@" | sort | grep -v '^$' | uniq -c | sort -n"
alias changelog='_get_changelog'
alias ww="nvim -c ':NV'"
alias history="history -i"
alias docui="docker run --rm -itv /var/run/docker.sock:/var/run/docker.sock skanehira/docui"
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias grep='ggrep'
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -f $HOME/.cargo/env ]; then
  source $HOME/.cargo/env
fi

precmd() {
  vcs_info
}

if [ -d /usr/local/go ]; then
  export PATH=$PATH:/usr/local/go/bin
fi

if [ -f /usr/bin/neomutt ]; then
  alias mail="neomutt"
fi

# my prompt
if [ -f "$HOME/dotfiles/serenity_prompt/serenity.zsh" ]; then
  source "$HOME/dotfiles/serenity_prompt/serenity.zsh"
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi
