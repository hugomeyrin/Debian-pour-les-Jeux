if [[ -f /usr/bin/aria2c && -f /etc/bash_completion ]]; then
    echo "$(tput bel)$(tput bold)$(tput setaf 2)system tools $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"
    else
    sudo apt install -y --reinstall aria2 bash-completion
fi
