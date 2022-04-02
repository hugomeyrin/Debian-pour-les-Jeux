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
