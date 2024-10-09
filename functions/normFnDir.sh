#!/bin/sh
echo file normFnDir.sh is included
normFnDir() {
	echo fd $FILES_DIR
	FILES_LIST=`find "$FILES_DIR" -name '*'`
	SAVEIFS=$IFS
IFS='
'
	for CURRENT_FILE in ${FILES_LIST}; do
		NEW_NAME=`echo "$CURRENT_FILE" | tr '[:upper:]' '[:lower:]' | sed 's/ /__/g' | sed 's/,/_/g' | sed 's/(/_/g' | sed 's/)/_/g'`
		if [ "$CURRENT_FILE" = "$NEW_NAME" ]; then
			echo file "$CURRENT_FILE" is already with proper name.
			#echo 0 > /dev/null
		else
			echo "Rename $CURRENT_FILE   -->   $NEW_NAME"
			mv $CURRENT_FILE $NEW_NAME
		fi
	done
	IFS=$SAVEIFS
}








