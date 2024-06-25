#
# ~/.bash_profile
#

# In order to create the configuration file with all the shared drives, run:
# rclone backend -o config drives come@omtx.ai:  >> ~/.config/rclone/rclone.conf
rclone mount  come.raczy@gmail.com: "${HOME}/gdrive/perso" --daemon
rclone mount  come@omtx.ai: "${HOME}/gdrive/omtx/My Drive" --daemon
rclone mount  OmtxSharedDrives: "${HOME}/gdrive/omtx/Shared drives/" --daemon


[[ -f ~/.bashrc ]] && . ~/.bashrc
