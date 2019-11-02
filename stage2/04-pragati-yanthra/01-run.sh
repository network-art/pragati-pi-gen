#!/bin/bash -e

cd ${ROOTFS_DIR}/lib/arm-linux-gnueabihf && \
		ln -sf librt-2.28.so librt.so

cd ${ROOTFS_DIR}/usr/lib/arm-linux-gnueabihf && \
		ln -sf ../../../lib/arm-linux-gnueabihf/libpng12.so.0 libpng12.so && \
		ln -sf ../../../lib/arm-linux-gnueabihf/libpng12.so.0 libpng.so && \
		ln -sf ../../../lib/arm-linux-gnueabihf/libpthread.so.0 libpthread.so && \
		ln -sf ../../../lib/arm-linux-gnueabihf/librt-2.28.so librt.so && \
		ln -sf ../../../lib/arm-linux-gnueabihf/libz.so.1.2.11 libz.so

cp -v ${BASE_DIR}/../../third-party/symlinks/symlinks ${ROOTFS_DIR}/usr/bin/
