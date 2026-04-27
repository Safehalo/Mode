#!/bin/bash

echo "🌐 Switching to NORMAL MODE..."

nmcli connection up normal-mode

# Disable forwarding permanently
sed -i '/net.ipv4.ip_forward/d' /etc/sysctl.conf
echo "net.ipv4.ip_forward=0" >> /etc/sysctl.conf
sysctl -p

# Remove NAT rules
iptables -t nat -F

# Remove forwarding rules
iptables -F FORWARD

# Set default policy (safe)
iptables -P FORWARD ACCEPT

# Save clean state
netfilter-persistent save

echo "✅ NORMAL MODE (NO ROUTING, DHCP MODE)"
