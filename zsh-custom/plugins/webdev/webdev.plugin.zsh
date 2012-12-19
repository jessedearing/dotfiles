function u() {
  if [[ -z $1 ]]; then
    UNICORN_PORT=3000;
  else
    UNICORN_PORT=$1;
  fi

  \unicorn -l 127.0.0.1:$UNICORN_PORT -E development -c /usr/local/etc/unicorn.rb;
}

function bbu() {
  if [[ -z $1 ]]; then
    UNICORN_PORT=3000;
  else
    UNICORN_PORT=$1;
  fi
  bundle exec unicorn -E development -c /usr/local/etc/unicorn.rb -l 127.0.0.1:$UNICORN_PORT
}

function ur() {
  if [[ -z $1 ]]; then
    UNICORN_PORT=3000;
  else
    UNICORN_PORT=$1;
  fi
  \unicorn_rails -E development -l 127.0.0.1:$UNICORN_PORT
}

function bbur() {
  if [[ -z $1 ]]; then
    UNICORN_PORT=3000;
  else
    UNICORN_PORT=$1;
  fi
  bundle exec unicorn_rails -E development -c /usr/local/etc/unicorn.rb -l 127.0.0.1:$UNICORN_PORT
}

function varn() {
  if [[ $1 = "start" ]]; then
    sudo varnishd -f /usr/local/etc/varnish/default.vcl -s malloc,1G -a 0.0.0.0:8080
  else
    sudo killall varnishd
  fi
}

function last_migration() {
  local rails_dir=$PWD
  while [ $rails_dir != "/" ]; do
    [ -f "$rails_dir/config/boot.rb" ] && break
    rails_dir="$(dirname $rails_dir)"
  done
  [ $rails_dir = "/" ] && echo "Rails project not found" && return
  vim $rails_dir/db/migrate/${$(ls -1t $rails_dir/db/migrate)[1]}
}
