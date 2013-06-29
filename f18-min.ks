#version=DEVEL

# Install OS instead of upgrade
install
# Use network installation
url --url="http://dl.fedoraproject.org/pub/fedora/linux/releases/18/Fedora/x86_64/os/"
# Lang
lang en_US.UTF-8

# System authorization information
auth --enableshadow --passalgo=sha512
# Root password
rootpw --plaintext fedora
# SELinux configuration
selinux --disabled


# Use text mode install
text
# Do not configure the X Window System
skipx


# Keyboard layouts
keyboard us
# System timezone
timezone Australia/Brisbane --isUtc


# Network information
network --onboot yes --device eth0 --bootproto dhcp --noipv6 --hostname=fedora.local
# Firewall configuration
firewall --enabled --service=ssh
# System services
services --disabled="sendmail" --enabled="network,sshd"


# Delete all paritions
clearpart --all --drives=sda
zerombr
# boot
part /boot --fstype=ext4 --size=500 --ondisk=sda --asprimary
# pv
part pv.00 --grow --size=1 --ondisk=sda --asprimary
# vg
volgroup vg pv.00
logvol / --name=root --vgname=vg --size=4000
logvol swap --name=swap --vgname=vg --size=256

# System bootloader configuration
bootloader --location=mbr --timeout=5 --boot-drive=sda

%packages --nobase
@core
%end

# reboot/halt
halt
