#!/bin/bash
function test(){
while true
do
	echo "hello!"
	sleep 3
done
}
function timeout(){
	waitfor=9
	command=$*
	$command &
	commandpid=$!
	(sleep $waitfor ; kill -9 $commandpid >/dev/null 2>&1 ) &
	watchdog=$!
	sleeppid=$PPID
	wait $commandpid >/dev/null 2>&1
	kill $sleeppid > /dev/null 2>&1
}
timeout test
