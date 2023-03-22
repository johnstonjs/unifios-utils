# UniFi OS Utilities

This collection of scripts enables running various utilities on the full range of
UniFi products that support UniFi OS 2.0 & 3.0.

With the release of [UniFi OS 2.0 & 3.0](https://community.ui.com/releases),
[prior collections](https://github.com/unifi-utilities/unifios-utilities) of tools built using
[docker](https://docker.io) are no longer functional or necessary.  The new versions of 
*UniFi OS* are based on [Debian](https://debian.org) and uses the same package
management system.  New packages can be installed by simply using `apt`.

The one significant change from a standard Debian-based system is that installed
software will not necessarily persist across firmware updates.  The folders `/data` 
and `/etc` both persist across firmware updates, so some amount of customization is
still needed to ensure that desired packages remain installed.  This respository
provides scripts that will allow various utilities to be installed and persist
across reboots and firmware updates.

## Overview

This repository should be downloaded into the `/data/` folder on a *UniFi OS* system,
for example:

```
apt -y install git
cd /data
git clone https://github.com/johnstonjs/unifios-utils.git
```

Alternately, users can fork to a private repository and create different branches
for every UniFi OS devices they want to configure.

Configuration for each script is provided in [config](../config).  Before executing
any of the scripts, users should edit the configuration files appropriately.  Documentation
for each is provided in [doc](../doc).

The collection of scripts uses a single [systemd](https://github.com/systemd/systemd)
*service* to execute scripts for individual utilities specified by the user.

Scripts located in `available` are not executed unless they have a corresponding symlink in `enabled`.  For example:

```
ln -s /data/unifios-utils/scripts/available/apt-install-packages /data/unifios-utils/scripts/enabled/apt-install-packages
ln -s /data/unifios-utils/scripts/available/letsencrypt /data/unifios-utils/scripts/enabled/letsencrypt
ln -s /data/unifios-utils/scripts/available/zerotier-one /data/unifios-utils/scripts/enabled/zerotier-one
```

The *systemd service* should then be installed and run by executing:

```
/data/unifios-utils/scripts/systemd_install.sh
```

Executing this script will install a *systemd service* that persists across reboots
and firmware updates, and it will execute each script symlinked into `enabled`.

## Supported Utilities

The supported utilities are
- ZeroTier
- LetsEncrypt Certificates
- APT Package Installation
- Static IP Addresses for Ubiquiti Devices

## Supported Devices

These scripts have been tested on the following devices

- UniFi Dream Machine Pro (UDM-Pro)
- UniFi Cloud Key Gen2 Plus (UCK-G2-Plus)

Persistence on UDM-Pro was confirmed on 22 Mar 2023 upgrading from 2.4.27 to 2.5.17.
It took nearly 10 minutes before the unifios-utils *systemd* service executed, likely
due to the startup times for UDM-Pro web services.

## Warning / Feedback

These scripts are provided without any warranty.  Use at your own risk.

If you are experiencing an issue feel free to file a bug report.  I'd welcome
assistance in making the scripts more useful/rigorous as well.
