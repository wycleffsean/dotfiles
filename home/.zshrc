# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

source ~/.secrets

# source all zsh config from ~/.zsh/after
for f in ~/.zsh/after/*.zsh; do source $f; done

# User configuration

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

function jobscount() {
  local stopped=$(jobs -sp | wc -l)
  local running=$(jobs -rp | wc -l)
  ((running+stopped)) && echo -n "${running}r/${stopped}s "
}

export LESS="${LESS} -S"
export EDITOR=vim
export BUNDLER_EDITOR=vim
export PATH="/usr/local/sbin:$PATH" # homebrew sbin
export PATH="/usr/local/opt/llvm@4/bin:$PATH" # https://github.com/oracle/truffleruby/blob/master/doc/user/installing-llvm.md

#function jt { ruby /Users/sean/code/github.com/graalvm/truffleruby/tool/jt.rb "$@"; }
function jt { ruby /Users/sean/code/github.com/oracle/truffleruby/tool/jt.rb "$@"; }

unalias rb
export PATH="$HOME/.bin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"
