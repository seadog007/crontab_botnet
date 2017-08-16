#!/bin/bash

urlprefix='http://example.com'

function log (){
	echo -e "`date`⌚️$1" >> ~/.bd/log
}

function checkver(){
	remote_ver=`curl -s $urlprefix/version`
	[ -z "$remote_ver" ] && remote_ver=`curl -s $urlprefix/version`
	[ -z "$remote_ver" ] && exit 0
	local_ver=`cat $0 | tail -n1`

	log "Remote Version: $remote_ver"
	log "Local Version: $local_ver"
	[ "`echo $remote_ver | head -c1`" == '#' ] && [ "$remote_ver" != "$local_ver" ] && log "Updated!" && curl -s -o ~/.bd/bd.sh $urlprefix/bd.sh && exit 0
}

function runcommand(){
	log "Parsing Command"
	mkdir ~/.bd/command 2&>/dev/null
	while read line
	do
		set -- "$line"
		IFS="#"; declare -a Commands=($*)
		log "Command ID: ${Commands[0]}"
		log "\tCommand: ${Commands[4]}"
		if [ "`grep ^${Commands[0]}$ ~/.bd/runed | head -n1`" != "${Commands[0]}" ] && [ "${Commands[1]}" == "Enable" ]
		then
			run=0
			set -- "${Commands[2]}"
			IFS=","; declare -a Devices=($*)
			for targetdevice in "${Devices[@]}"
			do
				[ "$targetdevice" == "$deviceid" ] && run=1
				[ "$targetdevice" == "all" ] && run=1 && log "\tThis command is for all devices"
				log "\tCommand found in The scope"
			done
			if [ $run -eq 1 ]
			then
				echo "${Commands[4]}" > ~/.bd/command/"${Commands[0]}.sh"
				log "\tCommand writed"
				[ "${Commands[3]}" != "Repeat" ] && echo "${Commands[0]}" >> ~/.bd/runed
				[ "${Commands[3]}" != "Repeat" ] && log "\tCommand id logged, it won't executed again"
				[ "${Commands[3]}" == "Repeat" ] && log "\tCommand is set to repeat"
				bash ~/.bd/command/"${Commands[0]}.sh" &
				log "\tCommand executed!"
			else
				log "\tCommand not found in the scope"
			fi
		else
			log "\tCommand already executed"
			echo "${Commands[0]}" >> ~/.bd/runed
			log "\tCommand id logged, it won't determine again"
		fi
		[ "${Commands[1]}" == "Disable" ] && log "Command ID: ${Commands[0]} Disable"
	done < ~/.bd/command_list
	rm -rf ~/.bd/command
}

function main(){
	curl -s -o ~/.bd/command_list $urlprefix/command_list?user=$user\&deviceid=$deviceid && log "Downloaded Command List" && runcommand && rm -f ~/.bd/command_list
}

function createdeviceid(){
	echo -n "`date`""`uname -a`" | base64 > ~/.bd/deviceid
	log "Created Device ID"
}
[ ! -f ~/.bd/deviceid ] && createdeviceid
deviceid=`cat ~/.bd/deviceid`
[ -z "$deviceid" ] && createdeviceid && deviceid=`cat ~/.bd/deviceid`
user=`whoami`
checkver
main

#release1.0.0
