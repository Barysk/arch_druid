#!/usr/bin/env bash
# Script that auto configures and installs all software I use on my arch ;)
# shebang!

MSG_VELCOME="Druid velcomes you!
He will install my dotfiles and the applications I use.
You will be prompted with some queries thus Please don't leave until the Druid
is done.

ver2025.08.09
bk"

MSG_BYE_R='What now?
1. Go to /etc/bluetooth/main.conf and set AutoEnable=false so that Bluetooth is
turned off by default
2. Eduroam? Yeah, you need to enable legacy support
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

MSG_BYE_X='What now?
1. Use [ xrandr ] to get the name of your monitor and write it to $HOME/.xinitrc, also set set correct resolution and frame rate. You can xhange wallpaper by changing WALPAPER_PATH.
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
SESSION="dwl"
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
	linux-lts-headers
)

DWL_SESSION=(
	wayland
	xdg-desktop-portal-wlr
	xdg-desktop-portal-gtk
	wl-clipboard
	wlr-randr
	hyprpolkitagent
	swaylock-effects-git # aur
	mako
	swaybg
	waybar
	imv
	tofi # aur
	qt5-wayland
	qt6-wayland
)

RIVER_SESSION=(
	wayland
	river
	xdg-desktop-portal-wlr
	xdg-desktop-portal-gtk
	wl-clipboard
	wlr-randr
	hyprpolkitagent
	hyprlock
	grim
	slurp
	mako
	swaybg
	waybar
	imv
	tofi # aur
	qt5-wayland
	qt6-wayland
)

HYPR_SESSION=(
	wayland
	uwsm
	hyprland
	xdg-desktop-portal-gtk
	xdg-desktop-portal-hyprland
	wl-clipboard
	hyprlock
	hyprpolkitagent
	grim
	slurp
	hyprsunset
	mako
	swaybg
	waybar
	qt5-wayland
	qt6-wayland
	imv
	tofi #paru
)

DWM_SESSION=(
	xorg-xinit
	dmenu
	picom
	feh
	dunst
	betterlockscreen #paru
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

	# Base
	xorg
	lib32-mesa
	xf86-video-vesa
	networkmanager
	bluez
	bluez-utils
	thermald
	brightnessctl
	network-manager-applet
	playerctl
	redshift

	# Development
	clang
	odin
	raylib
	docker
	electron

	# Applications
	audacity
	carla
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
	papirus-icon-theme
	materia-gtk-theme
	nwg-look
	kvantum
)

PARU_PACKAGES=(
	auto-cpufreq
	bluetuith-bin
	brave-bin
	librewolf-bin
	proton-ge-custom-bin
	anki-bin
	blockbench-bin
	vesktop-bin
	xpadneo-dkms
	localsend-bin
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


echo "Choose Session Type"
echo "1) DWL"
echo "2) River"
echo "3) Hyprland"
echo "4) DWM"
read -rp "Choice (1-4): " choice
case "$choice" in
	1)
		SESSION="dwl"
		;;
	2)
		SESSION="river"
		;;
	3)
		SESSION="hyprland"
		;;
	4)
		SESSION="dwm"
		;;
	*)
		echo "Invalid choice. Exiting."
		exit 1
		;;
esac
echo "$SEPARATOR"

echo "$SESSION chosen"
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
case "$SESSION" in
	dwl)
		git clone https://github.com/barysk/dot_dwl
		;;
	river)
		git clone https://github.com/barysk/dot_river
		;;
	hyprland)
		git clone https://github.com/barysk/dot_hyprland
		;;
	dwm)
		git clone https://github.com/barysk/dot_dwm
		;;
	*)
		echo "Something went wrong. Incorrect SESSION chosen: $SESSION"
		exit 1
		;;
esac
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
# river || hypr || dwm
case "$SESSION" in
	dwl)
		cd dot_dwl
		rm -rf .git
		chmod +x ./deploy.sh
		./deploy.sh
		cd $RST_PATH
		;;
	river)
		cd dot_river
		rm -rf .git
		chmod +x ./deploy.bash
		./deploy.bash
		cd $RST_PATH
		;;
	hyprland)
		cd dot_hyprland
		rm -rf .git
		cd $RST_PATH

		cp -rf dot_hyprland/dot_bashrc $HOME/.bashrc
		cp -rf dot_hyprland/dot_bash_profile $HOME/.bash_profile

		if [ ! -d $HOME/.config ]; then
			mkdir -p $HOME/.config
		fi
		cp -rf dot_hyprland/dot_config/* $HOME/.config/

		if [ ! -d $HOME/.fonts ]; then
			mkdir -p $HOME/.fonts
		fi
		cp -rf dot_hyprland/dot_fonts/* $HOME/.fonts
		;;
	dwm)
		cd dot_dwm
		rm -rf .git
		cd $RST_PATH

		cp -rf dot_dwm/dot_bashrc $HOME/.bashrc
		cp -rf dot_dwm/dot_bash_profile $HOME/.bash_profile
		cp -rf dot_dwm/dot_xinitrc $HOME/.xinitrc

		if [ ! -d $HOME/.config ]; then
			mkdir -p $HOME/.config
		fi
		cp -rf dot_dwm/dot_config/* $HOME/.config/

		if [ ! -d $HOME/.fonts ]; then
			mkdir -p $HOME/.fonts
		fi
		cp -rf dot_dwm/dot_fonts $HOME/.fonts

		echo "Installing DWM"
		cd $HOME.config/suckless/dwm
		sudo make clean install
		cd ../dwmblocks
		sudo make clean install
		cd $RST_PATH
		;;
	*)
		echo "Something went wrong. Incorrect SESSION chosen: $SESSION"
		exit 1
		;;
esac
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


case "$SESSION" in
	dwl)
		paru -S --needed "${DWL_SESSION[@]}"
		;;
	river)
		paru -S --needed "${RIVER_SESSION[@]}"
		;;
	hyprland)
		paru -S --needed "${HYPR_SESSION[@]}"
		;;
	dwm)
		paru -S --needed "${DWM_SESSION[@]}"
		;;
	*)
		echo "Something went wrong. Incorrect SESSION chosen: $SESSION"
		exit 1
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

echo "enabling bluetooth.service"
sudo systemctl enable --now bluetooth.service
echo "$SEPARATOR"

echo "All done!"
echo ""

case "$SESSION" in
	dwl)
		echo "$MSG_BYE_R"
		echo "$MSG_BYE_R" > "$AFTER_INSTALL_INSTRUCTIONS"
	;;
	river)
		echo "$MSG_BYE_R"
		echo "$MSG_BYE_R" > "$AFTER_INSTALL_INSTRUCTIONS"
	;;
	hyprland)
		echo "$MSG_BYE"
		echo "$MSG_BYE" > "$AFTER_INSTALL_INSTRUCTIONS"
		;;
	dwm)
		echo "$MSG_BYE_X"
		echo "$MSG_BYE_X" > "$AFTER_INSTALL_INSTRUCTIONS"
		;;
	*)
		echo "Something went wrong. Incorrect SESSION chosen: $SESSION"
		exit 1
		;;
esac

echo "those instructions are saved to $AFTER_INSTALL_INSTRUCTIONS"
echo ""
echo "before you do this reboot is advised"
echo "$SEPARATOR"


echo "Reboot?"
read -rp "[ Y/n ]: " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
	reboot
fi
