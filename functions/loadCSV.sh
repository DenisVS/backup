#!/bin/sh

echo file loadCSV.sh is included
loadCSV() {
        path_to_file="$1"
        name_of_variable="$2"
        columns="$3"
        echo $name_of_variable
        csv_file=$(cat "$SCRIPTDIR/$path_to_file")
        i=0
        for STRING_CONTENT in $csv_file; do
                nn="$name_of_variable"_$i # row name without header
                if [ "$i" -gt 0 ]; then
                        ih=$(expr $i - 1)
                fi
                nh="$name_of_variable"_$ih   # row name with header
                eval "$nh"='$STRING_CONTENT' # carefully escape the right-hand side!

                if [ "$columns" = "head" ]; then
                        if [ "$i" = 0 ]; then
                                ii=1
                                rest=$STRING_CONTENT
                                while [ -n "$rest" ]; do
                                        str=$(echo ${rest} | awk -F '|' 'OFS="|"{ print $1}')
                                        # Trim up to the first '|' -- and handle final case, too.
                                        rest=$(echo ${rest} | awk -F '|' 'OFS="|"{$1=""; print $0}' | sed -r 's/^.{1}//') # Everything up to the first '|'
                                        nnn="header_$ii"
                                        eval "$nnn"='$str' # carefully escape the right-hand side!
                                        echo NNN $nnn
                                        get_value_of "header_"$ii
                                        ii=$(expr $ii + 1)
                                done
                        else
                                ii=1
                                rest=$STRING_CONTENT
                                while [ -n "$rest" ]; do
                                        str=$(echo ${rest} | awk -F '|' 'OFS="|"{ print $1}')
                                        # Trim up to the first '|' -- and handle final case, too.
                                        rest=$(echo ${rest} | awk -F '|' 'OFS="|"{$1=""; print $0}' | sed -r 's/^.{1}//') # Everything up to the first '|'
                                        current_column_name=$(get_value_of "header_"$ii)
                                        nnn="$nh"_$current_column_name
                                        eval "$nnn"='$str' # carefully escape the right-hand side!
                                        ii=$(expr $ii + 1)
                                done
                        fi
                else
                        eval "$nn"='$STRING_CONTENT' # carefully escape the right-hand side!
                        ii=1
                        rest=$STRING_CONTENT
                        while [ -n "$rest" ]; do
                                str=$(echo ${rest} | awk -F '|' 'OFS="|"{ print $1}')
                                # Trim up to the first '|' -- and handle final case, too.
                                rest=$(echo ${rest} | awk -F '|' 'OFS="|"{$1=""; print $0}' | sed -r 's/^.{1}//') # Everything up to the first '|'
                                nnn="$nn"_$ii
                                eval "$nnn"='$str' # carefully escape the right-hand side!
                                ii=$(expr $ii + 1)
                        done
                fi
                i=$(expr $i + 1)
        done
}
