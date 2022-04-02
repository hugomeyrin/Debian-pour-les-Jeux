if [ -f /usr/lib/x86_64-linux-gnu/vkbasalt/libvkbasalt.so ]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)vkBasalt $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    sudo apt install -y --no-install-recommends --reinstall vkbasalt
fi
