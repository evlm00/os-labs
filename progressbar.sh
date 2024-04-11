#!/bin/bash

function show_progress {
	let _progress=(${1}*100/${2}*100)/100
	let _done=(${_progress}*4)/10
	let _left=40-$_done

	_done=$(printf "%${_done}s")
	_left=$(printf "%${_left}s")

	printf "\rProgress : [${_done// /#}${_left// /-}] ${_progress}%%"

	if [ "$1" == "$2" ] ; then
		printf '\nFinished!\n'
	fi
}
