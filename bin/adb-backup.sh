#!/bin/bash -e

# Options
backup_shared=1
if [[ "--no-shared" = "$1" ]]; then
    backup_shared=0
    shift 1
fi

# Block until device attached
echo "Waiting for attached device..."
adb wait-for-device || echo "Continuing despite adb wait-for-device failing..."

# Process device selection
adb devices 1>.adb_devices_tmp.txt 2>&1
if [[ "" != "$1" ]]; then
    # If one was provided by hand
    if ! cat .adb_devices_tmp.txt | grep '^'"$1"'\t' &>/dev/null; then
        echo 'Device "'"$1"'" not found'
        cat .adb_devices_tmp.txt
        echo "Usage: $0 [--no-shared] [device]"
        rm .adb_devices_tmp.txt
        exit 1
    fi

    device="$1"
    shift 1
else
    if test $( cat .adb_devices_tmp.txt | wc -l ) -ne 3; then
        echo "Multiple devices detected/attached to adb:"
        cat .adb_devices_tmp.txt
        echo "Please provide one when calling this script."
        echo "Usage: $0 [--no-shared] {device}"
        rm .adb_devices_tmp.txt
        exit 1
    fi

    device="$( cat .adb_devices_tmp.txt | head -n 2 | tail -n 1 | cut -d $'\t' -f 1 )"
fi
rm .adb_devices_tmp.txt
echo "Using: $device"

# Build base adb command to always only use selected device
adb=( adb -s "$device" )

# http://codetheory.in/android-debug-bridge-adb-wireless-debugging-over-wi-fi/
# Go Wireless
# "${adb[@]}" tcpip 5556
# device="$( "${adb[@]}" shell ifconfig wlan0 | cut -d ' ' -f 3 )"
# adb connect "$device":5556
# adb=( adb -s "$device":5556 )

# Create backup dir
dir="./${device}-$(date -u +%Y-%m-%d-%H%M%SZ)"
mkdir "$dir"

# Copy self into the dir for reference
cp "$0" "$dir"/

# Change to dir so all paths will be current directory
cd "$dir"

# Set up a path by which we can output to stdout despite redirecting all stdout
# and stderr to a log file
exec 3>&1

# Redirect all normal output to a log file
exec 1>>backup.log 2>&1

# Back up /mnt/sdcard which should be any "custom" storage which isn't an
# external SD card
if [[ "1" = "$backup_shared" ]]; then
    echo "/mnt/sdcard"
    mkdir sdcard

    # tar was barfing on file names greater than 100 characters long, otherwise this would have been ideal:
    #"${adb[@]}" exec-out tar -c -f - -X /mnt/sdcard/.tar.exclude -C /mnt/sdcard/ . | tar -C sdcard -x -v -v

    # So instead check to see if there's a top-level find command which produces a list of directories sans excludes
    if ( "${adb[@]}" pull -p -a /mnt/sdcard/.adb-backup-find-grep.sh ./adb-backup-find-grep.sh ); then
        # Run the command and store its output
        "${adb[@]}" exec-out find /mnt/sdcard/ -type f | sed 's#^/mnt/sdcard/*##' > ./mnt-sdcard-find.txt
        sh ./adb-backup-find-grep.sh < ./mnt-sdcard-find.txt > ./mnt-sdcard-find-grep.txt

        # Iterate over the lines of the file
        while IFS= read -r line
        do
            # And call pull for each one
            echo "$line"
            "${adb[@]}" pull -a /mnt/sdcard/"$line" ./sdcard/"$line" || echo "Exit code: $?" # Fail soft on this one since a file transfer error will end the entire backup
        done < ./mnt-sdcard-find-grep.txt
    else
        # So instead
        "${adb[@]}" pull -p -a /mnt/sdcard/ ./sdcard/ || echo "Exit code: $?" # Fail soft on this one since a file transfer error will end the entire backup
    fi
    echo
else
    echo "Skipping /mnt/sdcard"
fi

# Get the list of installed packages, stripping off the "package:" prefix which
# pm adds to each line
"${adb[@]}" shell pm list packages 2>&1 | tr -d '\r' | sed 's/^package://' > packages.txt
echo -n "Found packages: " ; wc -l packages.txt
echo

# This command takes care of running one "adb backup" command provided to it
function runBackupCommand() {
    # Make backup screen appear with provided adb command
    echo "$@"
    "$@" &

    # Wait for the backup confirmation window to appear
    echo "Waiting for backup confirmation screen..."
    sleep 1
    while( ! "${adb[@]}" shell dumpsys window 2>/dev/null | egrep 'mCurrentFocus=.*BackupRestoreConfirmation' &>/dev/null ); do
        echo "Still waiting..."
        sleep 1
    done

    # Tap the backup button by navigating to it via key presses
    # http://stackoverflow.com/a/28969112
    echo "Entering device ID as password and simulating button selection"
    #"${adb[@]}" shell input keyevent 19
    "${adb[@]}" shell input text "$device"
    "${adb[@]}" shell input keyevent 20 \; input keyevent 22 \; input keyevent 23

    # Wait for backup to complete
    echo "Waiting for backup to complete"
    wait

    # If the backup file exists
    if test -e backup.ab ; then
        # but is too small to actually contain any data
        local filesize=$( wc -c backup.ab | sed 's/ *\([^ ]*\) .*/\1/' )
        if test $filesize -le 41 ; then
            # Clean up failed backup
            rm backup.ab
        fi
    fi
}

# For every installed package
for p in $( cat packages.txt ); do
    echo "$p"

    # Try backing up the whole app
    runBackupCommand "${adb[@]}" backup -apk -obb -noshared "$p"

    if ! test -e backup.ab ; then
        # Fall back to backing up just the APK and data
        runBackupCommand "${adb[@]}" backup -apk -noobb -noshared "$p"

        if ! test -e backup.ab ; then
            # Fall back to backing up just the data
            runBackupCommand "${adb[@]}" backup -noapk -noobb -noshared "$p"

            if ! test -e backup.ab ; then
                echo "FAILED: $p"
                echo "FAILED: $p" >&3
                touch "$p".failed.txt
            else
                mv -v backup.ab "$p".no-apk.no-obb.ab
            fi
        else
            mv -v backup.ab "$p".apk.no-obb.ab
        fi
    else
        mv -v backup.ab "$p".apk.obb.ab
    fi

    echo
done

echo "Done."
echo "Done." >&3
