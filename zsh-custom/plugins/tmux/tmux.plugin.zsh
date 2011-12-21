[[ $TERM == "screen" ]] && return
[[ $- != *i* ]] && return
tmux_sock=0
while [[ -a "/tmp/tmux.$tmux_sock" ]] do
  tmux_sock=$[$tmux_sock + 1]
done
export CURRENT_TMUX_SOCKET="/tmp/tmux.$tmux_sock"
tmux -S $CURRENT_TMUX_SOCKET && rm $CURRENT_TMUX_SOCKET && exit
