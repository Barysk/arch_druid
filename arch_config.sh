# Script that auto configures and installs all software I use on my arch ;)
# shebang!

#! /bin/sh


TMP_FOLDER="arch_config"
RST_PATH="$HOME/$TMP_FOLDER"
GPU_VENDOR=""


echo "GPU?"
echo "1) INTEL [thinkpad x220]"
echo "2) AMD [thinkpad t14]"
echo "3) NVIDIA RTX 30+ [acer NITRO RTX 3060]"
read -rp "Enter choice (1-3): " choice


case "$choice" in
    1)
        GPU_VENDOR="intel"
        ;;
    2)
        GPU_VENDOR="amd"
        ;;
    3)
        GPU_VENDOR="nvidia"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac


echo ""
echo "$GPU_VENDOR chosen"
echo "needed drivers will be installed"


cd $HOME
echo "creating temporary $TMP_FOLDER at $HOME"
# TODO check if exists
mkdir $TMP_FOLDER
cd $RST_PATH


# echo "updating system"
# sudo pacman -Syu


# echo "installing git"
# sudo pacman -S git


echo "downloading paru-bin"
git clone https://aur.archlinux.org/paru-bin.git


echo "installing paru-bin"
cd paru-bin
makepkg -sri


cd $RST_PATH

