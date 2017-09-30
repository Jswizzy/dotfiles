#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "utils.sh"

    OSarchitecture="$(uname -i)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_termite() {

    git clone --recursive https://github.com/thestinger/termite.git
    git clone https://github.com/thestinger/vte-ng.git
    sudo apt-get install -y \
        g++ \
        libgtk-3-dev \
        gtk-doc-tools \
        gnutls-bin \
        valac \
        intltool \
        libpcre2-dev \
        libglib3.0-cil-dev \
        libgnutls28-dev \
        libgirepository1.0-dev \
        libxml2-utils \
        gperf

    echo export LIBRARY_PATH="/usr/include/gtk-3.0:$LIBRARY_PATH"
    cd vte-ng && ./autogen.sh && make && sudo make install
    cd ../termite && make && sudo make install
    sudo ldconfig
    sudo mkdir -p /lib/terminfo/x; sudo ln -s \
    /usr/local/share/terminfo/x/xterm-termite \
    /lib/terminfo/x/xterm-termite

}

install_apps() {

    # Install tools for compiling/building software from source.

    install_package "Build Essential" "build-essential"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # GnuPG archive keys of the Debian archive.

    install_package "GnuPG archive keys" "debian-archive-keyring"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Software which is not included by default
    # in Ubuntu due to legal or copyright reasons.

    #install_package "Ubuntu Restricted Extras" "ubuntu-restricted-extras"

    printf "\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "cURL" "curl"

    # Install Chrome Stable on 64bits and Chromium on 32bit architeture
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ "$OSarchitecture" == "x86_64" ]; then
	add_to_source_list "[arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" "google.list"
        add_key "https://dl.google.com/linux/linux_signing_key.pub"
        update
        install_package "google-chrome-stable"
    else
        install_package "Chromium Browser" "chromium-browser"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Dropbox" "nautilus-dropbox"

    # Install Franz
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ "$OSarchitecture" == "x86_64" ]; then
        wget https://github.com/meetfranz/franz-app/releases/download/4.0.4/Franz-linux-x64-4.0.4.tgz -O $HOME/Downloads/franz.tgz
    else
        wget https://github.com/meetfranz/franz-app/releases/download/4.0.4/Franz-linux-ia32-4.0.4.tgz -O $HOME/Downloads/franz.tgz
    fi

    cd /opt
    sudo mkdir franz
    cd /opt/franz
    sudo mv $HOME/Downloads/franz.tgz .
    sudo tar -xvf franz.tgz
    ./Franz 
    print_result "Franz"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "GIMP" "gimp"
    install_package "Git" "git"
    install_package "Hack Font" "fonts-hack-ttf"
    install_package "ImageMagick" "imagemagick"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    add_ppa "numix/ppa"
    update
    install_package "Numix Icons" "numix-icon-theme"
    install_package "Numix Icons Circle" "numix-icon-theme-circle"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Numix Theme" "numix-gtk-theme"
    install_package "OpenSSH" "openssh"
    install_package "ScreenFetch" "screenfetch"
    install_package "ShellCheck" "shellcheck"

    # Install Skype
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "apt-transport-https" "apt-transport-https"
    add_key "https://repo.skype.com/data/SKYPE-GPG-KEY"
    add_to_source_list "https://repo.skype.com/deb stable main" "skypeforlinux.list"
    update
    install_package "Skype" "skypeforlinux"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
    add_to_source_list "http://repository.spotify.com stable non-free" "spotify.list"
    update 
    install_package "Spotify" "spotify-client"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    add_ppa "transmissionbt/ppa"
    update
    install_package "Transmission" "transmission transmission-qt"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Tree" "tree"
    install_package "VLC" "vlc"
    install_package "Wget" "wget"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ "$OSarchitecture" == "x86_64" ]; then
        wget https://zoom.us/client/latest/zoom_amd64.deb -O $HOME/Downloads/zoom.deb
    else
        wget https://zoom.us/client/latest/zoom_i386.deb -O $HOME/Downloads/zoom.deb
    fi

    dpkg -i ~/Downloads/zoom.deb

    print_result "Zoom"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "cURL" "curl"
    install_package "tmux" "tmux"
    install_package "vim" "vim"
    install_package "xclip" "xclip"
    install_package "zsh" "zsh"
    install_package "zsh-syntax-highlighting" "zsh-syntax-highlighting"

    #install_termite

}

main() {

    print_in_purple "   Apps and CLI tools\n\n"

    update
    upgrade
    printf "\n"
    install_apps
    printf "\n"
    autoremove

}

main
