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
