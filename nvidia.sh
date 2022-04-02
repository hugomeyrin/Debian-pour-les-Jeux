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
