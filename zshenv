export PNPM_HOME="/Users/$USER/Library/pnpm"

export PATH=$PNPM_HOME:${KREW_ROOT:-$HOME/.krew}/bin:$HOME/.pyenv/bin:$HOME/.fzf/bin:$HOME/.yarn/bin:$HOME/go/bin:/opt/homebrew/opt/openjdk/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/opt/perl/bin:$PATH
export EDITOR=$HOME/.local/bin/editor.sh
if [[ $(uname -s) == "Darwin" ]]; then
  export RVC_READLINE="/usr/local/opt/readline/lib/libreadline.dylib"
fi
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
unset GOROOT
export GOPRIVATE=*.vmware.com
export GO111MODULE=on
export PGDATA=$HOME/data/postgres
export PGHOST=localhost
export CDPATH=~/.dotfiles/shell-bookmarks
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

export ZSH_DISABLE_COMPFIX=true

export KEYTIMEOUT=20
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters

export GPG_TTY=$(tty)


export VI_MODE_DISABLE_CLIPBOARD='true'

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

export TERMINAL=kitty
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"
export XCURSOR_THEME=Adwaita
export PAGER=bat

#############
# Homebrew #
#############
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
