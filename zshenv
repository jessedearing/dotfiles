export PATH=$HOME/.fzf/bin:${KREW_ROOT:-$HOME/.krew}/bin:$HOME/.yarn/bin:$HOME/.cargo/bin:$HOME/go/bin:.bundle/bin:$HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/.bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/opt/perl/bin
export EDITOR=$HOME/.bin/editor.sh
if [[ $(uname -s) == "Darwin" ]]; then
  export RVC_READLINE="/usr/local/opt/readline/lib/libreadline.dylib"
fi
export GOPATH=$HOME/go
unset GOROOT
export GOPRIVATE=*.vmware.com
export GO111MODULE=on
export PGDATA=$HOME/data/postgres
export PGHOST=localhost

export ZSH_DISABLE_COMPFIX=true

###############
#  Databases  #
###############

export PGUSER=postgres


export ETCDCTL_API=3
export VAULT_ADDR='http://127.0.0.1:8200'

#########
#  fzf  #
#########
export FZF_DEFAULT_COMMAND=$'rg --files --no-ignore --hidden --follow -g \'\!\.git/*\' -g \'\!node_modules/*\' -g \'\!vendor/*\' 2> /dev/null'
#export FZF_DEFAULT_OPTS="--color fg:#D8DEE9,bg:#2E3440,hl:#A3BE8C,fg+:#D8DEE9,bg+:#434C5E,hl+:#A3BE8C --color pointer:#BF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B"
export FZF_DEFAULT_OPTS='--color=dark --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7'

###########
#  pyenv  #
###########
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH

export PATH="$HOME/.pyenv/shims:${PATH}"
export PYENV_SHELL=zsh

#########
#  bat  #
#########
export BAT_THEME=Dracula

export TERMINAL=alacritty
