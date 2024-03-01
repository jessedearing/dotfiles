setopt interactive_comments
setopt chase_links
# Path to your oh-my-zsh configuration.
export DISABLE_AUTO_UPDATE=true
export ZSH=$HOME/.oh-my-zsh
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

__USR_PATH="/usr"
if [[ $(uname -s) == "Darwin" ]]; then
  __USR_PATH="/opt/homebrew"
fi

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
#export ZSH_THEME="sorin"
export ZSH_CUSTOM="$HOME/.zsh-custom"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(vi-mode zsh-syntax-highlighting)
fpath=(~/.zsh-completions /opt/homebrew/share/zsh/site-functions $fpath)
source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"

alias node='NODE_NO_READLINE=1 rlwrap node'
alias tf=terraform
alias web="open -a 'Firefox' "
alias gco='g checkout'
alias gs="g status -sb"
alias ga="g add"
alias gc="g commit -v"
alias mongod="mongod --config /usr/local/etc/mongod.conf"
alias less="less -R"
alias d="grc --colour=auto docker"
alias k=kubectl
alias ggpnp='git stash && git pull --rebase && git push && git stash pop'
alias ssh="TERM=xterm-256color ssh"
alias ssha="TERM=xterm-256color ssh -A"
alias ag="ag -S"
alias vscr="v -c ':Scratch'"
alias mytop="perl /usr/local/bin/mytop"
alias g=git
#alias g="~/git"
#alias lab="~/lab"
if [ -x $__USR_PATH/bin/richgo ] || [ -x $HOME/go/bin/richgo ]; then
	alias go=richgo
fi
alias vim="editor.sh"

alias rg="rg -i -g \"!{vendor}\""

if [ -x $__USR_PATH/bin/bat ]; then
  alias cat=bat
fi

export LESS="-iMx4 -RX"
export LESS_TERMCAP_so=$'\E[30;43m'
export LESS_TERMCAP_se=$'\E[39;49m'
export GIT_EDITOR=$EDITOR

function quote() {
  echo "“$*”" | pbcopy
}

export NODE_PATH=$__USR_PATH/lib/node

export KEYTIMEOUT=5

function bail_on_tmux() {
  echo "Loading tmux...."
  echo "Press CTRL-C to cancel"
  sleep 1.5
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function load_tmux() {
  tmux_session="local"
  if [ ! -z "$SSH_CONNECTION" ]; then
    tmux_session="ssh"
  fi

  if (which tmux 2>&1 > /dev/null); then
    if [ -z "$TMUX" ] && ( tmux ls | grep "${tmux_session}:" &> /dev/null ); then
      bail_on_tmux && tmux attach -t $tmux_session && exit
    else
      if [ -z "$TMUX" ] && [ -z "$SUDO_USER" ]; then
        bail_on_tmux && tmux new-session -s $tmux_session && exit
      fi
    fi
  fi
}

function printcolors() {
  for i in {0..255} ; do
    printf "\\x1b[38;5;${i}m \\\x1b[38;5;${i}m\n"
    printf "\x1b[38;5;${i}mcolour${i}\x1b[0m\n"
  done
}

eval "$(thefuck --alias)"

function jstags() {
	find . -type f -iregex ".*\.js$" -not -path "./node_modules/*" -exec jsctags {} -f \; | sed '/^$/d' | sort > tags
}

# History searching
bindkey -M vicmd '/' fzf-history-widget
bindkey -M vicmd '?' history-incremental-pattern-search-forward
bindkey -M isearch '^R' history-incremental-search-backward
bindkey -M isearch '^F' history-incremental-search-forward

bindkey "^Q" push-input

fortune startrek computers $HOME/.fortunes/sadserver_tweets $HOME/.fortunes/honest_update_tweets
echo

stty discard undef


TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'

ulimit -S -n 2048

load_tmux

if [ -f /opt/homebrew/etc/grc.zsh ]; then
  . /opt/homebrew/etc/grc.zsh
elif [ -f /usr/local/etc/grc.zsh ]; then
  . /usr/local/etc/grc.zsh
elif [ -f /etc/grc.zsh ]; then
  . /etc/grc.zsh
fi

unalias kubectl &> /dev/null
unfunction kubectl &> /dev/null
kubectl() {
  if [[ "$1" == "node-shell" ]]; then
    $__USR_PATH/bin/kubectl "$@"
  elif [[ "$@" =~ '(^|\s)(attach|run|exec|logs|edit)\s' ]]; then
    $__USR_PATH/bin/kubectl "$@"
  else
    grc -e -s -c conf.kubectl -- $__USR_PATH/bin/kubectl "$@"
  fi
}

unalias dig &> /dev/null
unfunction dig &> /dev/null

func dig() {
  if [[ $# > 1 ]]; then
    grc -e -s -c conf.dig -- dig "$@"
    return
  fi
  hostname=$1
  shift
  grc -e -s -c conf.dig -- dig $hostname A $hostname AAAA "$@"
}

aws() {
  (
    if [[ "$@" =~ 'help$' ]]; then
      MANPAGER="sh -c 'col  -bx | bat -l man -p'" /usr/bin/env -u PAGER $__USR_PATH/bin/aws $@
    else
      $__USR_PATH/bin/aws $@
    fi
  )
}

# Alias ls after grc since lsd is colorized
if [ -x $__USR_PATH/bin/lsd ]; then
	alias ls=lsd
fi

if [ -f $__USR_PATH/opt/pyenv/libexec/../completions/pyenv.zsh ]; then
  source "$__USR_PATH/opt/pyenv/libexec/../completions/pyenv.zsh"
fi

if [ -f $__USR_PATH/bin/aws_zsh_completer.sh ]; then
  . $__USR_PATH/bin/aws_zsh_completer.sh
fi

if [ -f $__USR_PATH/share/nvm/init-nvm.sh ]; then
  source $__USR_PATH/share/nvm/init-nvm.sh
fi

autoload bashcompinit
bashcompinit
