test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

function iterm2_print_user_vars() {
  _jobs=$(jobs | wc -l)
  if [ $_jobs -gt 0 ]
  then
    iterm2_set_user_var 'jobs' $_jobs
  else
    iterm2_set_user_var 'jobs' ''
  fi
}
