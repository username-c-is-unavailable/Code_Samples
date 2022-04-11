#!/bin/bash
# Script name: sum_for.sh
# Author: username-c-is-unavailable
# Date Created: 8 Nov 2018
# Purpose: Example of for-loop
# Description:  Accepts a list of arguments from the command line (during the execution of this script),
#               iterates through it, sums and prints the operands and the result.
#
# Modification Date: 27 Nov 2018
# Modification Author: username-c-is-unavailable
# Modification Reason:  Modified syntax, so that it would work both with sh and bash. Previously, it would only run if the "./" command was used.
#
clear
addends=0
#
for number
do
  tempResult="$tempResult$number + "  # Build a string as it iterates through the input arguments
  addends=$((addends+number)) # Sum each argument with the argument or sum obtained in the previous iteration.
done

# Remove the last character (the last '+' sign) from $tempResult and assign the new string to a new variable.
result=${tempResult%??}
# Print the result.
echo  "$result= $addends"
