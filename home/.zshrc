# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

source ~/.secrets

# User configuration

source /usr/local/opt/chruby/share/chruby/chruby.sh
#source /usr/local/opt/chruby/share/chruby/auto.sh
chruby ruby

# Rust
source $HOME/.cargo/env
#export PATH="$PATH:/Users/sean/.rvm/gems/ruby-2.1.1/bin:/Users/sean/.rvm/gems/ruby-2.1.1@global/bin:/Users/sean/.rvm/rubies/ruby-2.1.1/bin:/Users/sean/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/Users/sean/.rvm/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
#alias zshconfig="`$EDITOR` ~/.zshrc" # A PROBLEM
alias zshsource="source ~/.zshrc"
alias dm="docker-machine"
alias fig="docker-compose"
alias swp='find . -iname "*.sw*"'
#alias vim-git="vim -O $(git status -s | sed "s/??/ ?/g" | cut -d " " -f 3 | xargs)"
#alias vim-swp="vim -O $(swp | sed s/\.swp// | sed 's/^.\///' | sed 's/\/./\//' | xargs)"
alias tail-log="tail -f log/development.log"

# Docker Machine
function setDockerEnv() {
  docker_machine_default=dinghy
  docker_machine_status=$(docker-machine status $docker_machine_default)
  if [[ "$docker_machine_status" == "Running" ]]
  then
    eval "$(docker-machine env $docker_machine_default)"
  fi
}

function jobscount() {
  local stopped=$(jobs -sp | wc -l)
  local running=$(jobs -rp | wc -l)
  ((running+stopped)) && echo -n "${running}r/${stopped}s "
}

setDockerEnv

export LESS="${LESS} -S"
export EDITOR=vim
export GOPATH=$HOME/code/go
export PATH="$PATH:$GOPATH/bin"
export PATH="/usr/local/sbin:$PATH" # homebrew sbin

source ~/.secrets

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

# MOTD
fortune | cowsay | lolcat
