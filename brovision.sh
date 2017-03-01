#!/bin/bash

NODE=$1
if [ -z "$NODE" ]
then
	echo "didn't pass node on command line."
	exit 2;
fi

nodelist=(nodes/*/$NODE.sh)
if [ ! -z $nodelist ]
then
	echo "sourcing $NODE settings from " $nodelist
	source $nodelist
fi

if [ -z "$USER" ]
then
	echo "USER is not set for node $NODE";
	exit 2;
fi

if [ -e "$HOST" ]
then
	HOST=$NODE
	echo "Using node name $NODE as host";
fi

if [ -e "$PORT" ]
then
	PORT=22
fi


echo "ssh to $NODE on port $PORT as $USER"

if [ -z $TASKS ]
then
	echo "didn't set tasks in node_vars file"
	exit 2;
fi

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

echo "$CMD" | ssh -p $PORT $USER@$HOST sudo /bin/bash
