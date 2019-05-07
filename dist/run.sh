#!/bin/bash

# Install xcode command line tools

#
# To check if xcode command line tools exist, xcode-select -p will print the 
# directory. Alternatively, the return value will be 2 if they do NOT exist, 
# and 0 if they do. To just print the return value (thanks @Andy): 
#
# xcode-select -p 1>/dev/null;echo $?
#
# Ref: https://stackoverflow.com/questions/15371925/how-to-check-if-command-line-tools-is-installed/19899984

XCODE_EXIST=$(xcode-select -p 1>/dev/null;echo $?)

# If xcode doesn't exsist, we'll install it
if [ "$XCODE_EXIST" == "2" ]; then
	report_from_package "XCode installing"
	xcode-select --install
	
	# get xcode installer process ID by name and wait for it to finish
	until [ "$(xcode-select -p 1>/dev/null;echo $?)" == "0" ]; do
		sleep 1
	done
else
	report_from_package "xcode already installed - skipping installation."
fi
