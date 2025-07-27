#!/bin/bash
# Script that auto configures and installs all software I use on my arch ;)
# shebang!

MSG_VELCOME="Druid velcomes you!
He will install my dotfiles and the applications I use.
You will be prompted with some queries thus Please don't leave until the Druid
is done.

ver2025.07.27
bk"

MSG_BYE='What now?
1. Use [ hyprctl monitors all ] to get the name of your monitor and write it to
$HOME/.config/hypr/hyprvars.conf in the default_monitor
2. Go to /etc/bluetooth/main.conf and set AutoEnable=false so that Bluetooth is
turned off by default
3. Eduroam? Yeah, you need to enable legacy support
Check connection details first with your institution before applying any
profiles listed in this section. Example profiles are not guaranteed to work or
match any security requirements.
When storing connection profiles unencrypted, it is recommended to restrict
read access to the root account by specifying chmod 600 profile as root.
If authentication keeps failing with NetworkManager, try setting
phase1-auth-flags=32 for TLS 1.0 or phase1-auth-flags=64 for TLS 1.1, as
described in [2] and NetworkManager#WPA Enterprise connections fail to
authenticate with OpenSSL "unsupported protocol" error.

Links:
> Wiki
  https://wiki.archlinux.org/title/Network_configuration/Wireless
> NetworkManager#WPA Enterprise connections fail to authenticate with OpenSSL
"unsupported protocol" error
  https://wiki.archlinux.org/title/NetworkManager#WPA_Enterprise_connections_fail_to_authenticate_with_OpenSSL_%22unsupported_protocol%22_error
> Eduroam Configuration Assistant Tool
  https://cat.eduroam.org/'

TMP_FOLDER="arch_druid"
RST_PATH="$HOME/$TMP_FOLDER"
AFTER_INSTALL_INSTRUCTIONS="$HOME/AAC_WHAT_NOW.txt"
GPU_VENDOR=""

# OPTIONAL
STEAM="0"
MINECRAFT="0"
EMULATORS="0"
LATEX="0"

ASEPRITE="0"
BETTERBIRD="0"
NEOTHESIA="0"
RUST="0"

REIHA="0"
TESUTERU="0"
TOOLS="0"

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
	# Terminal
	bat
	btop
	dust
	fastfetch
	fzf
	github-cli
	htop
	imagemagick
	jp2a
	kitty
	man-db
	neovim
	ripgrep
	tldr
	tmux
	tree
	tree-sitter-cli
	udisks2

	# Display 
	xorg
	wayland
	uwsm
	hyprland
	xdg-desktop-portal-gtk
	xdg-desktop-portal-hyprland

	# Base
	lib32-mesa
	xf86-video-vesa
	networkmanager
	wl-clipboard
	bluez
	bluez-utils
	thermald

	# Hyprland things
	brightnessctl
	hyprlock
	hyprpolkitagent
	hyprshot
	hyprsunset
	mako
	network-manager-applet
	playerctl
	redshift
	swww
	waybar

	# Development
	clang
	odin
	raylib
	docker
	electron

	# Applications
	audacity
	carla
	imv
	krita
	lutris
	mpv
	obs-studio
	pavucontrol
	pcmanfm-gtk3
	qbittorrent
	qutebrowser
	reaper
	shotcut
	tailscale
	telegram-desktop
	zathura
	zathura-pdf-mupdf

	# Sound
	wireplumber
	qjackctl
	alsa-utils
	pipewire
	lib32-pipewire
	pipewire-alsa
	lib32-alsa-plugins
	pipewire-jack
	lib32-pipewire-jack
	pipewire-pulse
	gst-plugin-pipewire
	timidity++
	freepats-general-midi
	sof-firmware

	# Wine
	wine-staging
	wine-mono

	# Theming
	gtk3
	gtk4
	qt6ct
	qt5ct
	qt5-wayland
	papirus-icon-theme
	materia-gtk-theme
	nwg-look
	kvantum
)

PARU_PACKAGES=(
	tofi
	auto-cpufreq
	bluetuith-bin
	brave-bin
	librewolf-bin
	proton-ge-custom-bin
	anki-bin
	blockbench-bin
	vesktop-bin
	xpadneo-dkms
)

SEPARATOR='
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
'

clear

echo "$MSG_VELCOME"
echo "$SEPARATOR"


echo "Prerequisites: You have a minimal Arch Linux install with the linux-zen kernel"
echo "$SEPARATOR"


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
echo "$SEPARATOR"


echo "$GPU_VENDOR chosen"
echo "needed drivers will be installed"
echo "$SEPARATOR"


echo "Install steam?"
read -rp "[ Y/n ]: " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
	STEAM="1"
fi
echo "$SEPARATOR"


echo "Install LaTeX? (texlive, biber)"
read -rp "[ Y/n ]: " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
	LATEX="1"
fi
echo "$SEPARATOR"


echo "Compile aseprite?"
read -rp "[ Y/n ]: " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
	ASEPRITE="1"
fi
echo "$SEPARATOR"


echo "Install minecraft launcher? (prismlauncher)"
read -rp "[ Y/n ]: " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
	MINECRAFT="1"
fi
echo "$SEPARATOR"


echo "Install emulators? (pcsx2, rpcs3, xnp2)"
read -rp "[ Y/n ]: " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
	EMULATORS="1"
fi
echo "$SEPARATOR"


echo "Install mail client? (betterbird-bin)"
read -rp "[ Y/n ]: " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
	BETTERBIRD="1"
fi
echo "$SEPARATOR"


echo "Compile neothesia?"
read -rp "[ Y/n ]: " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
	NEOTHESIA="1"
fi
echo "$SEPARATOR"


echo "Install RUST Lang? Using curl command provided on the rust webpage"
read -rp "[ Y/n ]: " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
	RUST="1"
fi
echo "$SEPARATOR"


echo "Install reiha? My minimalistic presentation tool"
read -rp "[ Y/n ]: " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
	REIHA="1"
fi
echo "$SEPARATOR"


echo "Install tesuteru? testownik-cli - my implementation of testownik"
read -rp "[ Y/n ]: " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
	TESUTERU="1"
fi
echo "$SEPARATOR"


echo "Install handy tools? My timer and stopwatch"
read -rp "[ Y/n ]: " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
	TOOLS="1"
fi
echo "$SEPARATOR"


echo "Druid begun ritual!"
echo "$SEPARATOR"


cd $HOME
echo "creating temporary $TMP_FOLDER at $HOME"
mkdir $TMP_FOLDER
cd $RST_PATH
echo "$SEPARATOR"


echo "updating system"
sudo pacman -Syu
echo "$SEPARATOR"


echo "ensuring base are installed"
sudo pacman -S --needed $BASE_PACKAGES
echo "$SEPARATOR"


echo "installing git"
sudo pacman -S --needed git
echo "$SEPARATOR"


echo "downloading paru-bin"
git clone https://aur.archlinux.org/paru-bin.git
echo "$SEPARATOR"


echo "downloading dotfiles"
git clone https://github.com/barysk/dot_hyprland
git clone https://github.com/barysk/nvim
echo "$SEPARATOR"


echo "installing paru-bin"
cd paru-bin
makepkg -sri
cd $RST_PATH
echo "$SEPARATOR"


echo "applying dotfiles"
# nvim
cd nvim
rm -rf .git
cd $RST_PATH
mv nvim $HOME/.config/
# hypr
cd dot_hyprland
rm -rf .git
cd $RST_PATH
mv dot_hyprland/dot_config/* $HOME/.config/
mv dot_hyprland/dot_fonts $HOME/.fonts
mv dot_hyprland/dot_bashrc $HOME/.bashrc
echo "$SEPARATOR"


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
echo "$SEPARATOR"


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

echo "$SEPARATOR"


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

if [[ "$REIHA" == "1" ]]; then
	curl -L -o reiha https://github.com/Barysk/reiha/releases/download/v1.2.0/reiha
	chmod +x reiha
	sudo mv reiha /usr/local/bin/
fi

if [[ "$TESUTERU" == "1" ]]; then
	curl -L -o tesuteru https://github.com/Barysk/testownik_cli/releases/download/ver1.0.1/tesuteru
	chmod +x tesuteru
	sudo mv tesuteru /usr/local/bin/
fi

if [[ "$TOOLS" == "1" ]]; then
	git clone https://github.com/Barysk/tools
	cd tools/
	./build_tools.bash
	./install.bash
	cd $RST_PATH
fi

echo "$SEPARATOR"


echo "removing $TMP_FOLDER at $HOME"
cd $HOME
rm -rf $TMP_FOLDER
echo "$SEPARATOR"


echo "building modules for waybar"
cd $HOME/.config/waybar/src_modules/
./build_modules.sh
cd $HOME
echo "$SEPARATOR"


echo "updating tldr"
tldr --update
echo "$SEPARATOR"


echo "setting up auto-cpufreq"
sudo auto-cpufreq --install
echo "$SEPARATOR"


echo "All done!"
echo ""
echo "$MSG_BYE"

echo "$MSG_BYE" > "$AFTER_INSTALL_INSTRUCTIONS"

echo "those instructions are saved to $AFTER_INSTALL_INSTRUCTIONS"
echo ""
echo "before you do this reboot is advised"
echo "$SEPARATOR"


echo "Reboot?"
read -rp "[ Y/n ]: " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
	reboot
fi
