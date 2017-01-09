#!/bin/sh
# Rsync source to destination with some common flags (archive, exclude etc) and timing.

if [ $# -lt 2 ]; then 
    echo "Usage: $0 source destination" >&2
    exit 1
elif [ ! -d "$1" ]; then
   echo "Invalid path: $1" >&2
   exit 1
elif [ ! -d "$2" ]; then
   echo "Invalid path: $2" >&2
   exit 1
elif [ ! -w "$2" ]; then
   echo "Directory not writable: $2" >&2
   exit 1
fi

START=$(date +%s)
rsync -aAXHv $1 $2 --exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/lost+found,/var/lib/pacman/sync/*} --delete
FINISH=$(date +%s)
echo "total time is $(( ($FINISH-$START) / 60 )) minutes, $(( ($FINISH-$START) % 60 )) seconds"
