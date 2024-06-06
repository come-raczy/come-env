# Secure Boot

## Introduction

Well documented in [Secure Boot](https://wiki.archlinux.org/index.php/Secure_Boot) (Arch Linux).

## Signing

When the system is updated, it is essential to have the new in itramfs, modules, drivers, and kernel images signed.

When booting directly from an [Unified kernel image](https://wiki.archlinux.org/index.php/Unified_kernel_image), the appropriate method depends on the
solution selected to prepare the UKI (`mkinitcpio`, `kernel-install`, `dracut`, `sbctl`, `ukify`, or manually.

When preparing the UKI with mkinitcpio or ukify, automated signing functions are available with the `sbsign` tool, which is part of the `sbsigntools` package.

## Resources

- [Secure Boot](https://wiki.archlinux.org/index.php/Secure_Boot) (Arch Linux)
- [Secure Boot](https://www.happyassassin.net/posts/2014/01/25/uefi-secure-boot-in-fedora-its-coming/) (Fedora)
- [Secure Boot](https://wiki.debian.org/SecureBoot) (Debian)
- [Secure Boot](https://wiki.ubuntu.com/UEFI/SecureBoot) (Ubuntu)
- [Secure Boot](https://wiki.gentoo.org/wiki/Sakaki%27s_EFI_Install_Guide/Configuring_Secure_Boot) (Gentoo)
- [Secure Boot](https://wiki.centos.org/HowTos/UEFI) (CentOS)
- [Secure Boot](https://wiki.freebsd.org/SecureBoot) (FreeBSD)
- [Secure Boot](https://wiki.openwrt.org/doc/techref/bootloader/secure-boot) (OpenWrt)
- [Secure Boot](https://www.suse.com/documentation/sles-12/book_sle_admin/data/sec_uefi_secureboot.html) (SUSE)
- [Secure Boot](https://www.redhat.com/en/blog/secure-boot-secure-boot-what-it-means-red-hat-enterprise-linux) (Red Hat)
- [Secure Boot](https://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface#Secure_boot) (Wikipedia)
