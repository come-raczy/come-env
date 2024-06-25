#!/bin/env bash

# In order to create the configuration file with all the shared drives, run:
RCLONE_DIR=$(dirname $0)
CONFIG_FILE=$(date +"%Y-%M-%d_%H:%M:%S")_$$_rclone.conf
cp ${RCLONE_DIR}/rclone.conf "${RCLONE_DIR}/${CONFIG_FILE}"
rclone backend -o config drives come@omtx.ai:  >> "${RCLONE_DIR}/${CONFIG_FILE}"
rclone mount  come.raczy@gmail.com: "${HOME}/gdrive/perso" --daemon
rclone mount  come@omtx.ai: "${HOME}/gdrive/omtx/My Drive" --daemon
rclone mount  --config "${RCLONE_DIR}/${CONFIG_FILE}" AllDrives: "${HOME}/gdrive/omtx/Shared drives/" --daemon
