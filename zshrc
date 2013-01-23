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
plugins=(git brew cloudapp vi-mode webdev)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/heroku/bin:$HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/.bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin

source "/Users/jdearing/.rbenv/libexec/../completions/rbenv.zsh"
rbenv rehash 2>/dev/null
rbenv() {
  local command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  shell)
    eval `rbenv "sh-$command" "$@"`;;
  *)
    command rbenv "$command" "$@";;
  esac
}

export PGDATA=/usr/local/var/postgresql
if (which mvim 2>&1 > /dev/null); then
  alias vim="mvim -v"
fi
alias lpup="librarian-puppet"
alias puppet="nocorrect puppet"
alias vi="vim"
alias sgem="sudo gem"
alias ruby18="rvm use ruby-1.8.7-p174"
alias web="open -a 'Google Chrome' "
alias nginx="sudo /usr/local/sbin/nginx"
alias g='nocorrect git'
alias gco='git checkout'
alias gl="git log --stat --graph --decorate"
alias gs="git status -sb"
alias ghost="sudo rvm 1.9.3 do ghost"
alias knife="rvm 1.9.3 do knife"
alias be="bundle exec"
alias bi="bundle install"
alias bl="bundle list"
alias bu="bundle update"
alias bp="bundle package"
alias lol="rvm 1.8.7 do lolspeak"
alias mongod="mongod -f /usr/local/Cellar/mongodb/1.8.3-x86_64/mongod.conf"
alias cheat="rvm 1.9.3 do cheat"
alias less="less -R"
alias v=vagrant
alias knife="nocorrect knife"

export EDITOR="vim -f"
export GIT_EDITOR=$EDITOR

function api() {open -a 'Google Chrome' "http://apidock.com/$1/search?query=$2";}

function quote() {
  echo "“$*”" | pbcopy
}

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

function disconnectwifi() {
  sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -z
}

function historygrep() {
  history | grep $1
}

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
[ -z "$TMUX" ] && [ -z "$SUDO_USER" ] && (which tmux 2>&1 > /dev/null) && tmux && exit
