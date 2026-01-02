#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Gogs

FGWT=$'\e[38;5;15m'   # fg white
FGLBL=$'\e[38;5;117m' # fg light blue
FGLGN=$'\e[38;5;2m'   # fg light green
FGLOG=$'\e[38;5;215m' # fg light orange
FGLRD=$'\e[38;5;1m'   # fg light red
FGRST=$'\e[39m'       # fg reset color

BGBL=$'\e[48;5;27m'  # bg blue
BGGN=$'\e[48;5;34m'  # bg green
BGOG=$'\e[48;5;166m' # bg orange
BGRD=$'\e[48;5;196m' # bg red
BGRST=$'\e[49m'      # bg reset color

LATEST_VERSION=''
LATEST_VERSION_NUMBER=''

print_msg() {
    local TYPE=$1
    local MSG1=$2
    local MSG2=$3

    case ${TYPE} in
    'ERROR')
        echo ''
        echo -e "   ${BGRD}${FGWT} ${TYPE}: ${BGRST} ${FGLRD}${MSG1}${FGRST}"
        [ "${MSG2}" != '' ] && echo -e "            ${FGLBL}${MSG2}${FGRST}"
        echo ''
        exit 1
        ;;
    'WARNING')
        echo ''
        echo -e "   ${BGOG}${FGWT} ${TYPE}: ${BGRST} ${FGLOG}${MSG1}${FGRST}"
        [ "${MSG2}" != '' ] && echo -e "              ${FGLBL}${MSG2}${FGRST}"
        ;;
    'SUCCESS')
        echo ''
        echo -e "   ${BGGN}${FGWT} ${TYPE}: ${BGRST} ${FGLGN}${MSG1}${FGRST}"
        [ "${MSG2}" != '' ] && echo -e "              ${FGLBL}${MSG2}${FGRST}"
        ;;
    'DONE')
        echo ''
        echo -e "   ${BGGN}${FGWT} ${TYPE}: ${BGRST} ${FGLGN}${MSG1}${FGRST}"
        [ "${MSG2}" != '' ] && echo -e "           ${FGLBL}${MSG2}${FGRST}"
        ;;
    'INFO')
        echo ''
        echo -e "   ${BGBL}${FGWT} ${TYPE}: ${BGRST} ${FGRST}${MSG1}"
        [ "${MSG2}" != '' ] && echo -e "           ${FGLBL}${MSG2}${FGRST}"
        ;;
    *)
        echo ''
        echo -e "   ${TYPE}${BGRST}${FGRST}"
        [ "${MSG1}" != '' ] && echo -e "   ${MSG1}${BGRST}${FGRST}"
        [ "${MSG2}" != '' ] && echo -e "   ${MSG2}${BGRST}${FGRST}"
        ;;
    esac
}

create_dir() {
    local FOLDER_ABS_PATH=$1

    if [ ! -d "$FOLDER_ABS_PATH" ]; then
        print_msg 'INFO' 'Creatinng folder path' "$FOLDER_ABS_PATH"
        mkdir -p "$FOLDER_ABS_PATH"
    fi
}

change_dir() {
    local FOLDER_ABS_PATH=$1

    create_dir "$FOLDER_ABS_PATH"
    cd "$FOLDER_ABS_PATH" || exit 1
}

fetch_latest_release_version() {
    local REPO=$1

    LATEST_VERSION=''
    RELEASE_URL="$(curl -Ls -o /dev/null -w "%{url_effective}" "${REPO}/releases/latest")"
    LATEST_VERSION="$(basename "$RELEASE_URL")"
    LATEST_VERSION_NUMBER="$(echo "${LATEST_VERSION}" | sed -E 's/v([0-9]+\.[0-9]+\.[0-9]+).*/\1/g')"
}

install_gogs() {
    local DOWNLOAD_GOGS_FOLDER="${HOME}/Downloads/gogs"
    local NEW_USER='git'
    local GIT_USER_PATH="/home/${NEW_USER}"

    fetch_latest_release_version 'https://github.com/gogs/gogs'
    # local GOGS_FILE="gogs_${LATEST_VERSION_NUMBER}_linux_armv7.zip" # 32-Bit
    local GOGS_FILE="gogs_${LATEST_VERSION_NUMBER}_linux_armv8.zip" # 64-Bit

    change_dir "${HOME}/Downloads"

    [ -d "$DOWNLOAD_GOGS_FOLDER" ] && rm -rf "$DOWNLOAD_GOGS_FOLDER"
    if [ ! -f "${HOME}/Downloads/${GOGS_FILE}" ]; then
        wget "https://github.com/gogs/gogs/releases/download/v${LATEST_VERSION_NUMBER}/${GOGS_FILE}"
    fi

    unzip "$GOGS_FILE"
    rm "$GOGS_FILE"
    mkdir -p "$GIT_USER_PATH"
    sudo mv "$DOWNLOAD_GOGS_FOLDER" "$GIT_USER_PATH"
    sudo chown -R "$NEW_USER":"$NEW_USER" "$GIT_USER_PATH"
    systemctl enable "$GIT_USER_PATH/gogs/scripts/systemd/gogs.service"
    systemctl daemon-reload
    systemctl start gogs.service
}

install_gogs
