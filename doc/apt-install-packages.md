# apt-install-packages

This script ensures the installation of specified packages from
configured *apt* repositories.  It is intended to allow simple
command-line utilities that are not installed on UniFi devices
by default to persist.

## Configuration

Edit the configuration file
[apt-install-packages.conf](../config/apt-install-packages/apt-install-packages.conf)
with a list of desired packages, each package name on a new line.

For example, to install 'git' and 'nano', the file should contain:
```
git
nano
```

The script will install all dependencies for any listed package, so users
should be careful that the configured packages don't create issues on
the UniFi device.  It is **highly** recommended to manually install
any desired packages first, before including them in the configuration file.