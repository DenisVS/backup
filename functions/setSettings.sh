#!/bin/sh
echo file setSettings.sh is included
setSettings() {
    my_dir="$(dirname "$0")"
    configfile="$my_dir/settings.conf"
    while read config_string
    do
    if echo "$config_string" | grep -q '^[A-Za-z0-9]'; then
		#echo "config_string: " $config_string
        config_string="${config_string%%\#*}"    # Del in line right comments
		config_string="${config_string%%*( )}"   # Del trailing spaces
        #echo "config_string : " $config_string
		lhs=`echo $config_string | awk -F\= '{print $1}'`
        rhs=`echo $config_string | awk -F\= '{print $2}'`
        rhs="${rhs%%*( )}"   # Del trailing spaces
		rhs="${rhs%\"*}"     # Del opening string quotes 
        rhs="${rhs#\"*}"     # Del closing string quotes
        #echo $lhs, $rhs
        eval "$lhs"='$rhs'  # carefully escape the right-hand side!
    fi
    done < $configfile

}




