# Arch Linux Install

The starting point is the [Arch Linux Installation Guide](https://wiki.archlinux.org/title/Installation_guide).

Note that there is an installation script - [archinstall](https://wiki.archlinux.org/title/Archinstall) - but
it does have some limitations and is not as flexible as the manual installation process.

## Partitions

- ESP: Use Windows if on the same disk. Create another one otherwise. Format as FAT32. GUID: `C12A7328-F81F-11D2-BA4B-00A0C93EC93B`
- /boot: Format as ext4. GUID: `BC13C2FF-59E6-4262-A352-B275FD6F7172`
- /: Format as btrfs. GUID: `4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709`. Make it large enough for a swap file and snapshots (50GB + RAM size).
- /home: Format as btfrs. GUID: `B921B045-1DF0-41C3-AF44-4C6F280D3FAE`

## Encryption

Do it at the partition level. Use LUKS2. Use TPM2 for key storage.

## Bootloader

None. Use UEFISTUB, and Unified Kernel Images (UKI). As the ESP isn't encrypted, it is essential that everything there
is signed. The drawback is that in order to modify the launch options, the UKI must be re-generated and re-signed.

## Resources

Some useful additional resources:

- [orhun/arch_linux_installation.md](https://gist.github.com/orhun/02102b3af3acfdaf9a5a2164bea7c3d6): Notes on my Arch Linux installation
- [mjkstra/arch_linux_installation_guide.md](https://gist.github.com/mjkstra/96ce7a5689d753e7a6bdd92cdc169bae): Modern Arch linux installation guide
