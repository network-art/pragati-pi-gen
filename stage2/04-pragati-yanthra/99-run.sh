cd ${ROOTFS_DIR}/lib/arm-linux-gnueabihf && ln -sf librt-2.28.so librt.so
cd ${ROOTFS_DIR}/usr/lib/arm-linux-gnueabihf && ln -sf ../../../lib/arm-linux-gnueabihf/librt-2.28.so librt.so
