# 📷 Camera Mode & 🌐 Normal Mode Setup Guide

This guide helps you switch between:

- **Camera Mode** → Static IP + Internet Sharing (NAT)  
- **Normal Mode** → DHCP (default network)

---

## ⚙️ Step 1: Install Required Packages

```bash
sudo apt update
sudo apt install iptables-persistent
```

---

## 🔄 Step 2: Reset Network Rules

```bash
sudo iptables -t nat -F
sudo sysctl -w net.ipv4.ip_forward=0
sudo netfilter-persistent save
```

---

## 🌐 Step 3: Create Network Profiles

### 📷 Camera Mode (Static IP)

```bash
sudo nmcli connection add type ethernet ifname eth0 con-name camera-usb-mode ip4 192.168.0.1/24
sudo nmcli connection modify camera-usb-mode ipv4.method manual
```

### 🌐 Normal Mode (DHCP)

```bash
sudo nmcli connection add type ethernet ifname eth0 con-name ethernet-mode
sudo nmcli connection modify ethernet-mode ipv4.method auto
```

---

## 📁 Step 4: git clone

```bash
git clone git@github.com:Safehalo/Mode.git
```

Make scripts executable:

```bash
chmod +x camera_usb_mode.sh
chmod +x Eternet_mode.sh
```

---

## 🚀 Step 5: Run Modes

### 📷 Switch to Camera Mode

```bash
sudo ./camera_usb_mode.sh
```

**Enables:**
- Static IP (192.168.0.1)
- IP forwarding
- NAT (via usb0)
- Internet sharing to camera

---

### 🌐 Switch to Normal Mode

```bash
sudo ./Ethernet_mode.sh
```

**Restores:**
- DHCP mode
- Disables forwarding
- Clears NAT rules
