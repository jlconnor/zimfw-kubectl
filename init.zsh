(( ${+commands[kubectl]} || ${+commands[asdf]} && ${+functions[_direnv_hook]} )) && () {

  local command=${commands[kubectl]:-"$(${commands[asdf]} which kubectl 2> /dev/null)"}
  [[ -z $command ]] && return 1

  local compfile=$1/functions/_kubectl
  if [[ ! -e $compfile || $compfile -ot $command ]]; then
    $command completion zsh >| $compfile
    print -u2 -PR "* Detected a new version 'kubectl'. Regenerated completions."
  fi
} ${0:h}
