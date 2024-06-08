# Arch Linux Install

The starting point is the [Arch Linux Installation Guide](https://wiki.archlinux.org/title/Installation_guide).

Note that there is an installation script - [archinstall](https://wiki.archlinux.org/title/Archinstall) - but
it does have some limitations and is not as flexible as the manual installation process.

## Partitions

- ESP: Use Windows if on the same disk. Create another one otherwise. Format as FAT32. GUID: `C12A7328-F81F-11D2-BA4B-00A0C93EC93B`
- /boot: Format as vfat. GUID: `bc13c2ff-59e6-4262-a352-b275fd6f7172` (ea00 type for gdisk)
- /: Format as btrfs. GUID: `4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709`. Make it large enough for a swap file and snapshots (50GB + RAM size).
- /home: Format as btfrs. GUID: `B921B045-1DF0-41C3-AF44-4C6F280D3FAE`

## Encryption

Do it at the partition level. Use LUKS2. Use TPM2 for key storage.

## Keys

See [Package Signing](https://wiki.archlinux.org/title/Pacman/Package_signing).

Typical commands might include:

    sudo ntpdate -vu time.nist.gov
    rm -R /etc/pacman.d/gnupg/
    rm -R /root/.gnupg/
    rm -R ~/.gnupg/
    gpg --refresh-keys
    pacman-key --init
    pacman-key --populate archlinux
    pacman-key --refresh-keys
    pacman -Ss archlinux-keyring


## Bootloader

Ideally, none. Use UEFISTUB, and Unified Kernel Images (UKI). As the ESP isn't encrypted, it is essential that everything there
is signed. The drawback is that in order to modify the launch options, the UKI must be re-generated and re-signed.

In practice, the UEFI boot manager might be bad, in which case, use `systemd-boot`:

    bootctl install

This will complain that the efi partition is world-accessible.

If Windows causes problems, check the [Windows changes boot order](https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface#Windows_changes_boot_order) 
section of the UEFI page in the Wiki.

This is what worked on the laptop: telling the Windows boot loader to run the systemd bootloader, from a Windows administrator command:

    bcdedit /set "{bootmgr}" path "\EFI\systemd\systemd-bootx64.efi"

## Network

Install iwd in the list of additional packages

    pacman -Suy iwd

Edit `/etc/iwd/main.conf` to tell iwd to used its own dhcp client:

    [General]
    EnableNetworkConfiguration=true

enable and start iwd:

    systemctl enable iwd
    systemstl start iwd

Connect to the WiFi

    iwctl station wlan0 scan
    iwctl station wlan0 get-networks
    iwctl station wlan0 connect <my-network> --passphrase 12345678909
    iwctl station wlan0 show



## Resources

Some useful additional resources:

- [orhun/arch_linux_installation.md](https://gist.github.com/orhun/02102b3af3acfdaf9a5a2164bea7c3d6): Notes on my Arch Linux installation
- [mjkstra/arch_linux_installation_guide.md](https://gist.github.com/mjkstra/96ce7a5689d753e7a6bdd92cdc169bae): Modern Arch linux installation guide
