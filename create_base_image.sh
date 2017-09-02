#!/bin/bash
# create_base_image.sh
# OSMC version to download
#OSMC_VERSION=20170803
OSMC_VERSION=20160910
OSMC_URL="http://download.osmc.tv/installers/diskimages/OSMC_TGT_rbp2_${OSMC_VERSION}.img.gz"
DOWNLOAD_DIR=/home/pi/osmc
EXTRACT_DIR=./
MOUNT_DIR=/home/pi/osmc/mnt
LOOP_DEV=/dev/loop1 # Loop device used for mounting .img file
# create directories
mkdir -p "${DOWNLOAD_DIR}"
mkdir -p "${EXTRACT_DIR}"
mkdir -p "${MOUNT_DIR}"
# get image from web
curl -L "$OSMC_URL" -o "${DOWNLOAD_DIR}/OSMC_${OSMC_VERSION}.img.gz"
gunzip "${DOWNLOAD_DIR}/OSMC_${OSMC_VERSION}.img.gz" # extract image
# mounting image
sudo losetup -P "${LOOP_DEV}" "${DOWNLOAD_DIR}/OSMC_${OSMC_VERSION}.img"
sudo mount "${LOOP_DEV}p1" "${MOUNT_DIR}"
# copy OSMC filesystem
cp -f "${MOUNT_DIR}/filesystem.tar.xz" "${EXTRACT_DIR}"
# unmount image
sudo umount "${MOUNT_DIR}"
sudo losetup -d "${LOOP_DEV}"
rm -f "${DOWNLOAD_DIR}/OSMC_${OSMC_VERSION}.img" # remove image
# create the docker image from the filesystem
# create the OSMC base image
cat "${EXTRACT_DIR}/filesystem.tar.xz" | docker import - "codafog/osmc-rpi:base_${OSMC_VERSION}"
rm -f "${EXTRACT_DIR}/filesystem.tar.xz" # remove filesystem
