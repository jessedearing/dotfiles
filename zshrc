# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="agnoster"
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

# Have to set GIT environment variables so they can be overridden by anything
# in zsh-custom
export GIT_AUTHOR_NAME="Jesse Dearing"
export GIT_AUTHOR_EMAIL="jesse.dearing@gmail.com"
export GIT_COMMITTER_NAME=$GIT_AUTHOR_NAME
export GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/heroku/bin:.bundle/bin:$HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/.bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/Cellar/go/1.2/libexec/bin

if [ -f $HOME/.rbenv/libexec/../completions/rbenv.zsh ]; then
  source "$HOME/.rbenv/libexec/../completions/rbenv.zsh"
fi

if ( which rbenv 2>&1 > /dev/null ); then
  rbenv rehash 2>/dev/null
  rbenv() {
    typeset command
    command="$1"
    if [ "$#" -gt 0  ]; then
      shift
    fi

    case "$command" in
    rehash|shell)
      eval "`rbenv "sh-$command" "$@"`";;
    *)
      command rbenv "$command" "$@";;
    esac
  }
fi

export PGDATA=/usr/local/var/postgresql
if (which mvim 2>&1 > /dev/null); then
  alias vim="mvim -v"
fi
alias lpup="librarian-puppet"
alias puppet="nocorrect puppet"
alias vi="vim"
alias sgem="sudo gem"
alias ruby18="rvm use ruby-1.8.7-p174"
alias irb=pry
alias web="open -a 'Google Chrome' "
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
alias less="less -R"
alias v=vagrant
alias knife="nocorrect knife"
alias ggpnp='git stash && git pull --rebase && git push && git stash pop'
alias yard='nocorrect yard'
compdef ggpnp=git

export EDITOR="vim"
export GIT_EDITOR=$EDITOR

function api() {open -a 'Google Chrome' "http://apidock.com/$1/search?query=$2";}

function quote() {
  echo "“$*”" | pbcopy
}

if [ -d "$HOME/.ec2" ]; then
  export JAVA_HOME="$(/usr/libexec/java_home)"
  export EC2_PRIVATE_KEY="$(/bin/ls "$HOME"/.ec2/pk-*.pem | /usr/bin/head -1)"
  export EC2_CERT="$(/bin/ls "$HOME"/.ec2/cert-*.pem | /usr/bin/head -1)"
  export EC2_AMITOOL_HOME="/usr/local/Library/LinkedKegs/ec2-ami-tools/jars"
fi

export ARCHFLAGS='-arch x86_64'

export NODE_PATH=/usr/local/lib/node

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

function hisgrep() {
  history | grep $1
}

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

function load_tmux() {
  if (which tmux 2>&1 > /dev/null); then
    if [ -z "$TMUX" ] && ( tmux ls 2>&1 ); then
      tmux new-session -t 0 && exit
    else
      [ -z "$TMUX" ] && [ -z "$SUDO_USER" ] && [ -z "$SSH_CONNECTION" ] && tmux && exit
    fi
  fi
}
if [[ $(uname -s) == "Darwin" ]]; then
  export RVC_READLINE="/usr/local/Cellar/readline/6.2.4/lib/libreadline.6.dylib"
fi

function printcolors() {
  for i in {0..255} ; do
    printf "\x1b[38;5;${i}mcolour${i}\n"
  done
}

export VAGRANT_DEFAULT_PROVIDER=vmware_fusion
#load_tmux
