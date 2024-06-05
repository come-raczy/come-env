# UEFI Dual Boot

## Introduction

See [UEFI boot: how does that actually work, then?](https://www.happyassassin.net/posts/2014/01/25/uefi-boot-how-does-that-actually-work-then/).

This guide will show you how to install Windows 10 and Ubuntu 20.04 on a UEFI system. The guide assumes that Windows 11 is already installed.

The partition type GUID for UEFI systems is `C12A7328-F81F-11D2-BA4B-00A0C93EC93B` (EFI System Partition with `fdist`, partition type `EF00` with `gdisk`, or simply ESP flag set with `parted`).

## Kernel configuration

In order to allow EFI firmware to load the kernel as an EFI executable, [EFISTUB](https://wiki.archlinux.org/title/EFISTUB) must be enabled
(default on Arch Linux kernels, otherwise, add `CONFIG_EFI_STUB=y` to the kernel configuration).

## Managing UEFI boot entries

This is done with `efibootmgr`. For instance, `efibootmgr -v` will list all boot entries.

A typical entry for a full UEFI native boot looks like this:

    Boot0002* Fedora        HD(1,800,61800,6d98f360-cb3e-4727-8fed-5ce0c040365d)File(\EFI\fedora\grubx64.efi)

Where:

- `Boot0002` is the boot entry number
- `*` indicates that this is the current boot entry
- `Fedora` is the name of the boot entry
- `HD(1,800,61800,6d98f360-cb3e-4727-8fed-5ce0c040365d)` is the device path (see [EFI_DEVICE_PATH_PROTOCOL](https://uefi.org/specs/UEFI/2.10/10_Protocols_Device_Path_Protocol.html))
- `File(\EFI\fedora\grubx64.efi)` is the file path

A typical command to add a boot entry looks like this:

    efibootmgr -c -L "Arch Linux" -l \EFI\archlinux\vmlinuz-linux.efi -u "root=/dev/sdaX ro radeon.audio=1 initrd=/initramfs-linux.img"

If `efibootmgr` needs help to find the ESP, use the `-d` (disk) and `-p` (partition) options.

The loader (`-l` option) can be specified as `/vmlinuz-linux`. The unicode (`-u` option) initrd parameter must be passed
as `initrd=\initramfs-linux.img`, using backslashes (`\`) as path separators (see [Kernel Parameters - Parameter list](https://wiki.archlinux.org/title/Kernel_parameters#Parameter_list)).

## Fallback path

When a boot entry doesn't specify anything the firmware will look through each EFI system partition on the disk
in the order they exist on the disk. Within the ESP, it will look for a file with a specific name and
location. On an x86-64 PC, it will look for the file \EFI\BOOT\BOOTx64.EFI. What it actually looks for
is \EFI\BOOT\BOOT{machine type short-name}.EFI - 'x64' is the "machine type short-name" for x86-64 PCs.
The other possibilities are BOOTIA32.EFI (x86-32), BOOTIA64.EFI (Itanium), BOOTARM.EFI (AArch32 - that
is, 32-bit ARM) and BOOTAA64.EFI (AArch64 - that is, 64-bit ARM). It will then execute the first
qualifying file it finds (obviously, the file needs to be in the executable format defined in the UEFI
specification).

This provides the means to boot removable disks.

## Configuring systemd

It is in the files `/etc/systemd/system/efistub-update.{path,service}`. The important thing is to make sure that the mount point for the ESP is correct (e.g. `/efi` or `/boot`).

## Extended Bootloader (XBOOTLDR)

Probably relevant only for `systemd-boot`.
