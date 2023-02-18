# letsencrypt

This script acquires valid encryption certificates from
[LetsEncrypt](https://letsencrypt.org) using
[acme.sh](https://github.com/acmesh-official/acme.sh)
and deploys them to the UniFi OS web services.

# Configuration

Edit the configuration file
[letsencrypt.conf](../config/letsencrypt/letsencrypt.conf)

Users must adjust the values for:
- `CERT_HOST`: the fully qualified domain name assigned to the UniFi host
- `CA_REGISTRATOIN_EMAIL`: email address to provide to the certificate authority
- DNS API settings: necessary data for a valid certificate request