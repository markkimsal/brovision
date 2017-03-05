#!/bin/bash

NODE=$1
if [ -z "$NODE" ]
then
	echo "didn't pass node on command line."
	exit 2;
fi

#ORIGEXPORT=$(set -o posix; set)
ORIGEXPORT=$(set)
#ORIGEXPORT=$(env)
nodelist=(nodes/*/$NODE.sh)
if [ ! -z $nodelist ]
then
	echo "sourcing $NODE settings from" $nodelist
	source $nodelist
fi

if [ -z "$SSH_USER" ]
then
	echo "USER is not set for node $NODE";
	exit 2;
fi

if [ -e "$SSH_HOST" ]
then
	SSH_HOST=$NODE
	echo "Using node name $NODE as host";
fi

if [ -e "$SSH_PORT" ]
then
	PORT=22
fi

#DIFFS=$(echo "$ORIGEXPORT" "$(set -o posix; set)" | sort | uniq -u | grep -v IFS)
DIFFS=$(echo "$ORIGEXPORT" "$(set)" | sort | uniq -u )
#DIFFS=$(echo "$ORIGEXPORT" "$(env)" | sort | uniq -u | grep -v IFS)

#remove troublesome variables
DIFFS=$(echo "$DIFFS" | grep -v "^'$" | grep -v no_proxy | grep -v "^_" | grep -v ORIGEXPORT| grep -v "^nodelist" | grep -v "^TASKS")

echo "ssh to $NODE on port $SSH_PORT as $SSH_USER"

if [ -z $TASKS ]
then
	echo "didn't set tasks in node file"
	exit 2;
fi
CMD=$DIFFS
CMD="$CMD
$(<inc/result.sh)
"

isfilematch='.*\/.*$'
for task in "${TASKS[@]}";
do
	[[ "$task" =~ $isfilematch ]]
	if [ $? -eq 1 ]
	then
		task=$task"/run.sh"
	fi
CMD="$CMD
$(<tasks/$task)
"
done

#echo "$CMD"
#exit
echo "$CMD" | ssh -p $SSH_PORT $SSH_USER@$SSH_HOST sudo /bin/bash
