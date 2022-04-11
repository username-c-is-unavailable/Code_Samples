#!/bin/bash
# Script Name: info.sh
# Author: username-c-is-unavailable
# Date Created: 30 Oct 2018
# Purpose: Prints various info for the lab assignment.
# Description: This script prints the time, date, hostname, server, shell/version and kernel version, in that order.
# Date Last Modified: N/A

# Print the current time with %T, same as %H:%M:%S
echo "The current time is: " `date +%T`

# Print the current date with %D, same as %m/%d/%y
echo "The current date is: " `date +%D`

# Print the name of the logged-in user (the one currently executing this script)
echo "I am currently logged in as: " `whoami`

# Print the hostname (FQDN)
echo "The hostname of this server is:" `hostname -f`

# Print the server distro
echo "The distro type of this server is: " `uname`

# Print the shell name and version number
echo "The shell name is '"$BASH"' and the shell version is '"$BASH_VERSION"'"

# Print the kernel version
echo "The kernel version is: " `uname -v`
