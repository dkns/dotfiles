NEWLINE=$'\n'

WHITE="%F{white}"
RED="%F{red}"

function git_info() {
  ! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return
  zstyle ":vcs_info:*" enable git svn
  zstyle ":vcs_info:*" get-revision true
  zstyle ":vcs_info:*" check-for-changes true
  zstyle ':vcs_info:git*' actionformats ""

  local git_branch="$vcs_info_msg_0_"

  git_branch="${git_branch#heads/}"
  git_branch="${git_branch/.../}"
  echo "$git_branch"
}

function get_git_diff() {
  ! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return
  local INDEX
  local git_status=''

  INDEX=$(command git diff --shortstat | grep -oP "[0-9]." | tr '\n' ' ')
  IFS=' ' read var1 var2 var3 <<< $INDEX

  if [ ! -z "$var1" ]; then
    git_status="m: $var1"
  fi

  if [ ! -z "$var2" ]; then
    git_status="$git_status, +$var2"
  fi

  if [ ! -z "$var3" ]; then
    git_status="$git_status, -$var3"
  fi

  echo "$git_status"
}

function get_git_status() {
  local INDEX
  local git_status=''

  INDEX=$(command git status --porcelain -b 2> /dev/null)

  if $(echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null); then
    git_status="%F{green}"
  fi

  if $(echo "$INDEX" | command grep '^[ MARC]M ' &> /dev/null); then
    git_status='+'
  fi

  echo "$git_status"
}

function get_time() {
  echo "$WHITE%T $WHITE"
}

function get_path() {
  echo "$RED%~$WHITE"
}

function serenity_prompt() {
  RETVAL=$?

  local first_line second_line composed
  first_line="${NEWLINE}$(get_time)$(get_path)$(git_info) $(get_git_diff)$WHITE"
  second_line="> "
  composed="$first_line${NEWLINE}$second_line"
  echo "$composed"
}

PROMPT='$(serenity_prompt)'
