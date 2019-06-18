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

  INDEX=$(command git diff --shortstat | grep -oP "[0-9]+" | tr '\n' ' ')
  IFS=' ' read modified added deleted <<< $INDEX

  if [ ! -z "$modified" ]; then
    git_status="~$modified"
  fi

  if [ ! -z "$added" ]; then
    git_status="$git_status +$added"
  fi

  if [ ! -z "$deleted" ]; then
    git_status="$git_status -$deleted"
  fi

  if [ -n "$git_status" ]; then
    echo "[$git_status]"
  fi

}

function get_git_status() {
  local INDEX
  local git_status=''

  INDEX=$(command git status --porcelain -b 2> /dev/null)

  if $(echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null); then
    git_status="%F{green} OK"
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
  # https://stackoverflow.com/questions/13125825/zsh-update-prompt-with-current-time-when-a-command-is-started
  second_line="> "
  composed="$first_line${NEWLINE}$second_line"
  echo "$composed"
}

PROMPT='$(serenity_prompt)'
