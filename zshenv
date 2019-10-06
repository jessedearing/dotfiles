export PATH=${KREW_ROOT:-$HOME/.krew}/bin:/usr/local/opt/make/libexec/gnubin:$HOME/.cargo/bin:$HOME/go/bin:/usr/local/heroku/bin:.bundle/bin:$HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/.bin:/usr/local/opt/curl/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/opt/perl/bin

export EDITOR=$HOME/.bin/editor.sh
if [[ $(uname -s) == "Darwin" ]]; then
  export RVC_READLINE="/usr/local/Cellar/readline/6.2.4/lib/libreadline.6.dylib"
fi
export GOPATH=$HOME/go
unset GOROOT
export GOPRIVATE=*.vmware.com
export GO111MODULE=on
export PGDATA=$HOME/data/postgres
export PGHOST=localhost

###############
#  Databases  #
###############

export PGUSER=postgres


export ETCDCTL_API=3
export VAULT_ADDR='http://127.0.0.1:8200'
