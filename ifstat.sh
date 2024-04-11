#!/bin/bash

IFACE=eth0
COUNT=30
DELAY=1
FNAME="iface_stats.csv"

# get iface stats and translate it to CSV formatted row
read_iface_stats() {
	local iface=$1
	local orig_ifs=$IFS
	IFS=$'\n'
	local rawstr=($(ip -s link show dev $iface))
	IFS=$' '
	local stats=(${rawstr[3]} ${rawstr[5]})
	IFS=$orig_ifs
	local stats=$(echo "${stats[@]}")
	echo "${stats// /,}"
}

# wrote CSV file header
echo "timestamp,iface,rx_pkts,rx_bytes,rx_errors,rx_dropped,rx_missed,rx_mcast,tx_pkts,tx_bytes,tx_errors,tx_dropped,tx_carrier,tx_collsns" > $FNAME

source ./progressbar.sh

# do $COUNT iterations
for i in $(seq $COUNT); do
	timestamp=$(date +%s%N | cut -b1-13)
	echo "$timestamp,$IFACE,$(read_iface_stats $IFACE)" >> $FNAME
	show_progress $i $COUNT
	sleep $DELAY
done
