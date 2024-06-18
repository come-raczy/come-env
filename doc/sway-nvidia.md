# Sway on Nvidia

It doesn't work with the Nouveau driver. It keeps crashing and there soesn't seem to be
anything to do about it.

It does work with the nvidia driver, but there are several issues that need to be resolved:

- sway requires the additional --unsupported-gpu flag
- gdm will disable Wayland
- the cursor won't be visible
- there will be a lot of flickering
- requires additional commandline option: `nvidia_drm.modeset=1`

There is a whole page on [NVIDIA Troubleshooting]
(https://wiki.archlinux.org/title/NVIDIA/Troubleshooting)

## Forcing gdm to support Wayland

iThis is specified in `/usr/lib/udev/rules.d/61-gdm.rules`. Instead of editing that file,
the recommeded approach is to create a symbolic link:

    ln -s /dev/null /etc/udev/rules.d/61-gdm.rules

## Making the cursor visible

The hardware cursor needs to be disabled with an environment variable:

    export WLR_NO_HARDWARE_CURSORS=1

## Resolving flickering monitor

This requires the installation of `wlroots-nvidia`, a trivial patch.
Unfortunately, as of version 0.17.3, it is broken and requires some manual editing.
Yjhr rditing is trivial from the compilation error, but it's a process:

    tar -zxf wlroots-0.17.3.tar.gz
    vi wlroots-0.17.3/backend/drm/libliftoff.c
    mv wlroots-0.17.3.tar.gz wlroots-0.17.3.tar.gz.orig
    tar -zcf wlroots-0.17.3.tar.gz wlroots-0.17.3
    makepkg --skipchecksums --skippgpcheck -i

## Boot commandline options

Edit `/etc/kernel/cmdline` to add `nvidia-drm.modeset=1`:

    root=PARTUUID=5cfe5f46-3580-42ed-8506-6dfe32b45083 zswap.enabled=0 rw rootfstype=ext4 nvidia-drm.modeset=1

Then run `sudo mkinitcpio -P`.
