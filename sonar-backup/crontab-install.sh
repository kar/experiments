#!/bin/sh
# Installs a cronjob for current user, running generated backup.sh every night.
# It will replace current user's crontab file!

if [ $# -lt 2 ]; then 
    echo "Usage: $0 hour minute" >&2
    exit 1
fi

sed -e "s/HOUR/$1/g" -e "s/MINUTE/$2/g" -e "s#PATH#$(pwd)#g" < templates/cron-nightly > crontab-temp
crontab crontab-temp
rm crontab-temp
