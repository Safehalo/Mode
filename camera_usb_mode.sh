#!/bin/bash

echo "📷 Switching to CAMERA USB MODE..."

nmcli connection up camera-usb-mode

# Enable forwarding permanently
sed -i '/net.ipv4.ip_forward/d' /etc/sysctl.conf
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

# Add NAT (internet via usb0)
iptables -t nat -C POSTROUTING -o usb0 -j MASQUERADE 2>/dev/null || \
iptables -t nat -A POSTROUTING -o usb0 -j MASQUERADE

# Allow forwarding
iptables -C FORWARD -i eth0 -o usb0 -j ACCEPT 2>/dev/null || \
iptables -A FORWARD -i eth0 -o usb0 -j ACCEPT

iptables -C FORWARD -i usb0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT 2>/dev/null || \
iptables -A FORWARD -i usb0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT

# Save permanently
netfilter-persistent save

echo "✅ CAMERA USB MODE (INTERNET SHARING ENABLED)"
