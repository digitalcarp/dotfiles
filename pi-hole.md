# Pi-hole

[Pi-hole] is a DNS sinkhole for ad blocking. It can also be configured to act
as a recursive DNS server.

This document is a distilled version of the following:

- [Pi-hole documentation](https://docs.pi-hole.net/)
- [nftables + certbot on Rasbian](https://discourse.pi-hole.net/t/guide-nftables-certbot-on-raspbian-not-for-docker-setups/78644)
- [TimInTech's Comprehensive Guide](https://github.com/TimInTech/Pi-hole-v6.0---Comprehensive-Guide)

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

### log2ram

Follow instructions from [GitHub](https://github.com/azlux/log2ram). The
default configuration (128MB log folder) is sufficient.

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

```bash
# Install some additional utilities for unbound.
# These may be already installed as part of unbound package.
sudo apt install unbound-anchor unbound-host
```

Below are some additional changes to the unbound config to help with occasional
performance slowdowns. They should be added to
`/etc/unbound/unbound.conf.d/pi-hole.conf`. The config is inspired by
[this reddit post](https://www.reddit.com/r/pihole/comments/d9j1z6/unbound_as_recursive_dns_server_slow_performance/)
and [nlnetlabs](https://nlnetlabs.nl/documentation/unbound/howto-optimise/).

```conf
server:
    # These options should be added to the existing server configuration,
    # overwriting existing values if they're there.

    # This attempts to reduce latency by serving the outdated record before
    # updating it instead of the other way around. Alternatively, increase
    # cache-min-ttl to e.g. 3600.
    cache-min-ttl: 0
    serve-expired: yes

    # More cache memory (rrset = msg * 2)
    msg-cache-size: 8m
    rrset-cache-size: 16m

    # Larger socket buffer. sysctl config for net.core.rmem_max needs to be
    # modified to 4m as well.
    so-rcvbuf: 4m
```

The OS needs to allow `so-rcvbuf` to be 4MiB, so add
`/etc/sysctl.d/99-pihole.conf`.

```conf
net.core.rmem_max = 4194304
```

### Tuning

The default DNS rate limit of 1000 queries in a 60 second window can cause
random DNS resolution problems. This is especially the case when the router
config causes all queries to appear to be made from the same client.

```bash
sudo pihole-FTL --config dns.rateLimit.count 4096
sudo pihole-FTL --config dns.rateLimit.interval 60
```
