SCRIPT=`realpath $0`;SCRIPT_PATH=`dirname $SCRIPT`;cd $SCRIPT_PATH

prepend_string(){
	STRING="$1"
	FILE_NAME="$2"
	touch $FILE_NAME
	echo "$STRING" | cat - $FILE_NAME > .temp.txt && mv .temp.txt $FILE_NAME
}

find . -name "*.sh"|while read fname; do
  if [ "$fname" != "./configure.sh" ]; then
	echo "editing -> $fname"
  	prepend_string "BASE_PATH=$SCRIPT_PATH" $fname
	chmod 777 $fname
  else
	echo "@@@@@@@@ Excludong --> $fname "
  fi
done
