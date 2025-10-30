#!/bin/bash

# List of all built-in Neofetch logos to rotate randomly
logos=(
"AIX" "Alpine" "Anarchy" "Android" "Antergos" "antiX" "AOSC OS"
"AOSC OS/Retro" "Apricity" "ArcoLinux" "ArchBox" "ARCHlabs"
"ArchStrike" "XFerience" "ArchMerge" "Arch" "Artix" "Arya" "Bedrock"
"Bitrig" "BlackArch" "BLAG" "BlankOn" "BlueLight" "bonsai" "BSD"
"BunsenLabs" "Calculate" "Carbs" "CentOS" "Chakra" "ChaletOS"
"Chapeau" "Chrom*" "Cleandjaro" "ClearOS" "Clear_Linux" "Clover"
"Condres" "Container_Linux" "CRUX" "Cucumber" "Debian" "Deepin"
"DesaOS" "Devuan" "DracOS" "DarkOs" "DragonFly" "Drauger" "Elementary"
"EndeavourOS" "Endless" "EuroLinux" "Exherbo" "Fedora" "Feren" "FreeBSD"
"FreeMiNT" "Frugalware" "Funtoo" "GalliumOS" "Garuda" "Gentoo" "Pentoo"
"gNewSense" "GNOME" "GNU" "GoboLinux" "Grombyang" "Guix" "Haiku" "Huayra"
"Hyperbola" "janus" "Kali" "KaOS" "KDE_neon" "Kibojoe" "Kogaion"
"Korora" "KSLinux" "Kubuntu" "LEDE" "LFS" "Linux_Lite"
"LMDE" "Lubuntu" "Lunar" "macos" "Mageia" "MagpieOS" "Mandriva"
"Manjaro" "Maui" "Mer" "Minix" "LinuxMint" "MX_Linux" "Namib"
"Neptune" "NetBSD" "Netrunner" "Nitrux" "NixOS" "Nurunner"
"NuTyX" "OBRevenge" "OpenBSD" "openEuler" "OpenIndiana" "openmamba"
"OpenMandriva" "OpenStage" "OpenWrt" "osmc" "Oracle" "OS Elbrus" "PacBSD"
"Parabola" "Pardus" "Parrot" "Parsix" "TrueOS" "PCLinuxOS" "Peppermint"
"popos" "Porteus" "PostMarketOS" "Proxmox" "Puppy" "PureOS" "Qubes" "Radix"
"Raspbian" "Reborn_OS" "Redstar" "Redcore" "Redhat" "Refracted_Devuan"
"Regata" "Rosa" "sabotage" "Sabayon" "Sailfish" "SalentOS" "Scientific"
"Septor" "SereneLinux" "SharkLinux" "Siduction" "Slackware" "SliTaz"
"SmartOS" "Solus" "Source_Mage" "Sparky" "Star" "SteamOS" "SunOS"
"openSUSE_Leap" "openSUSE_Tumbleweed" "openSUSE" "SwagArch" "Tails"
"Trisquel" "Ubuntu-Budgie" "Ubuntu-GNOME" "Ubuntu-MATE" "Ubuntu-Studio"
"Ubuntu" "Venom" "Void" "Obarun"
)

# Pick one randomly
logo=${logos[$RANDOM % ${#logos[@]}]}

# Run Neofetch with that logo
neofetch --ascii_distro "$logo"

