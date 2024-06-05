# Add Windows to systemd-boot

This guide will show you how to add Windows to systemd-boot.
It should work directly if the windows partition is on the same disk as the linux partition.
For the case where the Windows partition is different, the general idea is to add a new entry in the boot loader configuration file that points to the Windows EFI file.
In order to do this, you need to know the partition where the Windows EFI file is located. This requires an EFI shell.

The assumption is that the Windows EFI partition is on `nvme0n1p1` and that the EFI partition where `systemd-boot`
is installed has been mounted under `/efi`.

## Install an EFI shell

Don't do it from Ubuntu, because the shell will be installed in the efi partition. Instead, use edk2-shell from the AUR.

    sudo pacman -S edk2-shell

And then copy the shell to the EFI partition.

    sudo cp /usr/share/edk2-shell/x64/Shell.efi /efi/Shell_x64.efi

## Identify the Windows EFI partition PARTUUID

The PARTUUID of the Windows ESP partition can be found with `lsblk -f` or `blkid`:

    sudo blkid | grep vfat

The result is something like:

    dev/nvme0n1p1: UUID="A443-CB07" BLOCK_SIZE="512" TYPE="vfat" PARTLABEL="EFI system partition" PARTUUID="a1f6f763-a471-4263-9b6a-34e4e3a7334e"

Add `console-mode max` to the `esp/loader/loader.conf`. Reboot, and choose the EFI shell from the boot menu
(this is why we need to install edk2-shell). From there, identify the FS alias corresponding to the PARTUUID
of the Windows ESP partition. It can be something lije `HD2c`, or `HD0a66666a2`. Enter `exit` and boot into
Linux again.

## Create a loader entry for Windows

Create a file `/efi/windows.nsh` (replace `HD2c` with the FS alias of the Windows ESP partition):

    echo HD2c:EFI\Microsoft\Boot\Bootmgfw.efi > /efi/windows.nsh

Now create a loader entry `/efi/loader/entries/windows.conf` for that Windows Installation:

    title Windows
    efi /Shell_x64.efi
    options -nointerrupt -noconsolein -noconsoleout windows.nsh

See [Add a systemd-boot loader Menu entry for a Windows installation using a separate ESP Partition]
(https://forum.endeavouros.com/t/tutorial-add-a-systemd-boot-loader-menu-entry-for-a-windows-installation-using-a-separate-esp-partition/37431)
for more information.

## [Installation using XBOOTLDR](https://wiki.archlinux.org/title/systemd-boot#Installation_using_XBOOTLDR)

This enables having a seprate `/boot` partition of type "Linux extended boot" (XBOOTLDR), which is useful for dual-booting with Windows when the ESP is too small.
The partition must have a GUID of `bc13c2ff-59e6-4262-a352-b275fd6f7172` (`ea00` for `gdisk`) and large enough to accomodate all the kernels.

During install, mount ESP to `/mnt/efi`, and XBOOTLDR to `/mnt/boot`. Once in `chroot`, use:

    bootctl --esp-path=/efi --boot-path=/boot install
