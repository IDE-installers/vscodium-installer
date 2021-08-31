#!/usr/bin/bash 
set -e

## VSCodium installer for Linux and Mac written in bash

## This commands to install VSCodium are taker from:
# https://vscodium.com

# identify system package manager
configure(){
    if [ -e /usr/local/bin/brew ]; then PM=brew # <-- [P]ackage [M]anager

    elif [ -e /bin/snap ] || [ -e /usr/bin/snap ]; then PM=snap

    elif [ -e /bin/apt ] || [ -e /usr/bin/apt ]; then PM=apt

    elif [ -e /bin/dnf ] || [ -e /usr/bin/dnf ]; then PM=dnf

    elif [ -e /bin/yum ] || [ -e /usr/bin/yum ]; then PM=yum

    elif [ -e /bin/zypp ] || [ -e /usr/bin/zypp ]; then PM=zypper

    elif [ -e /bin/nix ] || [ -e /usr/bin/nix ]; then PM=nix

    elif [ -e /bin/aura ] || [ -e /usr/bin/aura ]; then PM=aura

    elif [ -e /bin/yay ] || [ -e /usr/bin/yay ]; then PM=yay

    elif [ -e /bin/flatpak ] || [ -e /usr/bin/flatpak ]; then PM=flatpak

    else 
        echo "Sorry, I can't install it for you, see 'https://vscodium.com' and install it by your self."
        exit 1
    fi
}

# install
install(){
    printf "\nInstalling VSCodium...\n"

    case $PM in
        brew)
            brew install --cask vscodium 
        ;;

        snap )
            snap install codium 
        ;;

        apt)
            wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \ | gpg --dearmor \ | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg 
            echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs vscodium main' \ | sudo tee /etc/apt/sources.list.d/vscodium.list 
            sudo apt update && sudo apt install codium 
        ;;

        dnf)
            sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg 
            printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg" |sudo tee -a /etc/yum.repos.d/vscodium.repo
            sudo dnf install codium
        ;;

        zypper)
            sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg 
            printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg" |sudo tee -a /etc/zypp/repos.d/vscodium.repo
            sudo zypper in codium
        ;;

        nix)
            nix-env -iA nixpkgs.vscodium 
        ;;

        aura)
            sudo aura -A vscodium-bin
        ;;

        yay)
            yay -S vscodium-bin
        ;;

        flatpak)
            flatpak install flathub com.vscodium.codium 
        ;;

    esac
}


# START
printf "VSCodium installer for Linux/Mac \n"
configure
install
