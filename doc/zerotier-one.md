# zerotier-one

[ZeroTier](https://www.zerotier.com) is a service to create secure
peer-to-peer virtual networks.

## Initial Installation

When executed the first time, this script will execute
[ZeroTier's installation script](https://www.zerotier.com/download/#downloadLinux).
This adds a new *apt* source in `/etc/apt/sources.list.d/` for the official
*ZeroTier* repositories, installs the appropriate *apt-key* to
validate packages, and then installs *ZeroTier*.

Once *ZeroTier's* install script successfully executes, this script then moves
the folder containing *ZeroTier* configuration files from `/var/lib/zerotier-one`
to `/data/unifios-utils/.config/zerotier-one`.  It then creates a symbolic link
from the original to the new location, allowing *ZeroTier* to work with the files
transparently and persistently across reboots.

Note: The script assumes that **it** creates creates the folder `.config/zerotier-one`.
If a user creates that folder prior to executing the script, it will cause the script
to not function properly.

## Joining a Network

After [creating a *ZeroTier* Network](https://zerotier.atlassian.net/wiki/spaces/SD/pages/8454145/Getting+Started+with+ZeroTier),
execute the following command to join (where `NETWORK_ID` is a 16-digit hex code specific
to your *ZeroTier* network).

```
zerotier-cli join NETWORK_ID
```

## Persistence

The script enables persistent installation and configuration of *ZeroTier*
when called by the *UniFiOS Utilities* *systemd* script by:
1. Executing the initial installation if there is no existing configuration present
2. If a configuration is present, checking if the *ZeroTier* packge is installed
3. Reinstalling the *ZeroTier* package if wiped during a firmware update

## Routing Between Networks

Using ZeroTier, two (or more) physically separate LANs can be connected and
packets routed between the private IP address spaces.  For users with two
UniFi OS devices, this allows the two networks to effective behave as a 
single network (with some exceptions such as mDNS) with *ZeroTier* installed
only on the routers (such as *UDM-Pro*).

### ZeroTier Configuration

1. Using the [ZeroTier Portal](https://my.zerotier.com), configure ZeroTier to
use a private address space that does not overlap with any of the LANs.  In this
case, the ZeroTier network uses `192.168.191.0/24`.

2. Run the ZeroTier service on each network's *UDM-Pro* and note the IP address
assigned to each *ZT* interface.

For example, two networks with IP address ranges:
Network A: `192.168.1.0/24`
Network B: `192.168.2.0/24`

For example, the *ZT* IP addresses could be
Network A: `192.168.191.1`
Network B: `192.168.191.2`

3. Create Managed Routes within the ZeroTier portal, establishing a route from
the subnet of each LAN to the *ZT* address on that LAN.

Following the example, the Managed Routes are:
Network A: `192.168.1.0/24` via `192.168.191.1`
Network B: `192.168.2.0/24` via `192.168.191.2`

**There must be at least two routes, one for each LAN at either end**

### UniFi Network Configuration

In each [UniFi web interface](https://unifi.ui.com), create static routes to
the other LAN IP address ranges.

1. On each device, navigate to "Settings", "Advanced Features", "Advanced
Gateway Settings", and finally "Static Routes".

2. Create a static route for other LAN IP address ranges, with the "Next Hop"
set to the *ZT* IP address on that *UDM-Pro*.

For the above example, the settings would be

| Network | Name | Distance | Destination Network | Next Hop |
| --- | --- | --- | --- | --- |
| A | Route to B | 1 | 192.168.2.0/24 | 182.168.191.2 |
| B | Route to A | 1 | 192.168.1.0/24 | 192.168.191.1 |