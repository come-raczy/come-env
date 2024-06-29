#
# ~/.bash_profile
#

export PATH=${PATH}:/usr/lib/jvm/java-21-openjdk/bin

[[ -f ~/.config/rclone/mount_gdrives.sh ]] && ~/.config/rclone/mount_gdrives.sh &

[[ -f ~/.bashrc ]] && . ~/.bashrc
