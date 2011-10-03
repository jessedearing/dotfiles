# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="dallas"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git ruby memdisk rails3 shorten bundler)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

export GIT_EDITOR="mvim --nofork "
export EDITOR="mvim -v"
export PGDATA=/usr/local/var/postgresql
alias vi="mvim -v"
alias sgem="sudo gem"
alias ruby18="rvm use ruby-1.8.7-p174"
alias web="open -a 'Google Chrome' "
alias nginx="sudo /usr/local/sbin/nginx"
# \unicorn -l $(pwd)/tmp/sockets/unicorn.sock -c /usr/local/etc/unicorn.rb
function u() {
  \unicorn -l 127.0.0.1:3000 -E development -c /usr/local/etc/unicorn.rb
}
function bu() {bundle exec unicorn -E development -l 127.0.0.1:3000}
function ur() {\unicorn_rails -E development -l 127.0.0.1:3000}
function bur() {bundle exec unicorn_rails -E development -l 127.0.0.1:3000}
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

export NODE_PATH=/usr/local/lib/node

# Use vim bindings in zsh
bindkey -v
