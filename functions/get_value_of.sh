#!/bin/sh
echo file get_value_of.sh is included
get_value_of()
{
    variable_name=$1
    variable_value=""
    if set | grep -q "^$variable_name="; then
        eval variable_value="\$$variable_name"
    fi
    echo "$variable_value"
}
