#!/bin/bash

# Startup file that fix and help startup.

start() {
# Start the VNC server with all the needed programs and files
vncserver $1 	# Start the VNC server
export DISPLAY=$1
autocutsel -fork	# Clipboard helper
}

stop() {
vncserver -kill $1
}

# Set the display number to a default value
if [[ -z $2 ]]; then
display=":1"
else
display="$2"
fi

# Commands to be started
if [[ "$1" == "start" ]]; then
echo "Starting VNC server at display $display"
start $display

elif [[ "$1" == "stop" ]]; then
echo "Stopping VNC server at display $display"
stop $display

elif [[ "$1" == "help" ]]; then
echo â€œUsage $0 COMMAND DISPLAY_VALUEâ€
echo â€œCOMMAND: start / stopâ€
echo â€œDISPLAY_VALUE : Is the number of the Xorg sessionâ€
echo â€œFormat of DISPLAY_VALUE - :1 :2 :3â€

else
echo "Invalid argument"
fi

exit 0
