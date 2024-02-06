#!/bin/sh

# 0: run as user
# 1: run as service
service=0

# 0: write update count to state file
# 1: read update count to stdout
count=0

updates=$(pacman -Sy > /dev/null && pacman -Qu)
num_updates=$(echo $updates | wc -l)

# State file
statefile='/var/local/package-updates'

# Loop through arguments and set flags (above)
for arg in "$@"
do
    case "$arg" in
        -s)
            service=1
            ;;
        -c)
            count=1
            ;;
    esac
done

if [ $count -eq 1 ]; then
    cat $state
    exit 0
fi

# Process flags
if [ $service -eq 1 ]; then
   echo "${num_updates}" > $statefile
fi

echo "Available package updates: ${num_updates}"
