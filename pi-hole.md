# Pi-hole

[Pi-hole] is a DNS sinkhole for ad blocking. It can also be configured to act
as a recursive DNS server.

This document is a distilled version of the following:

- [Pi-hole documentation](https://docs.pi-hole.net/)
- [nftables + certbot on Rasbian](https://discourse.pi-hole.net/t/guide-nftables-certbot-on-raspbian-not-for-docker-setups/78644)

## Setup

### Rasberry Pi OS Image

Use the [official Rasberry Pi Imager] to install the OS to a microSD card.
Use a hostname like `pihole` for clarity.

For a headless installation, make sure to enable SSH using a password.

### Static IP

Hook up the device to the router via Ethernet. Use your router's advanced
settings to assign a static IP address to your Rasberry Pi device via DHCP
reservations. Make sure to pick an IP address that is outside your router's
DHCP range.

```bash
sudo vi /etc/dhcpcd.conf

interface eth0 # or wlan0 for Wi-Fi
static ip_address=192.168.0.254/24 # Your desired IP/subnet mask
static routers=192.168.0.1 # Your router's IP (Gateway)
static domain_name_servers=127.0.0.1 # Pi-hole itself
```

Verify the IP address by scanning your LAN using `nmap -sn 192.168.0.0/24`
(replace with you local IP subnet). You can find your local IP subnet address
using your router's settings or by running `ip addr`.

For a headless connection to the device, you can SSH using
`ssh user@hostname.lan` where user and hostname are determined during the
Rasberry Pi image process.

### Update OS

```bash
sudo apt update
sudo apt upgrade
sudo reboot

sudo apt update
sudo apt dist-upgrade
sudo reboot

sudo apt autoremove --purge
sudo reboot
```

### Firewalls

See [Firewalls](https://docs.pi-hole.net/main/prerequisites/#firewalls) to
configure a firewall via iptables. However, using nftables is preferred for
better security.

```bash
sudo apt install nftables
sudo vi /etc/nftables.conf
```

A basic nftables ruleset is below.

```
#!/usr/sbin/nft -f
flush ruleset

table inet filter {
    chain input {
        type filter hook input priority 0; policy drop;

        # Allow established/related connections
        ct state established,related accept

        # Allow loopback
        iifname lo accept

        # Allow ICMP and ICMPv6
        ip protocol icmp accept
        ip6 nexthdr icmpv6 accept

        # Allow DHCP (ports 67, 68)
        udp dport 67 accept
        udp dport 68 accept
        udp sport 67 accept
        udp sport 68 accept

        # Allow SSH (port 22)
        tcp dport 22 accept

        # Allow HTTP/HTTPS (ports 80, 443)
        tcp dport { 80, 443 } accept

        # Allow DNS (port 53 UDP and TCP)
        udp dport 53 accept
    }

    chain forward {
        type filter hook forward priority 0; policy drop;
    }

    chain output {
        type filter hook output priority 0; policy accept;
    }
}
```

```bash
# Print 0 if no problems found
sudo nft -c -f /etc/nftables.conf; echo $?

# Failsafe test of nftables
sudo -i
(nft -f /etc/nftables.conf; sleep 240 && nft flush ruleset && nft -f /etc/nftables.backup) &
# If the above doesn't hang
backup_pid=$!
echo $backup_pid
# Test SSH/HTTP/HTTPS/DNS resolution
kill $backup_pid

sudo systemctl enable --now nftables
sudo nft list ruleset
sudo chmod +x /etc/nftables.conf
sudo reboot
```

### Install Pi-hole

Follow the instructions from [here](https://docs.pi-hole.net/main/basic-install/).
Cloudflare is a good choice for the upstream DNS server.

```bash
wget -O basic-install.sh https://install.pi-hole.net
sudo bash basic-install.sh
sudo usermod -aG pihole $USER
```

Configure your router/devices to use the Pi-hole as their DNS server following
the steps outlined [here](https://discourse.pi-hole.net/t/how-do-i-configure-my-devices-to-use-pi-hole-as-their-dns-server/245).

### Recursive DNS

Follow the steps for installing [unbound](https://docs.pi-hole.net/guides/dns/unbound/)
to configure the Pi-hole as a recursive DNS.
