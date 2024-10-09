#!/bin/sh
SCRIPTDIR=$(dirname "$0")
#echo $SCRIPTDIR/functions/
for path in $SCRIPTDIR/functions/*.sh; do
  file="$(basename "$path")" # file name without path
  type "${file%.sh}" >/dev/null 2>&1
  if [ "$?" != 0 ]; then
    . "$path"
  fi
done

getArguments $*
setSettings
loadCSV $csv_path OUR_TAB head
DATE=$(date "+%Y%m%d_%H%M")


extraCommandBefore
#exit


i=0
while [ -n "$(get_value_of OUR_TAB_$i)" ]; do
  echo OUR_TAB_$i

  column_Source=$(get_value_of "OUR_TAB_"$i"_Source")
  echo Source $column_Source

  column_Destination=$(get_value_of "OUR_TAB_"$i"_Destination")
  echo Destination $column_Destination

  column_Frequency=$(get_value_of "OUR_TAB_"$i"_Frequency")
  echo Frequency $column_Frequency

  column_Compression=$(get_value_of "OUR_TAB_"$i"_Compression")
  echo Compression $column_Compression

  column_Method=$(get_value_of "OUR_TAB_"$i"_Method")
  echo Method $column_Method
echo MD 
echo "$column_Destination"
  mkdir -p "$column_Destination"

  case $column_Compression in
  gzip)
    tar cvfz "$column_Destination/$DATE.tar.gz" -C ${column_Source} .
    ;;
  bzip2)
    tar cvfj "$column_Destination/$DATE.tar.bz2" -C ${column_Source} .
    ;;
  *)
    mkdir -p "$column_Destination/$DATE"
    cp -LR "$column_Source" "$column_Destination/$DATE"
    ;;
  esac

  echo -------
  i=$(expr $i + 1)
done
