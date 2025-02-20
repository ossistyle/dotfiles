#!/usr/bin/env bash

# Setup colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
GREY="\e[90m"
LIGHTRED="\e[91m"
LIGHTGREEN="\e[92m"
LIGHTYELLOW="\e[93m"
LIGHTBLUE="\e[94m"
LIGHTMAGENTA="\e[95m"
LIGHTCYAN="\e[96m"
LIGHTGREY="\e[37m"
WHITE="\e[97m"
NORMAL="\e[0m"

header() {
    echo -e "\n${LIGHTMAGENTA}$1${NORMAL}"
    printf "${LIGHTMAGENTA}%$(($(tput cols) / 3))s${NORMAL}\n" | tr " " "="
}

success() {
    local msg=${1:-Done}
    echo -e "${GREEN}$msg${NORMAL}\n"
}

error() {
    echo -e "${LIGHTRED}$1${NORMAL}\n"
}

warning() {
    echo -e "${YELLOW}$1${NORMAL}"
}

info() {
    echo -e "${GREY}$1${NORMAL}"
}

install_package() {
    info "Install package $* ..."

    sudo apt-get update -y 1>/dev/null
    sudo apt-get install "${@}" -yf | grep -E "upgraded"
    sudo apt-get autoremove -y 1>/dev/null

}
