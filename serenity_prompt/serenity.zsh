NEWLINE=$'\n'

first_line='%n@%m:%c'
second_line='> '
composed='$first_line${NEWLINE}$second_line'

PROMPT=$composed

function get_git_status() {
  local INDEX
  local git_status=''

  INDEX=$(command git status --porcelain -b 2> /dev/null)

  if $(echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null); then
    git_status="%F{green}"
  fi

  return git_status
}

function serenity_prompt() {
  local first_line second_line composed
  first_line='%n@%m:%c'
  second_line='> '
  composed='$first_line ${NEWLINE} $second_line'
  return $first_line
}

#PROMPT='$(serenity_prompt)'
