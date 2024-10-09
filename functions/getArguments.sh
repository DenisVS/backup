#!/bin/sh
echo file getArguments.sh is included
getArguments() {
	my_dir="$(dirname "$0")"
	options="$*"
	rest=$options
	while [ -n "$rest" ]; do
		str=$(echo ${rest} | awk -F ' -' 'OFS=" -"{ print $1}')
		# Trim up to the first ' -' -- and handle final case, too.
		rest=$(echo ${rest} | awk -F ' -' 'OFS=" -"{$1=""; print $0}') # Everything up to the first ';'
		argname=$(echo $str | awk '{print $1}' | cut -c 2-)
		argvalue=$(echo $str | awk '{$1="";print $0}' | awk '{$1=$1};1')
		if [ -z "$argvalue" ]; then
			argvalue=true
		fi
		argnamex=$(echo ARG_${argname})
		echo "$argnamex = $argvalue"
		eval "$argnamex"='$argvalue' # carefully escape the right-hand side!
	done

}
