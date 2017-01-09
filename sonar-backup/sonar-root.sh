#!/bin/sh
# Backup whole root tree while also logging everything.

if [ $# -lt 1 ]; then 
    echo "Usage: $0 sonar-machinename" >&2
    exit 1
fi

./rsync-root.sh /mnt/nas/backup/sonar/$1 2>&1 | tee /mnt/nas/backup/sonar/logs/$1-$(date -Iseconds)
