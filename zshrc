# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME=""
export ZSH_CUSTOM="$HOME/.zsh-custom"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git rvm vi-mode)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$HOME/.bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

export PGDATA=/usr/local/var/postgresql
alias vi="vim"
alias sgem="sudo gem"
alias ruby18="rvm use ruby-1.8.7-p174"
alias web="open -a 'Google Chrome' "
alias nginx="sudo /usr/local/sbin/nginx"
alias g='nocorrect git'
alias gl="git log --stat --graph --decorate"
alias gs="git status"

# To MacVim or Vim?
if [[ -x /usr/local/bin/mvim ]]; then
  if [[ $TERM = "screen" || $TERM = "screen-256color" ]]; then
    VIM='/usr/local/bin/mvim'
    VIMFLAGS='-v'
  else
    VIM='/usr/local/bin/mvim'
  fi
else
  VIM="vim"
fi
export GIT_EDITOR=$VIM" "$VIMFLAGS" -f"
export EDITOR=$VIM" "$VIMFLAGS" -f"

function vim() {
  (unset GEM_HOME GEM_PATH; =$VIM $VIMFLAGS $*)
}

function u() {
  if [[ -z $1 ]]; then
    UNICORN_PORT=3000;
  else
    UNICORN_PORT=$1;
  fi

  \unicorn -l 127.0.0.1:$UNICORN_PORT -E development -c /usr/local/etc/unicorn.rb;
}

function bbu() {
  if [[ -z $1 ]]; then
    UNICORN_PORT=3000;
  else
    UNICORN_PORT=$1;
  fi
  bundle exec unicorn -E development -c /usr/local/etc/unicorn.rb -l 127.0.0.1:$UNICORN_PORT
}

function ur() {
  if [[ -z $1 ]]; then
    UNICORN_PORT=3000;
  else
    UNICORN_PORT=$1;
  fi
  \unicorn_rails -E development -l 127.0.0.1:$UNICORN_PORT
}

function bbur() {
  if [[ -z $1 ]]; then
    UNICORN_PORT=3000;
  else
    UNICORN_PORT=$1;
  fi
  bundle exec unicorn_rails -E development -c /usr/local/etc/unicorn.rb -l 127.0.0.1:$UNICORN_PORT
}

function api() {open -a 'Google Chrome' "http://apidock.com/$1/search?query=$2";}
function varn() {
  if [[ $1 = "start" ]]; then
    sudo varnishd -f /usr/local/etc/varnish/default.vcl -s malloc,1G -a 0.0.0.0:8080
  else
    sudo killall varnishd
  fi
}

alias be="bundle exec"
alias bi="bundle install"
alias bl="bundle list"
alias bu="bundle update"
alias bp="bundle package"

alias mongod="mongod -f /usr/local/Cellar/mongodb/1.8.3-x86_64/mongod.conf"

export EC2_PRIVATE_KEY="/usr/local/aws/ec2-api-tools-1.4.3.0/pk"
export EC2_CERT="/usr/local/aws/ec2-api-tools-1.4.3.0/cert"
export EC2_HOME="/usr/local/aws/ec2-api-tools-1.4.3.0"
export JAVA_HOME="/Library/Java/Home"

export ARCHFLAGS='-arch x86_64'

export NODE_PATH=/usr/local/lib/node

export GIT_COMMITTER_NAME="Jesse Dearing"
export GIT_COMMITTER_EMAIL="jesse.dearing@gmail.com"

export KEYTIMEOUT=5

# Add the following to your ~/.bashrc or ~/.zshrc
hitch() {
  command hitch "$@"
  if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
}
alias unhitch='hitch -u'
# Uncomment to persist pair info between terminal instances
# hitch


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
