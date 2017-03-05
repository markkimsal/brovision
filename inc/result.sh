#BRO_COLORS=$(tput colors)
#[ ${BRO_COLORS} -ge 8 ] && {
#	BRO_COLORS=1
#} || {
#	BRO_COLORS=0
#}
BRO_COLOR_FAIL=31
BRO_COLOR_PASS=32
BRO_COLOR_SKIP=34
BRO_COLORS=1

function result_color() {

if [ ${BRO_COLORS} -ge 1 ] 
then
	 echo -n $'\033[1;'
	 echo -n "$2"
	 echo -n 'm'
fi


if [ ${BRO_COLORS} -ge 1 ] 
then
	 echo -n "$1";
	 echo $'\033[0m\n'
else
	 echo "$1";
fi

}

function bro_result_fail() {

	result_color "$1" $BRO_COLOR_FAIL
}

function bro_result_pass() {
	result_color "$1" $BRO_COLOR_PASS
}

function bro_result_skip() {
	result_color "$1" $BRO_COLOR_SKIP
}
