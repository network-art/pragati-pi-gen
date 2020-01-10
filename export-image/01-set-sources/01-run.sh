#!/bin/bash -e

on_chroot << EOF
apt-get update
EOF

if [ "${DIST_UPGRADE}" = "1" ]; then
	echo "Performing dist-upgrade"
	on_chroot << EOF
apt-get -y dist-upgrade
EOF
else
	echo "dist-upgrade is turned off"
fi

on_chroot << EOF
apt-get clean
EOF
