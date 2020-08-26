#!/bin/bash

DATE=$(date +%Y%m%dT%H%M%S)

/usr/local/bin/etcd-snapshot-backup-disconnected.sh /assets/backup

if [ $? -eq 0 ]; then
    mkdir /etcd-backup/${DATE}
    cp -r /assets/backup/*  /etcd-backup/${DATE}/
    if [ $? -eq 0 ]; then
        echo 'Copied backup files to PVC mount point.'
        exit 0
    fi
fi

echo "Backup attempts failed. Please FIX !!!"
exit 1
