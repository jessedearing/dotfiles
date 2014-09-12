function b2init {
  boot2docker --disksize=60000 --memory=$(echo $(sysctl -n hw.memsize)/1024/1024\*0.66/1 | bc) init
}
