#!/bin/sh

echo file loadSQL.sh is included

loadSQL() {
    for path in $(dirname "$0")/sql/*
    do
        echo "Path: " $path # path to "script dir/includes/script", from user view
	file="$(basename "$path")" # file name without path
        echo "File: " $file # file name script in subdir without path
	echo "inc Path: " ./sql/$file # Inc file, from script veiw
        echo "Query: "${file%.sql} # file name without extension=query name
        current_file=`cat "${path}"`
        #echo $current_file > ddd.sql
        eval "${file%.sql}"='$current_file'  # carefully escape the right-hand side!
    done
    
}




