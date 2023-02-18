# static-ip

This script ensures that a custom static IP address configuration
file is installed for the DHCP server used by UniFi OS,
[dnsmasq](https://thekelleys.org.uk/dnsmasq/doc.html).

It is useful for providing Ubiquiti devices on the local network with
a static IP address while still having them configured to use DHCP.

# Configuration

Edit the configuration file
[static-ip.conf](../config/static-ip/static-ip.conf)
as appropriate for the Ubiquiti devices on the local network.

As an example, a UniFi switch could be configured with a static IP by
adding lines similar to

```
# UniFi USW 48-port POE Switch
dhcp-host=AA:BB:CC:DD:EE:FF,192.168.1.6
```

Where `AA:BB:CC:DD:EE:FF` is the MAC address of the switch, and
`192.168.1.6` is the first available IP address in the local network range.

Comments can be placed in the configuration file to help the user remember
which MAC and IP addresses are associated with a particular device.
