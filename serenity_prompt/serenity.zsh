NEWLINE=$'\n'

function get_git_status() {
  local INDEX
  local git_status=''

  INDEX=$(command git status --porcelain -b 2> /dev/null)

  if $(echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null); then
    git_status="%F{green} OK"
  fi

  echo git_status
}

function serenity_prompt() {
  local first_line second_line composed

  first_line="%F{white}%n at %m in %F{red}%~%F{white}"
  # https://stackoverflow.com/questions/13125825/zsh-update-prompt-with-current-time-when-a-command-is-started
  second_line="%T > "
  composed="$first_line$git_status${NEWLINE}$second_line"
  echo $composed
}

PROMPT='$(serenity_prompt)'
