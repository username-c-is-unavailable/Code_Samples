#!/bin/bash
# Script Name: countdown
# Author: username-c-is-unavailable
# Date Created: 7 Nov 2018
# Purpose: A simple while loop, for CSC-324.
# Description: Starts at a pre-defined value of 10, and then decrements by 1 until it reaches 0.
#
# Modification Date: N/A
# Modification Author: N/A
# Modification Reason:  N/A

countValue=10
#
while [ $countValue -ge 1 ]
do
        echo $countValue
        countValue=$((countValue-1)) #Decrement the value by 1
#let countValue--
done
echo "GO!"
#--------------------------------------------------------------------------------------

#!/bin/bash
# Script Name: countdown2
# Author: username-c-is-unavailable
# Date Created: 7 Nov 2018
# Purpose: A while-loop excercise, for CSC-324.
# Description: Accepts a user input number, and then counts down from that number, until it reaches 0.
#              Prior to counting down it will validate the following:
#                1) The user has only entered one argument. Will exit if there is more than one argument entered.
#                2) The user-input value is a positive integer (greater then 0).
#
# Modification Date: 27 Nov 2018
# Modification Author: username-c-is-unavailable
# Modification Reason:  Syntax changed to allow it to be run both with sh and bash. Previously, it only worked when run with "./"
#                       Additionally, usage of an array was removed/replaced since arrays are not supported in sh, although they are supported in bash.
#
isNumeric=0 # Flag to be used to validate whether or not to continue looping, due to non-numeric input.
#
# This 'while' loop will validate for numeric input. It will catch non-numeric strings and any cases where more than one argument was entered as input.
while [ $isNumeric -eq 0 ]
do
 echo "Please enter a single positive numeric value: "

 # Prompt for input from the user
 read countValue

    # The following statement does two things:
    # 1) Compares the user input value with itself. If they are equal using "-eq" then it was a numeric input with no errors.
    # 2) Validates that the user-input value is greater than 0.
    if [ "$countValue" -eq "$countValue" 2>/dev/null ] # Redirect error messages to /dev/null. We don't care about them in this case.
          then
            if [ $countValue -le 0 ] # Check if the number is zero or less. If yes, output a message to the user.
              then echo "You have entered a value of zero or less than zero. Please enter a single integer value (greater than zero) without any quotes or special characters."
            else # Everything is fine. Set the flag so that we no longer loop.
              isNumeric=1
            fi
    # Else, check if there are any white spaces. If so, then there are too many arguments. Output a message and exit.
    elif ( echo "$countValue" | egrep -q ' ')
      then echo "You have entered too many arguments. Only 1 argument is expected. The program will now exit."
      exit 1
    else # Catch everything else here (like non-numeric characters). Output a message and loop.
      isNumeric=0
      echo "You have entered invalid input. Please enter a single integer value (greater than zero) without any quotes or special characters."
    fi
done

# If we reach here, then the input is a valid integer. Print output, counting down from the user-input value.
echo "Beginning countdown..."
while [ "$countValue" -ge 1 ]
do
  echo $countValue
  countValue=$((countValue-1)) #Decrement the value by 1
done
echo "GO!"

#--------------------------------------------------------------------------------------------

#!/bin/bash
# Script Name: countdown3
# Author: username-c-is-unavailable
# Date Created: 7 Nov 2018
# Purpose: A while loop, for CSC-324.
# Description: Accepts a user input number, and then counts down from that number, until it reaches 0.
#              Prior to counting down it will validate the following:
#                1) The user has only entered one argument.
#                2) The user-input value is a positive integer (greater than 0).
#                3) Additionally, if the user hits 'x' or 'Shift+x', then it will exit and inform the user.
#
# Modification Date: 27 Nov 2018
# Modification Author: username-c-is-unavailable
# Modification Reason:  Syntax changed to allow it to be run both with sh and bash. Previously, it only worked when run with "./"
#                       Additionally, usage of an array was removed/replaced since arrays are not supported in sh, although they are supported in bash.
#
#
isNumeric=0 # Flag to be used to validate whether or not to continue looping, due to non-numeric input.
#
# This 'while' loop will validate for numeric input. It will catch any strings or cases where more than one argument was entered as input.
while [ $isNumeric -eq 0 ]
do
 echo "Please enter a positive numeric value, or hit 'x' to exit:"

 # Prompt for input from the user
 read countValue

 # If the user has entered 'x', then exit.
 if [ "$countValue" = "x" ] || [ "$countValue" = "X" ]
   then
     echo "You have entered 'x' to exit. Exiting now."
     exit 0
 # Continue other validations. mainly to validate for numeric input.
 # The following statement does two things:
 # 1) Compares the user input value with itself. If they are equal using "-eq" then it was a numeric input with no errors.
 # 2) Validates that the user-input value is greater than 0.
 elif [ "$countValue" -eq "$countValue" 2>/dev/null ] # Redirect error messages to /dev/null. We don't care about them in this case.
   then
     if [ $countValue -le 0 ] # Check if the number is zero or less. If yes, output a message to the user.
       then echo "You have entered a value of zero or less than zero. Please enter a single integer value (greater than zero) without any quotes or special characters."
     else # Everything is fine. Set the flag so that we no longer loop.
       isNumeric=1
     fi
 # Else, check if there are any white spaces. If so, then there are too many arguments. Output a message and exit.
 elif ( echo "$countValue" | egrep -q ' ')
   then echo "You have entered too many arguments. Only 1 argument is expected. Please enter a single integer value (greater than zero) without any quotes or special characters."
 else # Catch everything else here (like non-numeric characters). Output a message and loop.
   isNumeric=0
   echo "You have entered invalid input. Please enter a single integer value (greater than zero) without any quotes or special characters."
 fi
done

# If we reach here, then the input is a valid integer. Print output, counting down from the user-input value.
echo "Beginning countdown..."
while [ "$countValue" -ge 1 ]
do
  echo $countValue
  countValue=$((countValue-1)) #Decrement the value by 1
done
echo "GO!"
