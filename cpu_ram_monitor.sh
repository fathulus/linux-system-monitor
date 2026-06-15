#!/bin/bash

# System Monitor - monitors CPU and RAM usage

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RESET='\033[0m'

get_cpu() {
    CPU_PREV=$(grep '^cpu ' /proc/stat)
    sleep 1
    CPU_CUR=$(grep '^cpu ' /proc/stat)

    IDLE_PREV=$(echo "$CPU_PREV" | awk '{print $5}')
    IDLE_CUR=$(echo "$CPU_CUR" | awk '{print $5}')

    TOTAL_PREV=$(echo "$CPU_PREV" | awk '{print $2+$3+$4+$5+$6+$7+$8}')
    TOTAL_CUR=$(echo "$CPU_CUR" | awk '{print $2+$3+$4+$5+$6+$7+$8}')

    DIFF_IDLE=$((IDLE_CUR - IDLE_PREV))
    DIFF_TOTAL=$((TOTAL_CUR - TOTAL_PREV))

    CPU_PERCENT=$(( (DIFF_TOTAL - DIFF_IDLE) * 100 / DIFF_TOTAL ))
}
get_ram() {
    RAM_TOTAL=$(grep 'MemTotal' /proc/meminfo | awk '{print $2}')
    RAM_AVAIL=$(grep 'MemAvailable' /proc/meminfo | awk '{print $2}')

    RAM_USED=$((RAM_TOTAL - RAM_AVAIL))
    RAM_PERCENT=$((RAM_USED * 100 / RAM_TOTAL))
}
get_disk() {
	DISK_USED_PERCENT=$(df / | awk 'NR==2 {print $5}')
}
print_output() {
    clear
    echo -e "=============================="
    echo -e "       SYSTEM MONITOR"
    echo -e "=============================="

    if [ "$CPU_PERCENT" -ge 80 ]; then
        echo -e "  CPU Usage: ${RED}${CPU_PERCENT}% [HIGH]${RESET}"
    elif [ "$CPU_PERCENT" -ge 50 ]; then
        echo -e "  CPU Usage: ${YELLOW}${CPU_PERCENT}%${RESET}"
    else
        echo -e "  CPU Usage: ${GREEN}${CPU_PERCENT}%${RESET}"
    fi

    if [ "$RAM_PERCENT" -ge 80 ]; then
        echo -e "  RAM Usage: ${RED}${RAM_PERCENT}% [HIGH]${RESET}"
    elif [ "$RAM_PERCENT" -ge 50 ]; then
        echo -e "  RAM Usage: ${YELLOW}${RAM_PERCENT}%${RESET}"
    else
        echo -e "  RAM Usage: ${GREEN}${RAM_PERCENT}%${RESET}"
    fi
	echo -e " Disk Usage: ${GREEN}${DISK_USED_PERCENT}${RESET}"
    echo -e "=============================="
}
while true; do
	TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
	get_cpu
	get_ram
	get_disk
	print_output
	echo "[$TIMESTAMP] CPU=${CPU_PERCENT}% RAM=${RAM_PERCENT}% DISK=${DISK_USED_PERCENT}" >> ~/projects/logs/monitor.log
	sleep 5
done
