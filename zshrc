setopt interactivecomments
# Path to your oh-my-zsh configuration.
export DISABLE_AUTO_UPDATE=true
export ZSH=$HOME/.oh-my-zsh
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="agnoster"
export ZSH_CUSTOM="$HOME/.zsh-custom"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(vi-mode zsh-syntax-highlighting golang docker)

# Have to set GIT environment variables so they can be overridden by anything
# in zsh-custom
export GIT_AUTHOR_NAME="Jesse Dearing"
export GIT_AUTHOR_EMAIL="jesse.dearing@gmail.com"
export GIT_COMMITTER_NAME=$GIT_AUTHOR_NAME
export GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL

source $ZSH/oh-my-zsh.sh

fpath=(/usr/local/share/zsh-completions $fpath)
source /usr/local/share/zsh/site-functions/_*

# Customize to your needs...
export PATH=$HOME/go/bin:/usr/local/heroku/bin:.bundle/bin:$HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/.bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/Cellar/go/1.2/libexec/bin:/usr/local/opt/perl/bin

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

#export RBENV_VERSION=2.0.0-p451

alias vim=nvim
export PGDATA=/usr/local/var/postgresql
alias lpup="librarian-puppet"
alias puppet="nocorrect puppet"
alias vi="vim"
alias sgem="sudo gem"
alias ruby18="rvm use ruby-1.8.7-p174"
alias irb=pry
alias web="open -a 'Google Chrome' "
alias g='nocorrect git'
alias git=hub
alias gco='git checkout'
alias gl="git log --stat --graph --decorate -M"
alias gs="git status -sb"
alias ga="git add"
alias gc="git commit -v"
alias be="bundle exec"
alias bi="bundle install --path=.bundle --binstubs=.bundle/bin"
alias bl="bundle list"
alias bu="bundle update"
alias bp="bundle package"
alias lol="rvm 1.8.7 do lolspeak"
alias mongod="mongod --config /usr/local/etc/mongod.conf"
alias less="less -R"
alias v=vagrant
alias d=docker
alias knife="nocorrect knife"
alias ggpnp='git stash && git pull --rebase && git push && git stash pop'
alias yard='nocorrect yard'
alias ssh="TERM=xterm-256color ssh -A"
alias ag="ag -S"
alias vims="vim -c ':Scratch'"
alias mytop="perl /usr/local/bin/mytop"
alias cat=ccat

export EDITOR=$HOME/.bin/editor.sh
export LESS="-iMx4 -RX"
export GIT_EDITOR=$EDITOR

function api() {open -a 'Google Chrome' "http://apidock.com/$1/search?query=$2";}

function quote() {
  echo "“$*”" | pbcopy
}

export JAVA_HOME="$(/usr/libexec/java_home)"
if [ -d "$HOME/.ec2" ]; then
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

function histag() {
  history | ag "$1" | tail
}

function bail_on_tmux() {
  echo "Loading tmux...."
  echo "Press CTRL-C to cancel"
  sleep 1.5
}

function load_tmux() {
  if (which tmux 2>&1 > /dev/null); then
    if [ -z "$TMUX" ] && ( tmux ls 2>&1 ); then
     bail_on_tmux && tmux attach -t 0 && exit
    else
      if [ -z "$TMUX" ] && [ -z "$SUDO_USER" ] && [ -z "$SSH_CONNECTION" ]; then
        bail_on_tmux && ssh-agent tmux -2 && exit
      fi
    fi
  fi
}
if [[ $(uname -s) == "Darwin" ]]; then
  export RVC_READLINE="/usr/local/Cellar/readline/6.2.4/lib/libreadline.6.dylib"
fi

function printcolors() {
  for i in {0..255} ; do
    printf "\\x1b[38;5;${i}m \\\x1b[38;5;${i}m\n"
  done
}

function b2ip() {
  local ip=$(boot2docker ip)
  echo $ip | pbcopy
  echo $ip
}

eval "$(thefuck --alias)"

function sshforward() {
  eval "$(ssh-agent)"
  ssh-add
}

# Boot2Docker
# ============================================================================
alias b2=boot2docker
alias dl="docker ps -ql"
alias eclimd=/Users/jdearing/eclipse/Eclipse.app/Contents/Eclipse/eclimd
alias eclim=/Users/jdearing/eclipse/Eclipse.app/Contents/Eclipse/eclim
# export VAGRANT_DEFAULT_PROVIDER=vmware_fusion
export VAGRANT_DEFAULT_PROVIDER=virtualbox
export GOPATH=$HOME/go

# History searching
bindkey -M vicmd '/' fzf-history-widget
bindkey -M vicmd '?' history-incremental-pattern-search-forward
bindkey -M isearch '^R' history-incremental-search-backward
bindkey -M isearch '^F' history-incremental-search-forward

#ssh-add $HOME/.ssh/id_rsa &> /dev/null

fortune startrek computers $HOME/.fortunes/sadserver_tweets $HOME/.fortunes/honest_update_tweets
echo

export PGDATA=$HOME/data/postgres
export PGHOST=localhost

# Python Setup
# ============================================================================
VIRTUAL_ENV_DISABLE_PROMPT=1
#. $HOME/.virtualenv/bin/activate

# NOOPing virtualenv because I just don't use python that much
prompt_virtualenv() {}
export EC2_HOME=/usr/local/opt/ec2-api-tools/libexec

load_tmux
# JBoss Setup
# ============================================================================
export JBOSS_HOME=/usr/local/opt/wildfly-as/libexec
export PATH=${PATH}:${JBOSS_HOME}/bin
export GROOVY_HOME=/usr/local/opt/groovy/libexec
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8

export LIQUIBASE_HOME=/usr/local/opt/liquibase/libexec

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"


TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'

autoload bashcompinit
bashcompinit
source $HOME/.bin/gh_complete.sh
source <(kubectl completion zsh)

ulimit -S -n 2048

source /Users/jesse/code/InVisionApp/InVision_Docker/scripts-native/invision.sh

#if minikube status | grep "minikubeVM: Running" &> /dev/null; then
  #eval `minikube docker-env`
#fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
