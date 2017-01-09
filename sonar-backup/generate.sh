#!/bin/sh

show_help() {
cat << EOF
Usage: ${0##*/} [-r sonar-machine] [-s source -d destination] ...
Generates backup.sh script which will execute multiple backup tasks
one by one. Use ./crontab-install.sh to install the script in cron.

    -r sonar-machine  Do a root backup for given machine name.
    -s source         Do a path backup. Destination must follow.
    -d destination    A destination of given path backup.
                      You can define multiple path backups as
		      long as each source has a matching destination.
    -p poweroff       Add poweroff command (use as a last option).
EOF
}

last_source=""

cp templates/backup.sh .

OPTIND=1
while getopts "hr:s:d:p" opt; do
	case "$opt" in
		h)
			show_help
			exit 0
			;;
		r)
			echo "./sonar-root.sh $OPTARG" >> backup.sh
			;;
		s)
			last_source=$OPTARG
			;;
		d)
			if [ -z $last_source ]; then
				echo "Error: mismatching destination." >&2
				rm backup.sh
				exit 1
			fi

			echo "./rsync-path.sh $last_source $OPTARG" >> backup.sh
			last_source=""
			;;
		p)
			echo "poweroff" >> backup.sh
	esac
done
shift "$((OPTIND-1))"

if [ ! -z $last_source ]; then
	echo "Error: mismatching source." >&2
	rm backup.sh
	exit 1
fi

chmod u+x backup.sh
