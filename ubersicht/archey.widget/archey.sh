#!/bin/bash

# This function will start our JSON text.
startJSON() {
  echo '{'
}

# This function will return a single block of JSON for a single service.
exportNowPlaying() {
  echo '  "now_playing": {'
  echo '    "title": "'${TITLE}'",'
  echo '    "artist": "'${ARTIST}'",'
  echo '    "album": "'${ALBUM}'",'
  echo '    "status": "'${STATUS}'"'
  echo '  }'
}

# This function will finish our JSON text.
endJSON() {
  echo '}'
}

# System Variables
user=$(whoami)
hostname=$(hostname | sed 's/.local//g')
distro="OS X $(sw_vers -productVersion)"
kernel=$(uname -smr)
#uptime=$(uptime | sed 's/.*up \([^,]*\), .*/\1/')
uptime=$(uptime | sed 's/^.*up/up/')
shell=$(/usr/local/bin/zsh --version | awk '{print $1, $2}')
terminal="xterm-256color"
cpu=$(sysctl -n machdep.cpu.brand_string)
packagehandler="`/usr/local/bin/brew list -l | wc -l | awk '{print $1 }'`"

# removes (R) and (TM) from the CPU name so it fits in a standard 80 window
cpu=$(echo "$cpu" | awk '$1=$1' | sed 's/([A-Z]\{1,2\})//g')

mem=$(sysctl -n hw.memsize)
ram="$((mem/1073741824)) GB"
disk=`df | head -2 | tail -1 | awk '{print $5}'`

userText="User"
hostnameText="Hostname"
distroText="OS"
kernelText="Kernel"
uptimeText="Uptime"
shellText="Shell"
terminalText="Terminal"
packagehandlerText="Packages"
cpuText="CPU"
memoryText="Memory"
diskText="Disk"

startJSON
echo -e " \"$userText\": \"$user\",
 \"$hostnameText\": \"$hostname\",
 \"$distroText\": \"$distro\",
 \"$kernelText\": \"$kernel\",
 \"$uptimeText\": \"$uptime\",
 \"$shellText\": \"$shell\",
 \"$terminalText\": \"$terminal\",
 \"$packagehandlerText\": \"$packagehandler\",
 \"$cpuText\": \"$cpu\",
 \"$memoryText\": \"$ram\",
 \"$diskText\": \"$disk\""
endJSON
