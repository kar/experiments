#!/bin/sh
# A simple rsync-based archive backup script from:
# https://wiki.archlinux.org/index.php/Full_System_Backup_with_rsync

if [ $# -lt 1 ]; then 
    echo "No destination defined. Usage: $0 destination" >&2
    exit 1
fi

case "$1" in
  "/mnt") ;;
  "/mnt/"*) ;;
  "/media") ;;
  "/media/"*) ;;
  *) echo "Destination not allowed." >&2 
     exit 1 
     ;;
esac

./rsync-path.sh / $1
