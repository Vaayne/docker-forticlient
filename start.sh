#!/bin/sh

if [ -z "$VPNADDR" -o -z "$VPNUSER" -o -z "$VPNPASS" ]; then
  echo "Variables VPNADDR, VPNUSER and VPNPASS must be set."; exit;
fi

export VPNTIMEOUT=${VPNTIMEOUT:-5}

# Setup masquerade, to allow using the container as a gateway
for iface in $(ip a | grep eth | grep inet | awk '{print $2}'); do
  iptables -t nat -A POSTROUTING -s "$iface" -j MASQUERADE
done

# set up socks proxy server
PROXY_PORT=${PROXY_PORT:-18388}
if [-z "$PROXY_USER" -o -z "$PROXY_PASS" ]; then
  /usr/bin/gost -L=":$PROXY_PORT" &
else
  /usr/bin/gost -L="$PROXY_USER:$PROXY_PASS@:$PROXY_PORT" &
fi

while [ true ]; do
  echo "------------ VPN Starts ------------"
  /usr/bin/forticlient
  echo "------------ VPN exited ------------"
  sleep 10
done
