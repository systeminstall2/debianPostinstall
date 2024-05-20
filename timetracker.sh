#!/bin/bash

# Path to the file to store time logs
LOG_FILE="$HOME/.timetracker.log"

# Check if the log file exists, and create it if not
touch "$LOG_FILE"

function 1() {
    python3 ~/Documents/DontDeleteImportantAllData/timeManagement/checkIfSameDayForTimetracker.py &

    # Store the current timestamp

    START_TIME=$(date +%s)
    echo "Timer started at $(date)" >> "$LOG_FILE"
    echo "$START_TIME" > "$LOG_FILE.temp"
    echo "HYPER FOCUS MODE ACTIVATED!"
}

function 0() {
    if [ -f "$LOG_FILE.temp" ]; then
        # Read the start timestamp
        START_TIME=$(cat "$LOG_FILE.temp")

        # Calculate the elapsed time
        END_TIME=$(date +%s)
        ELAPSED_TIME=$((END_TIME - START_TIME))

	hours=$(($ELAPSED_TIME / 3600))
	minutes=$((($ELAPSED_TIME % 3600) / 60))

	echo "$(date -d @$START_TIME +%H:%M) - $(date -d @$END_TIME +%H:%M)    :   $hours:$minutes" >> ~/Documents/DontDeleteImportantAllData/timeManagement/timePeriodLogs.txt

        # Append the elapsed time to the log file
        timeAlreadyLoggedToday=$(cat ~/Documents/DontDeleteImportantAllData/timeManagement/timerLogToday.txt)
        addedTimeLoggedToday=$(($timeAlreadyLoggedToday+$ELAPSED_TIME))
        echo $addedTimeLoggedToday > ~/Documents/DontDeleteImportantAllData/timeManagement/timerLogToday.txt
        python3 ~/Documents/DontDeleteImportantAllData/timeManagement/outputTime.py
        echo "Timer stopped at $(date)" >> "$LOG_FILE"
        echo "Elapsed time: $ELAPSED_TIME seconds" >> "$LOG_FILE"
        rm "$LOG_FILE.temp"
    else
        echo "Timer not started. Use 'start' command to begin tracking time."
    fi
}

function 2() {
    cat ~/Documents/DontDeleteImportantAllData/timeManagement/finalDailyTimeroutput.txt | xclip -selection c
}


function 3() {
    cat ~/Documents/DontDeleteImportantAllData/timeManagement/timePeriodLogs.txt
}

function 4() {

	currentYTTimeSpent=$(cat ~/Documents/DontDeleteImportantAllData/timeManagement/currentYTTimeSpent.txt)
	timeLeftUnix=$((3600-currentYTTimeSpent))
	timeLeftMinutes=$((timeLeftUnix/60))
	echo "YT-Time left: $timeLeftMinutes"

# Start time in seconds
start_timestamp=$(date +%s)
start_time=$((start_timestamp-currentYTTimeSpent))

# Main loop
while true; do
    sleep 1
    current_timestamp=$(date +%s)

    currentYTTimeSpent=$(cat ~/Documents/DontDeleteImportantAllData/timeManagement/currentYTTimeSpent.txt)

    current_time=$((current_timestamp))

    echo $((current_time-start_time)) > ~/Documents/DontDeleteImportantAllData/timeManagement/currentYTTimeSpent.txt
  

    if (($currentYTTimeSpent > 3600)) ;then
	echo "YT time over!"
	exit 1
    fi

    read -t 1 -n 1 key
    if [ -n "$key" ]; then
	currentYTTimeSpent=$(cat ~/Documents/DontDeleteImportantAllData/timeManagement/currentYTTimeSpent.txt)
	timeLeftUnix=$((3600-currentYTTimeSpent))
	timeLeftMinutes=$((timeLeftUnix/60))
	echo "YT-Time left: $timeLeftMinutes"
	exit 1
    fi
done
}

# Check the command-line argument
case $1 in
    "1")
        1
        ;;
    "0")
        0
        ;;
    "2")
        2
        ;;
    "3")
        3
        ;;
    "4")
        4
        ;;


    *)
        echo "Usage: $0 {1(start)|0(stop)|2(copy)}"
        exit 1
        ;;
esac

exit 0


