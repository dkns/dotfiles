autoload -Uz compinit promptinit
autoload -U colors && colors
compinit
promptinit

bindkey -e
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt histignorealldups
setopt promptsubst

export BROWSER="firefox"
export EDITOR="vim"
export TERM="xterm-256color"
export PATH="/home/daniel/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/daniel/.local/bin:/home/daniel/dotfiles/bin"

LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

# fixes tmux/vim issues

source ~/.fzf.zsh
export PROJECT_HOME=$HOME/projects
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
source /usr/local/bin/virtualenvwrapper_lazy.sh

LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

alias gd='git diff'
alias gst='git status'
alias ls='ls --color=auto --human-readable --classify'
alias gptar='gitptar.sh'

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

alias nvi="/usr/local/bin/nvim"
alias slp="sudo sh -c \"echo mem > /sys/power/state\""
alias fullup="sudo apt-get update && sudo apt-get upgrade"
alias tv="terminal_velocity ~/Dropbox/notes"

##
# Completion system
#

autoload -Uz compinit
compinit

zstyle ":completion:*" auto-description "specify: %d"
zstyle ":completion:*" completer _expand _complete _correct _approximate
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
zstyle ':completion::complete:*' use-cache 1

zstyle ":completion:*:*:kill:*:processes" list-colors "=(#b) #([0-9]#)*=0=01;31"
zstyle ":completion:*:kill:*" command "ps -u $USER -o pid,%cpu,tty,cputime,cmd"

# version control info
autoload -Uz vcs_info
zstyle ":vcs_info:*" enable git svn
zstyle ":vcs_info:*" get-revision true
zstyle ":vcs_info:*" check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{28}●'
zstyle ':vcs_info:*' unstagedstr '%F{11}●'
zstyle ':vcs_info:git*' actionformats "%s %b (%a) %m %u %c"

precmd() {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats ' [%F{green}%b%c%u%F{blue}]'
    } else {
        zstyle ':vcs_info:*' formats ' [%F{green}%b%c%u%F{red}●%F{blue}]'
    }

    vcs_info
}
setopt prompt_subst
PROMPT='%F{blue}${PR_BLUE}%~${vcs_info_msg_0_}%F{blue} %(?/%F{blue}/%F{red})%% %{$reset_color%}'
