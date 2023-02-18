#!/bin/sh
# scripts/systemd_install.sh
#
# Execute this script to create the systemd file to run
# all `enabled` scripts on startup
#
# Note: Scripts are only `available` until you `enable` them
# by creating a symlink in `scripts/enabled` to each file
# you want enabled in `scripts/available`
#
# For example:
# ln -s /data/unifios-utils/scripts/available/zerotier-one \
# /data/unifios-utils/scripts/enabled/zerotier-one
#
# Note: The systemd scripst executes everything in `enabled`
# by using the `run-parts` command.  This requires that
# scripts not end in `.sh` and use only specific characters
# in the file name.
#
DEBUG=1               # shows output to terminal if TRUE

cat > /etc/systemd/system/unifios-utils.service <<- "EOF"
# systemd unit for unifios-utils
# created by /data/unifios-utils/scripts/systemd_install.sh
#
[Unit]

Description=UniFiOS Utilities

After=default.target

[Service]

ExecStart=/bin/run-parts /data/unifios-utils/scripts/enabled

[Install]

WantedBy=default.target

EOF

systemctl enable unifios-utils.service
wait $!
if [ $DEBUG -eq 1 ]; then
  echo "unifios-utils.service is installed, starting it"
fi
systemctl start unifios-utils.service
if [ $DEBUG -eq 1 ]; then
  echo "The unifios-utils.service has started, it can take a few minutes to complete"
  echo "Its status can be followed by executing the command:"
  echo "journalctl -xfeu unifios-utils.service"
fi