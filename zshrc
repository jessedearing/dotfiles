setopt interactivecomments
# Path to your oh-my-zsh configuration.
export DISABLE_AUTO_UPDATE=true
export ZSH=$HOME/.oh-my-zsh
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

__USR_PATH="/usr"
if [[ $(uname -s) == "Darwin" ]]; then
  __USR_PATH="/usr/local"
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
plugins=(vi-mode zsh-syntax-highlighting docker zsh-aws-vault)
fpath=(~/.zsh-completions $fpath)
source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"

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

if [ -x $__USR_PATH/bin/exa ]; then
	alias ls=exa
fi

alias rg="rg -i -g \"!{vendor}\""

if [ -x /usr/bin/bat ]; then
  export BAT_THEME=Nord
  alias cat=bat
fi

export LESS="-iMx4 -RX"
export LESS_TERMCAP_so=$'\E[30;43m'
export LESS_TERMCAP_se=$'\E[39;49m'
export GIT_EDITOR=$EDITOR
export BROWSER=$HOME/.bin/browser.sh

function quote() {
  echo "“$*”" | pbcopy
}

if [ -x /usr/libexec/java_home ]; then
  export JAVA_HOME="$(/usr/libexec/java_home)"
fi

export NODE_PATH=$__USR_PATH/lib/node

export KEYTIMEOUT=5

function bail_on_tmux() {
  echo "Loading tmux...."
  echo "Press CTRL-C to cancel"
  sleep 1.5
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function load_tmux() {
  if (which tmux 2>&1 > /dev/null); then
    if [ -z "$TMUX" ] && ( tmux ls 2>&1 ); then
      eval "$(ssh-agent)"
      ssh-add $HOME/.ssh/id_rsa &> /dev/null
      ssh-add -qK $HOME/.ssh/id_ed25519 &> /dev/null &!
      ssh-add -qK $HOME/.ssh/vmware-ed25519 &> /dev/null &!
      bail_on_tmux && tmux attach -t 0 && exit
    else
      if [ -z "$TMUX" ] && [ -z "$SUDO_USER" ] && [ -z "$SSH_CONNECTION" ]; then
        eval "$(ssh-agent)"
        ssh-add $HOME/.ssh/id_rsa &> /dev/null
        ssh-add -qK $HOME/.ssh/id_ed25519 &> /dev/null &!
        ssh-add -qK $HOME/.ssh/vmware-ed25519 &> /dev/null &!
        bail_on_tmux && tmux && exit
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

function jstags() {
	find . -type f -iregex ".*\.js$" -not -path "./node_modules/*" -exec jsctags {} -f \; | sed '/^$/d' | sort > tags
}

# History searching
bindkey -M vicmd '/' fzf-history-widget
bindkey -M vicmd '?' history-incremental-pattern-search-forward
bindkey -M isearch '^R' history-incremental-search-backward
bindkey -M isearch '^F' history-incremental-search-forward

fortune startrek computers $HOME/.fortunes/sadserver_tweets $HOME/.fortunes/honest_update_tweets
echo

export EC2_HOME=/usr/local/opt/ec2-api-tools/libexec

stty discard undef


TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'

autoload bashcompinit
bashcompinit
source $HOME/.bin/gh_complete.sh

ulimit -S -n 2048

load_tmux

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if [ -f /usr/local/etc/grc.zsh ]; then
  . /usr/local/etc/grc.zsh
fi
if [ -f /etc/grc.zsh ]; then
  . /etc/grc.zsh
fi
if [ -f $__USR_PATH/opt/pyenv/libexec/../completions/pyenv.zsh ]; then
  source "$__USR_PATH/opt/pyenv/libexec/../completions/pyenv.zsh"
fi

command pyenv rehash 2>/dev/null
pyenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(pyenv "sh-$command" "$@")";;
  *)
    command pyenv "$command" "$@";;
  esac
}

if [ -f $__USR_PATH/bin/aws_zsh_completer.sh ]; then
  . $__USR_PATH/bin/aws_zsh_completer.sh
fi
