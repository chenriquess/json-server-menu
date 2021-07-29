#!/bin/bash

number=1
root=("/c/workspace/json-server-databases"/*)
dir=("${root[@]}")
parentdir="$(dirname "$dir")"

NC='\033[0m'
GREEN='\033[0;32m'

is_file() {
	if [[ -d $path ]]; then
		menu
	elif [[ -f $path ]]; then
		json-server --watch "$path"
	else
		echo "$path is not valid"
		exit 1
	fi
}

menu() {
	printf "Paths:\n"
	
	OIFS="$IFS"
	IFS=$'\n'
	
	for entry in ${dir[@]}
	do
		name=$(basename $entry)
		
		if [[ -f $entry ]] && [[ $entry == *.json ]]; then
			printf "%s) ${GREEN}%s${NC}\n" "$number" "$name"
		else
			printf "%s) %s\n" "$number" "$name"
		fi
		((number++))
	done
	
	IFS="$OIFS"
	
	if [ $dir != $root ]; then
		printf "%s) <- Back\n" "$number"
	fi
	
	
	printf "\nPlease enter your choice: "
	
	IFS= read -r opt
	((opt--))
	
	
	
	if [[ $opt = $(($number - 1)) ]]; then
		path=$parentdir
		dir=(${parentdir}/*)
	else
		path=${dir[opt]}
		dir=(${path}/*)
	fi
		
	printf "\n\n"
	number=1
	is_file
}

printf "\n"
menu