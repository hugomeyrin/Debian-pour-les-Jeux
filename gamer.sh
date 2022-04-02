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
