#!/bin/bash
# wrapt - a simple wrapper for apt that brings all useful apt commands into one easy to use script
# Created by simonizor
# License: GPLv2 Only

helpfunc () {
printf "
wrapt - http://www.simonizor.gq/scripts
A simple wrapper for apt that brings all useful apt commands into one easy to use script

wrapt      - Show this help output (alias: wrapt -help)
wrapt -l   - apt list - list packages based on package names
wrapt -li  - dpkg --get-selections | grep -v deinstall - list all installed packages
wrapt -S   - dpkg -S - show which package a file belongs to
wrapt -L   - dpkg -L - list files installed by a package
wrapt -sd  - apt-cache depends - list dependencies of a package
wrapt -srd - apt-cache rdepends - list reverse dependencies of a package
wrapt -se  - apt search - search in package descriptions
wrapt -sh  - apt show - show package details
wrapt -m   - apt -mark - simple command line interface for marking packages as manually or automatically installed
wrapt -i   - apt install - install packages
wrapt -deb - dpkg -i || apt install -f - install deb package and run apt install -f to install dependencies
wrapt -r   - apt remove - remove packages
wrapt -ra  - apt autoremove - Remove automatically all unused packages
wrapt -ud  - apt update - update list of available packages
wrapt -ug  - apt upgrade - upgrade the system by installing/upgrading packages
wrapt -uu  - apt update && apt upgrade - run apt update and then apt upgrade
wrapt -fu  - apt full-upgrade - fully upgrade the system by removing/installing/upgrading packages
wrapt -ar  - apt -add-repository - wrapt -add-repository is a script for adding apt sources.list entries
wrapt -es  - apt edit-sources - edit the source information file
"
}

if type wrapt >/dev/null 2>&1 && type zsh >/dev/null 2>&1; then
    wget -qO ~/.wrapt.comp "https://raw.githubusercontent.com/simoniz0r/wrapt/master/wrapt.comp"
    echo "" >> ~/.zshrc
    echo "if [ -f "$HOME/.wrapt.comp" ]; then" >> ~/.zshrc
    echo "    source "$HOME"/.wrapt.comp" >> ~/.zshrc
    echo "    compdef _wrapt wrapt" >> ~/.zshrc
    echo "fi" >> ~/.zshrc
    echo "" >> ~/.zshrc
fi

ARGS="$(echo $@ | cut -f2- -d' ')"
case $1 in
    -l)
        apt list "$ARGS"
        ;;
    -li)
        dpkg --get-selections | grep -v deinstall
        ;;
    -S)
        dpkg -S "$ARGS"
        ;;
    -L)
        dpkg -L "$ARGS"
        ;;
    -sd)
        apt-cache depends "$ARGS"
        ;;
    -srd)
        apt-cache rdepends "$ARGS"
        ;;
    -se)
        apt search "$ARGS"
        ;;
    -sh)
        apt show "$ARGS"
        ;;
    -m)
        case $ARGS in
            -sa*)
                ARGS="$(echo $@ | cut -f3- -d' ')"
                apt mark showauto "$ARGS"
                ;;
            -sm*)
                ARGS="$(echo $@ | cut -f3- -d' ')"
                apt mark showmanual "$ARGS"
                ;;
            -su*)
                ARGS="$(echo $@ | cut -f3- -d' ')"
                comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u)
                ;;
            -sd)
                ARGS="$(echo $@ | cut -f3- -d' ')"
                comm -23 <(apt-mark showauto | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u)
                ;;
            *)
                apt mark "$ARGS"
                ;;
        esac
        ;;
    -i)
        apt install "$ARGS"
        ;;
    -deb)
        dpkg -i "$ARGS" || sudo apt install -f
        ;;
    -r)
        case $ARGS in
            -p)
                ARGS="$(echo $@ | cut -f3- -d' ')"
                apt remove --purge "$ARGS"
                ;;
            -ar)
                ARGS="$(echo $@ | cut -f3- -d' ')"
                apt remove --autoremove "$ARGS"
                ;;
            -arp)
                ARGS="$(echo $@ | cut -f3- -d' ')"
                apt remove --purge --autoremove "$ARGS"
                ;;
            *)
                apt remove "$ARGS"
                ;;
        esac
        ;;
    -ra)
        apt autoremove "$ARGS"
        ;;
    -ud)
        apt update "$ARGS"
        ;;
    -ug)
        apt upgrade "$ARGS"
        ;;
    -uu)
        apt update "$ARGS" && sudo apt upgrade "$ARGS"
        ;;
    -fu)
        apt full-upgrade
        ;;
    -ar)
        apt-add-repository "$ARGS"
        ;;
    -es)
        apt edit-sources
        ;;
    -h|*)
        helpfunc
        ;;
esac    
