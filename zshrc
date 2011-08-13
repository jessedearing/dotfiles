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
plugins=(git ruby memdisk rails3)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

export GIT_EDITOR="mvim --nofork "
export PGDATA=/usr/local/var/postgresql
alias vim="mvim"
alias sgem="sudo gem"
alias ruby18="rvm use ruby-1.8.7-p174"
alias web="open -a 'Google Chrome' "
alias nginx="sudo /usr/local/sbin/nginx"
function u() {\unicorn -l $(pwd)/tmp/sockets/unicorn.sock}
function ur() {\unicorn_rails -l $(pwd)/tmp/sockets/unicorn.sock}
function api() {open -a 'Google Chrome' "http://apidock.com/$1/search?query=$2";}
alias be="bundle exec"
alias bi="bundle install"
alias bl="bundle list"
alias bu="bundle update"
alias bp="bundle package"

export EC2_PRIVATE_KEY="/usr/local/aws/ec2-api-tools-1.4.3.0/pk"
export EC2_CERT="/usr/local/aws/ec2-api-tools-1.4.3.0/cert"
export EC2_HOME="/usr/local/aws/ec2-api-tools-1.4.3.0"
export JAVA_HOME="/Library/Java/Home"

export NODE_PATH=/usr/local/lib/node
