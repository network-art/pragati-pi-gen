#!/bin/bash -e

this_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

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
install -v -m 644 files/010_pragati-nopasswd "${ROOTFS_DIR}/etc/sudoers.d/"
install -v -m 644 files/issue                "${ROOTFS_DIR}/etc/"
install -v -m 644 files/issue.net            "${ROOTFS_DIR}/etc/"
install -v -m 644 files/ros-profile.sh       "${ROOTFS_DIR}/etc/profile.d/"
install -v -m 644 files/ros.ld.so.conf       "${ROOTFS_DIR}/etc/ld.so.conf.d/"
install -v -m 644 files/yanthra-profile.sh   "${ROOTFS_DIR}/etc/profile.d/"
install -v -m 644 files/yanthra.ld.so.conf   "${ROOTFS_DIR}/etc/ld.so.conf.d/"

echo "network={\
	ssid=\"GroboMac\"\
	psk=ac11d7744065093efa44637ebb060637ecf0f74f84386b84213b5fa3f73cedaa\
}\
" >> "${ROOTFS_DIR}/etc/wpa_supplicant/wpa_supplicant.conf"
