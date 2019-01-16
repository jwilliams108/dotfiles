#!/bin/bash

# This function will start our JSON text.
startJSON() {
  echo '{'
  echo '  "service" : ['
}

# This function will return a single block of JSON for a single service.
exportService() {
  echo '  {'
  echo '    "name":"'$1'",'
  echo '    "ipaddress":"'${ip}'",'
  echo '    "macaddress":"'${mac}'"'
  echo '  }'
}

# This function will finish our JSON text.
endJSON() {
  echo '  ]'
  echo '}'
}

# Start the JSON.
startJSON

# Output the Ethernet information.
ip=$(networksetup -getinfo ethernet | grep -Ei '(^IP address:)' | awk '{print $3}')
mac=$(networksetup -getinfo ethernet | grep -Ei '(^Ethernet address:)' | awk '{print $3}')
if [ "$ip" = "" ];then 
    if networksetup -listallnetworkservices | grep -qEi '^USB Ethernet'; then
        service="USB Ethernet"
    else
        if networksetup -listallnetworkservices | grep -qEi '^Apple USB Ethernet Adapter'; then
            service="Apple USB Ethernet Adapter"
        else
            service="Thunderbolt Ethernet"
        fi
    fi

    ip=$(networksetup -getinfo "$service" | grep -Ei '(^IP address:)' | awk '{print $3}')
    mac=$(networksetup -getinfo "$service" | grep -Ei '(^Ethernet address:)' | awk '{print $3}')
fi
exportService "ethernet"

# Place a comma between services.
echo '  ,'

# Output the Wi-Fi information.
ip=$(networksetup -getinfo wi-fi | grep -Ei '(^IP address:)' | awk '{print $3}')
mac=$(networksetup -getinfo wi-fi | grep -Ei '(^Wi-Fi ID:)' | awk '{print $3}')
exportService "wi-fi"

# Place a comma between services.
echo '  ,'

# Output the Public IP information
#ip=$(curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')
#ip=$(/usr/local/bin/wget -qO - ident.me)
ip=$(/usr/local/bin/wget -qO - icanhazip.com | awk '{print $1}')
mac=""
exportService "public-ip"

# End the JSON
endJSON
