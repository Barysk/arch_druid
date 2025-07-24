# Script that auto configures and installs all software I use on my arch ;)
	# shebang!

#! /bin/sh


TMP_FOLDER="arch_config"
RST_PATH="$HOME/$TMP_FOLDER"

GPU_VENDOR=""

INTEL_PACKAGES=(
	vulkan-intel
	lib32-vulkan-intel
	xf86-video-intel
)

AMD_PACKAGES=(
	vulkan-radeon
	lib32-vulkan-radeon
	xf86-video-amdgpu
)

# you probably don't need it
# amdvlk

NVIDIA_PACKAGES=(
	nvidia-open-dkms
	nvidia-utils
	lib32-nvidia-utils
)

BASE_PACKAGES=(
	base
	base-devel
	linux-zen-headers
)

# TODO: separate for readability
PACMAN_PACKAGES=(
	neovim
	xorg
	wayland
	uwsm
	hyprland
	man-db
	xdg-desktop-portal-gtk
	xdg-desktop-portal-hyprland
	udisks2
	tree-sitter-cli
	tree
	tmux
	tldr
	timidity++
	freepats-general-midi
	gtk3
	gtk4
	thermald
	texlive
	tailscale
	swww
	steam
	shotcut
	ripgrep
	redshift
	reaper
	raylib
	odin
	qutebrowser
	qt6ct
	qt5ct
	qt5ct-wayland
	qjackctl
	qbittorrent
	pipewire
	alsa-utils
	lib32-pipewire
	pipewire-alsa
	lib32-alsa-plugins
	pipewire-jack
	lib32-pipewire-jack
	pipewire-pulse
	playerctl
	prismlauncher
	sof-firmware
	wireplumber
	lib32-mesa
	wl-clipboard
	wine-staging
	wine-mono
	xf86-video-vesa
	pcmanfm-gtk3
	pavucontrol
	papirus-icon-theme
	obs-studio
	telegram-desktop
	nwg-look
	networkmanager
	network-manager-applet
	mpv
	materia-gtk-theme
	mako
	lutris
	kvantum
	krita
	kitty
	jp2a
	imv
	imagemagick
	hyprsunset
	hyprshot
	hyprpolkitagent
	hyprlock
	htop
	btop
	gst-plugin-pipewire
	github-cli
	fzf
	fastfetch
	electron
	dust
	clang
	docker
	carla
	brightnessctl
	bluez
	bluez-utils
	biber
	bat
	audacity
)

PARU_PACKAGES=(
	anki-bin
	aseprite
	auto-cpufreq
	postbird-bin
	blockbench-bin
	bluetuith-bin
	brave-bin
	librewolf-bin
	proton-ge-custom-bin
	tofi
	vesktop-bin
	xpadneo-dkms
	pcsx2-latest-bin
	rpcs3-bin
)

# Probably unneded paru packages
# betterbird-bin
# electron6-bin
# giblib
# httpdirfs
# mpvpaper
# neothesia
# pixelorama-bin
# ttf-mplus-git
# ucl
# vscodium-bin
# xnp2


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

echo "ensuring base are installed"
sudo pacman -S $BASE_PACKAGES


echo "installing git"
sudo pacman -S git


echo "downloading paru-bin"
git clone https://aur.archlinux.org/paru-bin.git


echo "downloading dotfiles"
git clone https://github.com/barysk/dot_hyprland
git clone https://github.com/barysk/nvim


echo "installing paru-bin"
cd paru-bin
makepkg -sri
cd $RST_PATH


echo "applying dotfiles"

# nvim
cd nvim
rm -rf .git
cd ..
mv nvim $HOME/.config/

# hypr # TODO compile modules
cd dot_hyprland
rm -rf .git
cd ..
mv dot_hyprland/dot_config/* $HOME/.config/
mv dot_hyprland/dot_fonts $HOME/.fonts
mv dot_hyprland/dot_bashrc $HOME/.bashrc


case "$GPU_VENDOR" in
	intel)
		pacman -S "${INTEL_PACKAGES[@]}"
		;;
	amd)
		pacman -S "${AMD_PACKAGES[@]}"
		;;
	nvidia)
		pacman -S "${NVIDIA_PACKAGES[@]}"
		;;
esac


echo "downloading packages using pacman"
pacman -S "${PACMAN_PACKAGES[@]}"


echo "downloading packages using paru"
paru -S "${PARU_PACKAGES[@]}"


echo "removing $TMP_FOLDER at $HOME"
cd $HOME
rm -rf $TMP_FOLDER

echo "updating tldr"
tldr --update

echo "setting up auto-cpufreq"
sudo auto-cpufreq install

echo "All done!"

