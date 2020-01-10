#!/bin/bash -e

this_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

on_chroot << EOF
systemctl disable dphys-swapfile
EOF

cd ${ROOTFS_DIR}/lib/arm-linux-gnueabihf && \
		ln -sf librt-2.28.so librt.so

cd ${ROOTFS_DIR}/usr/lib/arm-linux-gnueabihf && \
		ln -sf ../../../lib/arm-linux-gnueabihf/libbz2.so.1.0 libbz2.so && \
		ln -sf ../../../lib/arm-linux-gnueabihf/libm.so.6 libm.so && \
		ln -sf ../../../lib/arm-linux-gnueabihf/libdl.so.2 libdl.so && \
		ln -sf ../../../lib/arm-linux-gnueabihf/libpng12.so.0 libpng12.so && \
		ln -sf ../../../lib/arm-linux-gnueabihf/libpng12.so.0 libpng.so && \
		ln -sf ../../../lib/arm-linux-gnueabihf/libpthread.so.0 libpthread.so && \
		ln -sf ../../../lib/arm-linux-gnueabihf/librt-2.28.so librt.so && \
		ln -sf ../../../lib/arm-linux-gnueabihf/libz.so.1.2.11 libz.so

cd ${this_dir}
mkdir -p ${ROOTFS_DIR}/etc/pragati
mkdir -p ${ROOTFS_DIR}/usr/local/yanthra
# We will first remove existing run-time data and then recreate directories.
rm -rf ${ROOTFS_DIR}/var/yanthra
mkdir -p ${ROOTFS_DIR}/var/yanthra/{debug,input,output}
on_chroot <<EOF
chown -R $FIRST_USER_NAME:$FIRST_USER_NAME /var/yanthra
EOF

cp -v             files/etc_profile          "${ROOTFS_DIR}/etc/profile"
install -v -m 644 files/010_pragati-nopasswd "${ROOTFS_DIR}/etc/sudoers.d/"
install -v -m 644 files/clid.service         "${ROOTFS_DIR}/lib/systemd/system/"
install -v -m 644 files/issue                "${ROOTFS_DIR}/etc/"
install -v -m 644 files/issue.net            "${ROOTFS_DIR}/etc/"
install -v -m 644 files/realsense-profile.sh "${ROOTFS_DIR}/etc/profile.d/"
install -v -m 644 files/realsense.ld.so.conf "${ROOTFS_DIR}/etc/ld.so.conf.d/"
install -v -m 644 files/ros-profile.sh       "${ROOTFS_DIR}/etc/profile.d/"
install -v -m 644 files/ros.ld.so.conf       "${ROOTFS_DIR}/etc/ld.so.conf.d/"
install -v -m 644 files/services             "${ROOTFS_DIR}/etc/"
install -v -m 644 files/yanthra-profile.sh   "${ROOTFS_DIR}/usr/local/yanthra/"
install -v -m 644 files/yanthra.ld.so.conf   "${ROOTFS_DIR}/etc/ld.so.conf.d/"
install -v -m 755 files/rc.local             "${ROOTFS_DIR}/etc/"

on_chroot <<EOF
systemctl enable clid
systemctl stop wpa_supplicant
systemctl disable wpa_supplicant
systemctl stop dnsmasq
systemctl disable dnsmasq
systemctl stop hostapd
systemctl disable hostapd
EOF
