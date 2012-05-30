[[ $TERM == "screen-256color" ]] && return
tmux_sock=0
while [[ -a "/tmp/tmux.$tmux_sock" ]] do
  tmux_sock=$[$tmux_sock + 1]
done
export CURRENT_TMUX_SOCKET="/tmp/tmux.$tmux_sock"
tmux -S $CURRENT_TMUX_SOCKET && rm $CURRENT_TMUX_SOCKET && echo "Closing in 2 seconds..." && sleep 2 && exit
