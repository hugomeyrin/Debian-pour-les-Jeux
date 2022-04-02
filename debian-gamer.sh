#/bin/bash
set -e
sudo cp -v /etc/apt/sources.list /etc/apt/sources.list.BKP
#cat /etc/apt/sources.list|grep -v debian-security|grep -v deb-src|sudo tee /etc/apt/sources.list
file=/etc/apt/sources.list
if [ $(grep -c contrib $file) != 0 ]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)contrib $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    sudo sed -i 's/main/main contrib/g' /etc/apt/sources.list
fi
if [ $(grep -c non-free $file) != 0 ]; then
	echo "$(tput bel)$(tput bold)$(tput setaf 2)non-free $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
	else
    sudo sed -i 's/main/main non-free/g' /etc/apt/sources.list
fi
if [ $(grep -c sid /etc/apt/sources.list) != 0 ]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)Sid $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
cat <<EOF |sudo tee -a /etc/apt/sources.list

# Sid
deb https://deb.debian.org/debian sid main contrib non-free
EOF
cat <<EOF |sudo tee /etc/apt/preferences.d/sid
# Sid
Package: *
Pin: release a=unstable
Pin-Priority: 100
EOF
fi
    sudo dpkg --add-architecture i386
    sudo apt update -qq
if [[ -f /usr/bin/aria2c && -f /etc/bash_completion ]]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)system tools $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    sudo apt install -y --reinstall aria2 bash-completion
fi
if [[ -f /etc/apt/sources.list.d/xanmod-kernel.list && -f /etc/apt/trusted.gpg.d/xanmod-kernel.gpg ]]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)XanMod $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    echo 'deb http://deb.xanmod.org releases main'|sudo tee /etc/apt/sources.list.d/xanmod-kernel.list
    sudo rm -f /etc/apt/trusted.gpg.d/xanmod-kernel.gpg
    #curl -sL http://dl.xanmod.org/gpg.key|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/xanmod-kernel.gpg
cat <<EOF |sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/xanmod-kernel.gpg
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

mQENBFhxW04BCAC61HuxBVf1XJiQjXu/DSAtVcnuK38geDoDjcqFtHskFy32NgJG
X118EFNym6noF+oibaSftI9yjHthWvMnYZ/+DPwd7YZhbAjBvxMIQCsP6cFVxrgc
VV8g+uh4TCfbpalDBFoncRhQCgkmDN9Vd4kIWRh6BHJuzpKB/h2KxUHZVEKgWlK2
dR1xUtbrc+kp8gLwPbxTgC3tZ4x2uMMMlnbyCMSRa5oJ/AvoW4W1XphKL9ivsFHM
PSQkUBDvgv2RPw+0XBxPy8SYE0r0onx0ZIpjJRTODt3bSV6/0owwlpNogV9bT8HY
kl3+w3mTwax6S1akHZuJtLkZS0uUBz1BHt5bABEBAAG0IVhhbk1vZCBLZXJuZWwg
PGtlcm5lbEB4YW5tb2Qub3JnPokBNwQTAQgAIQUCWHFbTgIbAwULCQgHAgYVCAkK
CwIEFgIDAQIeAQIXgAAKCRCG99Ce5zTmIwTmB/9/S4rmwU6efDgEaBDwBDbOfLBA
P2+kDpabjG4K+V4NSvDqlPN49KrI7C21jHghAa2VuTPbSZVQ9ziUd5DjX9OuXov8
CYVG+rrlG1UadHS8SBpgw0gNylEvo9/U6u0hl8mrbVOlpzu+eE+e4cMTHax2y580
fC2xmnM8wKgyRFEyVc6ilWU+UNTAeUFlg0YfU3cV1Ut4DzVFfamtNYg0p7Q/9MSy
VgFpt5C2U5prk4wi++51OgrtaNhMrUhzYXLINWVF6IrXhQ+mkI/FWXUZ0oyVo55v
+dQzuds/gos90q+tKyE514pYAmwQSftSjf+RmHOMpPQyMZZKSywrz4vlfveDuQEN
BFhxW04BCACs5bXq73MDb2+AsvNL2XkkbnzmE4K3k0gejB9OxrO+puAZn3wWyYIk
b0Op8qVUh+/FIiW/uFfmdFD8BypC3YkCNfg6e74f5TT3qQciccpMGy62teo3jfhT
T8E1OL1i76ALq7eNbByJKiKLBrTUDM6BDIeRZBWXQMase4+aqUAP47Kd/ByPsmCh
/pzb6yPdDPKwkspELssdPXYI7enddjQsCPoBko0j8CTPgKqMTeCuKMXCtD2gtRBN
eoVj4cbjZoZvBh8oJktzbYA8FX8eKdxIXhSP9MoVOPSWhxIQdwzkzUPK+0vUV8jA
NBTnGOkrRJPOHGPJWFWnTUGrzvcwi7czABEBAAGJAR8EGAEIAAkFAlhxW04CGwwA
CgkQhvfQnuc05iMIswgAmzSpCHFGKdkFLdC673FidJcL8adKFTO5Mpyholc5N8vG
ROJbpso+DpssF14NKoBfBWqPRgHxYzHakxHiNf0R2+EEwXH3rblzpx3PXzB0OgNe
T9T0UStrGgc9nZ8nZVURHZZ2z5zakEWS+rB2TiSxz3YArR3wiTHQW49G09uZvfp6
5Mim2w+eUxbQ689eT0DlDI1d2eDP/j5lrv1elsg3kBE2Awzdvi8DdGUpMFrSsYJw
WS85uZrwbeAs/nPO62wNIvAbbRsWnDg3AV3vc02eRvy52tTBY1W/67N02M4AxgPd
ukDDFZMifwa03yTHD/a57O4dFOnzsEVojBnbzQ7W7w==
=HKlF
-----END PGP PUBLIC KEY BLOCK-----
EOF
    sudo apt update
    sudo apt autoremove --purge -y firmware-*
    sudo apt install -y --reinstall linux-firmware linux-xanmod
fi
if [ -f /usr/sbin/set-cfs-zen-tweaks.bash ]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)CFS Zen tweaks $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    aria2c --console-log-level=error --summary-interval=0 $(curl -s https://api.github.com/repos/igo95862/cfs-zen-tweaks/releases|grep browser_download_url|grep .deb|head -n1|cut -d '"' -f4)
    sudo apt install -y --reinstall ./cfs-zen-tweaks*.deb
    rm cfs-zen-tweaks*.deb
fi
if [[ -n `lspci |grep NVIDIA|cut -d: -f3` ]]
then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)Sua GPU$(tput setaf 4)$(tput setab 7) é $(tput setaf 7)$(tput setab 4)NVIDIA...$(tput sgr0)"
    lspci |grep NVIDIA|cut -d: -f3|cut -d ' ' -f4
    #apt download nvidia-kernel-dkms
    #dpkg-deb -x nvidia-kernel-dkms* nvidia
    #sudo cp -rf nvidia/* /
    #rm -rf nvidia*
    #sudo sed -i 's/modules/IGNORE_CC_MISMATCH=1 modules/g' /usr/src/nvidia*/dkms.conf
    #sudo apt install -y --reinstall nvidia-detect
    #sudo apt install -y -t=sid --reinstall `nvidia-detect |grep nvidia-|sed 's/    //g'`
    if [ -f /etc/apt/sources.list.d/graphics-drivers.list ]; then
        echo "$(tput bel)$(tput bold)$(tput setaf 2)NVIDIA $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
        else
        echo 'deb http://ppa.launchpad.net/graphics-drivers/ppa/ubuntu focal main'|sudo tee /etc/apt/sources.list.d/graphics-drivers.list
        sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys FCAE110B1118213C
        sudo apt update
        aria2c --console-log-level=error --summary-interval=0 http://mirrors.kernel.org/ubuntu/pool/main/x/x-kit/$(curl -sL http://mirrors.kernel.org/ubuntu/pool/main/x/x-kit/|grep python3-xkit|grep all.deb|tail -n1|cut -d '"' -f2)
        aria2c --console-log-level=error --summary-interval=0 http://mirrors.kernel.org/ubuntu/pool/main/s/screen-resolution-extra/$(curl -sL http://mirrors.kernel.org/ubuntu/pool/main/s/screen-resolution-extra/|grep screen-resolution-extra|grep all.deb|tail -n1|cut -d '"' -f2)
        sudo apt install -y $(apt search ^nvidia-driver 2>/dev/null|grep -P1 'NVIDIA driver metapackage'|cut -d '/' -f1|tail -n3|head -n1) nvidia-detect nvidia-settings ./*.deb
        rm python3-xkit*.deb screen-resolution-extra*.deb
    fi
    else
    echo "$(tput bel)$(tput bold)$(tput setaf 2)Sua GPU$(tput setaf 1)$(tput setab 7) não é $(tput setaf 7)$(tput setab 1)NVIDIA$(tput sgr0)"
fi
if [ -f /etc/apt/sources.list.d/kisak-mesa.list ]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)MESA $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    echo 'deb http://ppa.launchpad.net/kisak/kisak-mesa/ubuntu focal main'|sudo tee /etc/apt/sources.list.d/kisak-mesa.list
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys F63F0F2B90935439
    sudo apt update
    sudo apt dist-upgrade -y
fi
if [[ -f /etc/apt/sources.list.d/lutris.list && /etc/apt/trusted.gpg.d/lutris.list ]]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)Lutris $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    echo 'deb http://download.opensuse.org/repositories/home:/strycore/Debian_10/ ./'|sudo tee /etc/apt/sources.list.d/lutris.list
    sudo rm -f /etc/apt/trusted.gpg.d/lutris.gpg
    curl -s https://download.opensuse.org/repositories/home:/strycore/Debian_10/Release.key|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/lutris.gpg
    sudo apt update
    sudo apt install -y --reinstall libvulkan1:i386 libpng16-16:i386
    sudo apt install -y --no-install-recommends --reinstall lutris
fi
if [[ -n $(wine --version|grep TkG) ]]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)WINE TkG $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    aria2c --console-log-level=error --summary-interval=0 $(curl -s https://api.github.com/repos/Kron4ek/Wine-Builds/releases|grep browser_download_url|grep staging-tkg-amd64.tar.xz|head -n1|cut -d '"' -f4)
    tar -xf wine*staging-tkg-amd64.tar.xz
    rm wine*staging-tkg-amd64.tar.xz
    sudo rm -rf /opt/wine-tkg
    sudo mv wine*staging-tkg-amd64 /opt/wine-tkg
    aria2c --console-log-level=error --summary-interval=0 $(curl -s https://api.github.com/repos/GloriousEggroll/wine-ge-custom/releases|grep browser_download_url|grep download|grep wine-lutris-ge|grep .tar.xz|head -n1|cut -d '"' -f4)
    tar -xf wine-lutris-ge*.tar.xz
    rm wine-lutris-ge*.tar.xz
    sudo cp lutris*/lib/wine/i386-windows/winemenubuilder.exe /opt/wine-tkg/lib/wine/i386-windows/winemenubuilder.exe
    sudo cp lutris*/lib64/wine/x86_64-windows/winemenubuilder.exe /opt/wine-tkg/lib/wine/x86_64-windows/winemenubuilder.exe
    mkdir -pv $HOME/.local/share/lutris/runners/wine
    mv lutris-ge* $HOME/.local/share/lutris/runners/wine/
    #WINE_GECKO_VER=$(curl -s https://dl.winehq.org/wine/wine-gecko/|grep folder|cut -d '"' -f6|sort -g|tail -n1)
    WINE_GECKO_VER=2.47.2/
    curl -s https://dl.winehq.org/wine/wine-gecko/$WINE_GECKO_VER|grep x86|grep tar|grep -wv pdb|cut -d '"' -f6>wine-gecko.links
    sed -i 's/wine-gecko/https:\/\/dl.winehq.org\/wine\/wine-gecko\/wine-gecko/g' wine-gecko.links
    sed -i 's@wine\/wine-gecko\/@'wine\/wine-gecko\/"$WINE_GECKO_VER"'@g' wine-gecko.links
    aria2c --console-log-level=error --summary-interval=0 `echo $(cat wine-gecko.links|head -n1)`
    aria2c --console-log-level=error --summary-interval=0 `echo $(cat wine-gecko.links|tail -n1)`
    rm wine-gecko.links
    WINE_MONO_VER=$(curl -s https://dl.winehq.org/wine/wine-mono/|grep folder|cut -d '"' -f6|sort -g|tail -n1)
    curl -s https://dl.winehq.org/wine/wine-mono/$WINE_MONO_VER|grep x86|grep tar|cut -d '"' -f6>wine-mono.links
    sed -i 's/wine-mono/https:\/\/dl.winehq.org\/wine\/wine-mono\/wine-mono/g' wine-mono.links
    sed -i 's@wine\/wine-mono\/@'wine\/wine-mono\/"$WINE_MONO_VER"'@g' wine-mono.links
    aria2c --console-log-level=error --summary-interval=0 `echo $(cat wine-mono.links|head -n1)`
    rm wine-mono.links
    sudo mkdir -p /opt/wine-tkg/share/wine/{gecko,mono}
    sudo tar xf wine-gecko-*-x86.tar.xz -C /opt/wine-tkg/share/wine/gecko/
    sudo tar xf wine-gecko-*-x86_64.tar.xz -C /opt/wine-tkg/share/wine/gecko/
    sudo tar xf wine-mono-*-x86.tar.xz -C /opt/wine-tkg/share/wine/mono/
    rm wine-gecko-*-x86.tar.xz
    rm wine-gecko-*-x86_64.tar.xz
    rm wine-mono-*-x86.tar.xz
    sudo apt install -y --reinstall cabextract wine
    sudo mkdir -p /etc/X11/Xsession.d
cat <<EOF |sudo tee /etc/X11/Xsession.d/99wine
if [ -d "/opt/wine-tkg/bin" ] ; then
    PATH="/opt/wine-tkg/bin:\$PATH"
fi
export WINE_ENABLE_PIPE_SYNC_FOR_APP=1
export WINEFSYNC=1
EOF
fi
if [ -f /usr/bin/q4wine ]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)Q4WINE $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    sudo apt install -y -t=sid --no-install-recommends --reinstall q4wine
fi
if [ -f /usr/bin/cpu-x ]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)CPU-X $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    sudo apt install -y --reinstall cpu-x
fi
if [ -f /usr/bin/gamemoded ]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)GameMode $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    sudo apt install -y --no-install-recommends --reinstall gamemode
fi
if [ -f /usr/bin/gamescope ]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)Gamescope $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    echo 'deb http://ppa.launchpad.net/samoilov-lex/gamescope/ubuntu focal main'|sudo tee /etc/apt/sources.list.d/gamescope.list
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0BB4A1B2FA1A38EB
    sudo apt update
    sudo apt install -y --no-install-recommends --reinstall gamescope
fi
if [ -f /usr/bin/mangohud ]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)MangoHud $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    sudo apt install -y --no-install-recommends --reinstall mangohud
fi
if [ -f /usr/lib/x86_64-linux-gnu/vkbasalt/libvkbasalt.so ]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)vkBasalt $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    sudo apt install -y --no-install-recommends --reinstall vkbasalt
fi
if [ -f /usr/games/goverlay ]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)GOverlay $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    sudo apt install -y --reinstall goverlay
fi
if [ -f /usr/bin/heroic ]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)Heroic $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
	aria2c --console-log-level=error --summary-interval=0 $(curl -s https://api.github.com/repos/Heroic-Games-Launcher/HeroicGamesLauncher/releases|grep browser_download_url|grep amd64.deb|head -n1|cut -d '"' -f4)
    sudo apt install -y --reinstall ./heroic*.deb
    rm heroic*.deb
fi
if [ -f /usr/bin/steam ]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)Steam $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    aria2c --console-log-level=error --summary-interval=0 https://cdn.cloudflare.steamstatic.com/client/installer/steam.deb
    sudo apt install -y --reinstall ./steam*.deb #libgl1-mesa-dri:i386 libgl1:i386
    rm steam*.deb
fi
if [[ -f $HOME/.local/bin/protonup && -n $(ls -A $HOME/.steam/root/compatibilitytools.d/ 2>/dev/null) ]]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)protonup $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    sudo apt install -y --reinstall \
        git \
        python3-pip \
        python3-setuptools
    rm -rf protonup
    git clone https://github.com/AUNaseef/protonup
    cd protonup
    pip3 install --user .
    if [[ -n $(cat $HOME/.bashrc|grep -A3 '# Proton GE') && -n $(ls -A $HOME/.steam/root/compatibilitytools.d/ 2>/dev/null) ]]; then
    	echo "$(tput bel)$(tput bold)$(tput setaf 2)Proton GE $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
cat <<EOF |tee -a $HOME/.bashrc

# Proton GE
if [ -d "\$HOME/.local/bin" ] ; then
    PATH="\$HOME/.local/bin:\$PATH"
fi
EOF
    source $HOME/.bashrc
    yes|$HOME/.local/bin/protonup
    cd ..
    rm -rf protonup
    git clone https://github.com/DavidoTek/ProtonUp-Qt $HOME/.local/share/protonup-qt
    cd $HOME/.local/share/protonup-qt
    pip3 install --user -r ./requirements.txt
    cd
    mkdir -p $HOME/.local/share/applications $HOME/.local/share/icons
    curl -sLo $HOME/.local/share/icons/protonup-qt.png https://github.com/DavidoTek/ProtonUp-Qt/raw/main/share/icons/hicolor/256x256/apps/pupgui2.png
cat <<EOF |tee -a $HOME/.local/share/applications/protonup-qt.desktop
[Desktop Entry]
Name=ProtonUp-Qt
Exec=python3 $HOME/.local/share/protonup-qt/pupgui2/pupgui2.py
Path=$HOME/.local/share/protonup-qt
Type=Application
StartupNotify=true
Icon=protonup-qt
EOF
    fi
fi
if [ -f /usr/local/bin/protontricks ]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)Protontricks $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    sudo apt install -y --reinstall \
        git \
        python3-pip \
        python3-setuptools
    rm -rf protontricks
    git clone https://github.com/Matoking/protontricks
    cd protontricks
    sudo pip3 install .
    cd ..
    rm -rf protontricks
fi
if [ -f $HOME/.itch/itch ]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)itch $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    aria2c --console-log-level=error https://itch.io/app/download?platform=linux
    chmod +x itch-setup
    ./itch-setup --silent
    rm itch-setup
fi
if [ -f /usr/games/minigalaxy ]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)Minigalaxy $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    sudo apt install -y --reinstall minigalaxy
fi
if [ -f /usr/bin/gamehub ]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)GameHub $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    aria2c --console-log-level=error --summary-interval=0 $(curl -s https://api.github.com/repos/tkashkin/GameHub/releases|grep browser_download_url|grep amd64.deb|head -n1|cut -d '"' -f4)
    sudo apt install -y --reinstall ./GameHub*deb
    rm GameHub*.deb
fi
if [ -f $HOME/.local/share/wine-launcher/bin/start ]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)WINE Launcher $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    mkdir -p $HOME/.local/share/wine-launcher $HOME/.local/share/applications
    cd $HOME/.local/share/wine-launcher
    curl -sL https://github.com/hitman249/wine-launcher/releases/latest/download/start --output start
    chmod +x start
    ./start
cat <<EOF |tee $HOME/.local/share/applications/wine-launcher.desktop
[Desktop Entry]
Type=Application
Name=WINE Launcher
Exec=$HOME/.local/share/wine-launcher/bin/start
Icon=wine-launcher
Categories=Game;
EOF
    mkdir -p $HOME/.local/share/icons
    curl -sL https://github.com/hitman249/wine-launcher/raw/master/build/icons/512.png --output $HOME/.local/share/icons/wine-launcher.png
    cd $HOME
fi
if [ -f $HOME/RetroPie-Setup/retropie_setup.sh ]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)RetroPie $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    sudo apt install -y --reinstall git
    rm -rf RetroPie-Setup
    git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup
    #sudo ./retropie_setup.sh
fi
if [ -f /usr/bin/discord ]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)Discord $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    aria2c --console-log-level=error --summary-interval=0 -o discord.deb 'https://discord.com/api/download?platform=linux&format=deb'
    aria2c --console-log-level=error --summary-interval=0 http://ftp.us.debian.org/debian/pool/main/liba/libappindicator/libappindicator1_0.4.92-7_amd64.deb
    aria2c --console-log-level=error --summary-interval=0 http://ftp.us.debian.org/debian/pool/main/libi/libindicator/libindicator7_0.5.0-4_amd64.deb
    sudo apt install -y --reinstall ./discord*.deb ./libappindicator*.deb ./libindicator*.deb
    rm discord*.deb libappindicator*.deb libindicator*.deb
fi
