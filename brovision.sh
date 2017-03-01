#!/bin/bash

NODE=$1
if [ -z "$NODE" ]
then
	echo "didn't pass node on command line."
	exit 2;
fi

if [ ! -z clients/local/nodes/$NODE.sh ]
then
	echo "sourcing $NODE settings from clients/local/nodes/$NODE.sh"
	source clients/local/nodes/$NODE.sh
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

for task in $TASKS
do
CMD="$CMD
$(<tasks/$task/run.sh)
"
done

echo "$CMD" | ssh -p $PORT $USER@$HOST sudo /bin/bash
