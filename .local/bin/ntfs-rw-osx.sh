#!/bin/bash
# Modified by jschmidt to have mounted drives show up in Finder

checkExisting() {
	echo "Checking if already existing device on file..."

	while read -r fileLine; do
		if [ "$line" = "$fileLine" ]; then
			echo "[WARNING] Device already initialized on this system. Nothing to do here"
			open "$FILENAME"
			exit 0;
		fi
	done < /etc/fstab
}

addLine() {
	uuid=$( diskutil info "$FILENAME" | grep UUID | cut -d ':' -f2 | tr -d ' ' )
	volumeName=$( diskutil info "$FILENAME" | grep "Volume Name" | cut -d ':' -f2 | tr -d ' ' )

	if [ "$uuid" = "" ]; then
		line="LABEL=$volumeName none ntfs rw,auto";
	else
		line="UUID=$uuid none ntfs rw,auto";
	fi

	checkExisting;
	echo "# New NTFS HD: $volumeName on $(date) " >> /etc/fstab
	echo "$line" >> /etc/fstab
	device=$( diskutil info "$FILENAME" | grep "Device Node" | cut -d ':' -f2 | tr -d ' ' )
	diskutil unmount "$FILENAME"
	diskutil mount "$device"
	open "$FILENAME";
	exit 0;
}

checkDisk() {
	filetype=$( diskutil info "$FILENAME" | grep "Type (Bundle):" | cut -d ':' -f2 | tr -d ' ' )

	if [ "$filetype" = "ntfs" ]; then
		addLine;
	else
		echo "Error. Please, select a NTFS device. Detected filetype=$filetype"
	fi
}

#Check sudo
if [[ $( /usr/bin/id -u ) -ne 0 ]]; then
	echo "This script should be run as ROOT. Trying sudo..."
	sudo "$0" "$@"
	exit $?
fi

echo "___________________________________"
echo "RubeniumTB. 2013 --ruben80(at)gmail.com--"
echo "Modified by Jason Schmidt zannalov(at)gmail.com"
echo ""
echo "Initialize a NTFS Hard Disk on this system to read and write"
echo "Next time you won't need to initialize it again. Just plug and open but"
echo "take into account that:"
echo ""
echo "* Configured disks will not be auto-opened!!"
echo "* You will need to open /Volumes and click on your disk!!"
echo ""
echo "* Although it should not happen anything wrong, use at your own risk"
echo ""
echo "* IMPORTANT!!. Be sure that the NTFS device has been safely removed or it won't"
echo "be mounted in write mode. In this case you can connect it again to any windows PC,"
echo "remove safely, and then connect to your MAC"
echo ""
echo "* Also IMPORTANT!!. To avoid problems use SHORT names for the Volume names, "
echo "NO SPACES, and preferably only letters/numbers. Of course no special characters!!"
echo ""
echo "Now you are ready...."
echo "SELECT a NTFS Disk to initialize on this system"
echo "Write quit to exit"
echo ""

if [ "$1" = "" ]; then
	select FILENAME in "/Volumes"/*
	do
		case "$FILENAME" in
			"$QUIT")
				echo "Exiting."
				break
			;;
			*)
				echo "You picked $FILENAME"
				checkDisk;
			;;
		esac
	done
else
	FILENAME="$1"
	checkDisk;
fi
