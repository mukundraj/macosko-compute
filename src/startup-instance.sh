#! /bin/bash

# start up script to be run on each boot

[ -d /tmp/ramdisk ] || mkdir /tmp/ramdisk
sudo mount -t tmpfs tmpfs /tmp/ramdisk
sudo mount -o remount,size=4G /tmp/ramdisk

mountdiskat(){

  # ensure atleast two arg provided
  if [ $# -lt 2 ]; then
    echo "args disk_name and mount_pt needed"
    echo "usage: mountdiskat <disk_name> <mount_pt>"
    return 1
  fi

	echo mounting drive $1
	DISK_NAME=$1
	DISK_ID=$(ls -l /dev/disk/by-id/google-* | grep "$DISK_NAME" | sed 's/.*\///')
  if [ ${#DISK_ID} -gt 0 ]; then
    echo "detected $DISK_NAME at $DISK_ID"

    # check if disk is already mounted
    MOUNTDIR=$(df -h | grep "/dev/$DISK_ID" | awk '{print $6}')
    if [ ${#MOUNTDIR} -gt 0 ]; then
      echo "disk $DISK_NAME is mounted at $MOUNTDIR"
      return 1
    fi

    MOUNTDIR=$2
    sudo mkdir -p $MOUNTDIR
    f=$MOUNTDIR
    while [[ $f != / ]]; do sudo chmod a+w "$f"; f=$(dirname "$f"); done;
    sudo mount -o discard,defaults /dev/$DISK_ID $MOUNTDIR
    # check for error
    if [ $? -ne 0 ]; then
      echo "error while mounting $DISK_NAME at $MOUNTDIR"
      return 1
    fi
    echo mounted $1 at $MOUNTDIR
  else
    echo "no disk detected with name: $DISK_NAME"
  fi


}

DISK_NAME=mraj-common
DISK_ID=$(ls -l /dev/disk/by-id/google-* | grep "$DISK_NAME" | sed 's/.*\///')
if [ ${#DISK_ID} -gt 0 ]; then
    echo "detected $DISK_NAME at $DISK_ID"
    mountdiskat mraj-common /mnt/disks/common
else
    echo "Common disk not attached. Attach and reboot if needed."
fi

