#! /bin/sh
# Script that auto configures and installs all software I use on my arch ;)
# shebang!


TMP_FOLDER="arch_config"
RST_PATH="$HOME/$TMP_FOLDER"
AFTER_INSTALL_INSTRUCTIONS="$HOME/AAC_WHAT_NOW.txt"
GPU_VENDOR=""


STEAM="0"
MINECRAFT="0"
LATEX="0"
EMULATORS="0"
ASEPRITE="0"
BETTERBIRD="0"
NEOTHESIA="0"
RUST="0"


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

PACMAN_PACKAGES=(
	neovim
	xorg
	wayland
	uwsm
	hyprland
	waybar
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
	tailscale
	swww
	shotcut
	ripgrep
	redshift
	reaper
	raylib
	odin
	qutebrowser
	qt6ct
	qt5ct
	qt5-wayland
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
	bat
	audacity
	zathura
	zathura-pdf-mupdf
)

PARU_PACKAGES=(
	anki-bin
	auto-cpufreq
	blockbench-bin
	bluetuith-bin
	brave-bin
	librewolf-bin
	proton-ge-custom-bin
	tofi
	vesktop-bin
	xpadneo-dkms
)

clear

echo "Welcome to auto_arch_conf"
echo "ver2025.07.25"
echo "bk"
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""
echo "Prerequisites: You have a minimal Arch Linux install with the linux-zen kernel"
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""

echo "GPU?"
echo "1) INTEL [thinkpad x220]"
echo "2) AMD [thinkpad t14]"
echo "3) NVIDIA TURING+ [acer NITRO RTX 3060]"
read -rp "Choice (1-3): " choice


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
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "$GPU_VENDOR chosen"
echo "needed drivers will be installed"
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "Install steam?"
read -rp "[ Y/n ]: " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
	STEAM="1"
fi
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "Install LaTeX? (texlive, biber)"
read -rp "[ Y/n ]: " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
	LATEX="1"
fi
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "Compile aseprite?"
read -rp "[ Y/n ]: " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
	ASEPRITE="1"
fi
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "Install minecraft launcher? (prismlauncher)"
read -rp "[ Y/n ]: " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
	MINECRAFT="1"
fi
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "Install emulators? (pcsx2, rpcs3, xnp2)"
read -rp "[ Y/n ]: " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
	EMULATORS="1"
fi
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "Install mail client? (betterbird-bin)"
read -rp "[ Y/n ]: " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
	BETTERBIRD="1"
fi
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "Compile neothesia?"
read -rp "[ Y/n ]: " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
	NEOTHESIA="1"
fi
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "Install RUST Lang?"
read -rp "[ Y/n ]: " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
	RUST="1"
fi
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "Configuration started!"
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


cd $HOME
echo "creating temporary $TMP_FOLDER at $HOME"
mkdir $TMP_FOLDER
cd $RST_PATH
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "updating system"
sudo pacman -Syu
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "ensuring base are installed"
sudo pacman -S --needed $BASE_PACKAGES
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "installing git"
sudo pacman -S --needed git
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "downloading paru-bin"
git clone https://aur.archlinux.org/paru-bin.git
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "downloading dotfiles"
git clone https://github.com/barysk/dot_hyprland
git clone https://github.com/barysk/nvim
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "installing paru-bin"
cd paru-bin
makepkg -sri
cd $RST_PATH
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "applying dotfiles"
# nvim
cd nvim
rm -rf .git
cd ..
mv nvim $HOME/.config/
# hypr
cd dot_hyprland
rm -rf .git
cd ..
mv dot_hyprland/dot_config/* $HOME/.config/
mv dot_hyprland/dot_fonts $HOME/.fonts
mv dot_hyprland/dot_bashrc $HOME/.bashrc
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "Installing GPU drivers"
case "$GPU_VENDOR" in
	intel)
		sudo pacman -S --needed "${INTEL_PACKAGES[@]}"
		;;
	amd)
		sudo pacman -S --needed "${AMD_PACKAGES[@]}"
		;;
	nvidia)
		sudo pacman -S --needed "${NVIDIA_PACKAGES[@]}"
		;;
esac
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "Installing packages using pacman"
sudo pacman -S --needed "${PACMAN_PACKAGES[@]}"

if [[ "$STEAM" == "1" ]]; then
	sudo pacman -S --needed steam
fi

if [[ "$LATEX" == "1" ]]; then
	sudo pacman -S --needed texlive-most biber
fi

if [[ "$MINECRAFT" == "1" ]]; then
	sudo pacman -S --needed prismlauncher
fi

if [[ "$RUST" == "1" ]]; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

	if ! grep -Fq 'source "$HOME/.cargo/env"' "$HOME/.bashrc"; then
		echo "" >> "$HOME/.bashrc"
		echo "# For Rust" >> "$HOME/.bashrc"
		echo 'source "$HOME/.cargo/env"' >> "$HOME/.bashrc"
		echo "\$HOME/.cargo/env added to $HOME/.bashrc"
	fi
fi

echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "downloading packages using paru"
paru -S --needed "${PARU_PACKAGES[@]}"

if [[ "$ASEPRITE" == "1" ]]; then
	paru -S --needed aseprite
fi

if [[ "$BETTERBIRD" == "1" ]]; then
	paru -S --needed betterbird-bin
fi

if [[ "$NEOTHESIA" == "1" ]]; then
	paru -S --needed neothesia
fi

echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "removing $TMP_FOLDER at $HOME"
cd $HOME
rm -rf $TMP_FOLDER
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "building modules for waybar"
cd $HOME/.config/waybar/src_modules/
./build_modules.sh
cd $HOME
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "updating tldr"
tldr --update
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "setting up auto-cpufreq"
sudo auto-cpufreq --install
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "All done!"
echo ""
WHAT_NOW='
What now?
1. Use [ hyprctl monitors all ] to get the name of your monitor and write it to $HOME/.config/hypr/hyprvars.conf in the default_monitor
2. Go to /etc/bluetooth/main.conf and set AutoEnable=false so that Bluetooth is turned off by default
3. Eduroam? Yeah, you need to enable legacy support
Check connection details first with your institution before applying any profiles listed in this section. Example profiles are not guaranteed to work or match any security requirements.
When storing connection profiles unencrypted, it is recommended to restrict read access to the root account by specifying chmod 600 profile as root.
If authentication keeps failing with NetworkManager, try setting phase1-auth-flags=32 for TLS 1.0 or phase1-auth-flags=64 for TLS 1.1, as described in [2] and NetworkManager#WPA Enterprise connections fail to authenticate with OpenSSL "unsupported protocol" error.

Links:
- Wiki
https://wiki.archlinux.org/title/Network_configuration/Wireless
- NetworkManager#WPA Enterprise connections fail to authenticate with OpenSSL "unsupported protocol" error
https://wiki.archlinux.org/title/NetworkManager#WPA_Enterprise_connections_fail_to_authenticate_with_OpenSSL_%22unsupported_protocol%22_error
- Eduroam Configuration Assistant Tool
https://cat.eduroam.org/
'
echo "$WHAT_NOW"

echo "$WHAT_NOW" > "$AFTER_INSTALL_INSTRUCTIONS"

echo "those instructions are saved to $AFTER_INSTALL_INSTRUCTIONS"
echo ""
echo "before you do this reboot is advised"
echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
echo ""


echo "Reboot?"
read -rp "[ Y/n ]: " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
	reboot
fi
