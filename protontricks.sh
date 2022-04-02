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
