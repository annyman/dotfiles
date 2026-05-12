#!/usr/bin/env bash

alpha=0
if pgrep -x dimland > /dev/null; then
    alpha=$(ps -C dimland -o args= | grep -oP '(?<=-a )\d+(\.\d+)?' | head -n 1)
    [ -z "$alpha" ] && alpha=0.5
fi

if [ "$1" == "up" ]; then
    alpha=$(awk -v a="$alpha" 'BEGIN { n = a + 0.05; if(n>1.0) n=1.0; printf "%.2f", n }')
    pkill dimland
    dimland -a $alpha & disown
elif [ "$1" == "down" ]; then
    alpha=$(awk -v a="$alpha" 'BEGIN { n = a - 0.05; if(n<0.0) n=0.0; printf "%.2f", n }')
    pkill dimland
    # only restart dimland if alpha is greater than 0
    if awk -v a="$alpha" 'BEGIN { exit !(a > 0) }'; then
        dimland -a $alpha & disown
    fi
fi

pct=$(awk -v a="$alpha" 'BEGIN {print int(a * 100)}')
echo "{\"text\": \"$pct%\", \"percentage\": $pct}"
