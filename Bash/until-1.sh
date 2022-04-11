#!/bin/bash
# Script name: until.sh
# Author: username-c-is-unavailable
# Date Created: 7 Nov 2018
# Purpose: Example of an Until loop
# Description: Clears the screen and displays the current time every 'n' seconds (the default is 15). Modify the value of '$displayTimeValue' in order to  adjust the frequency.
#
# Modification Date: 27 Nov 2018
# Modification Author: username-c-is-unavailable
# Modification Reason:  Syntax changes so that the script will run both with sh and bash. Prior to this, it only ran correctly when running with the command "./"
#                       Additionally, added more print statements, for clarity.
secondsPassed=0 # A counter to track how many seconds have passed, Start at 0.
displayTimeValue=15 # A sentinel value to indicate the increment (in seconds) for displaying the time. Modify this value to increase/decrease the frequency of the time refresh.
#
clear # Clear the terminal first.
# Print the current time, before the counter begins.
echo "The time is now: " `date +%r` "-Time will refresh every" $displayTimeValue "seconds..."
# An infinite 'until' loop. Will clear the screen and display the current time every 'n' seconds, as determined by the value of '$displayTimeValue'.
until [ 1 -eq 0 ]
do
        sleep 1 #Sleep for 1 second
        secondsPassed=$((secondsPassed+1)) #Increment the value by 1

        # If  the number of seconds passed equals the specified value, then reset the counter, clear the screen, and display the time.
        if [ $secondsPassed -eq $displayTimeValue ]
          then
            secondsPassed=0
            clear
            echo "The time is now: " `date +%r` "-Time will refresh every" $displayTimeValue "seconds..."
        fi
done
