#!/bin/bash
# wrapt - a simple wrapper for apt that brings all useful apt commands into one easy to use script
# Created by simonizor
# License: GPLv2 Only

helpfunc () {
printf "
wrapt - http://www.simonizor.gq
A simple wrapper for apt that brings all useful apt commands into one easy to use script

wrapt              - Show this help output (alias: wrapt -h)
wrapt list,l       - apt list - List packages based on package names
    list arguments:
    --installed, -i   - dpkg --get-selections | grep -v deinstall - List all installed packages
    --files, -f       - dpkg -L - List files installed by a package
    --provides, -p    - dpkg -S - Show which package a file belongs to
    --depends, -d     - apt-cache depends - List dependencies of a package
    --rdepends, -rd   - apt-cache rdepends - List reverse dependencies of a package

wrapt search, se    - apt search - Search in package descriptions
wrapt info, show    - apt show - Show package details
wrapt mark, m       - apt-mark - Simple command line interface for marking packages as manually or automatically installed
    mark arguments: 
    --auto, -a        - apt-mark showauto
    --manual, -m      - apt-mark showmanual
    --hold, -h        - apt-mark hold
    --unhold, -u      - apt-mark unhold
    --showhold, -sh   - apt-mark showhold
    --showauto, -sa   - apt-mark showauto
    --showmanual, -sm - apt-mark showmanual

wrapt install, in   - apt install - Install packages
wrapt remove, rm    - apt remove - Remove packages
    remove arguments:
    --purge, -p       - apt remove --purge
    --auto, -ar       - apt remove --autoremove
    --pauto, -par     - apt remove --purge --autoremove

wrapt aremove, ar   - apt autoremove - Remove automatically all unused packages
wrapt paremove, par - apt remove --autoremove --purge - Remove packages, unused packages, and purge package config files
wrapt update, up    - apt update && apt upgrade - Run apt update and then apt upgrade
wrapt fupdate, fu   - apt full-upgrade - Fully upgrade the system by removing/installing/upgrading packages
wrapt addrepo, add  - apt-add-repository - A script for adding apt sources.list entries
"
}

if type wrapt >/dev/null 2>&1 && type zsh >/dev/null 2>&1 && ! grep -q 'wrapt' ~/.zshrc; then
    wget -qO ~/.wrapt.comp "https://raw.githubusercontent.com/simoniz0r/wrapt/master/wrapt.comp"
    echo "" >> ~/.zshrc
    echo "if [ -f "$HOME/.wrapt.comp" ]; then" >> ~/.zshrc
    echo "    source "$HOME"/.wrapt.comp" >> ~/.zshrc
    echo "    compdef _wrapt wrapt" >> ~/.zshrc
    echo "fi" >> ~/.zshrc
    echo "" >> ~/.zshrc
fi

# INPUT_@=($@)
# @="${INPUT_@[@]:1}"
case $1 in
    l|list)
        shift
        case $1 in
            -i|--installed)
                shift
                dpkg --get-selections | grep -v deinstall
                ;;
            -f|--files)
                shift
                dpkg -L "$@"
                ;;
            -p|--provides)
                shift
                dpkg -S "$@"
                ;;
            -d|--depends)
                shift
                apt-cache depends "$@"
                ;;
            -rd|--rdepends)
                shift
                apt-cache rdepends "$@"
                ;;
            *)
                shift
                apt list "$@"
                ;;
        esac
        ;;
    se|search)
        shift
        apt search "$@"
        ;;
    info|show)
        shift
        apt show "$@"
        ;;
    m|mark)
        shift
        case $1 in
            -a|--auto)
                shift
                apt-mark auto "$@"
                ;;
            -h|--hold)
                shift
                apt-mark hold "$@"
                ;;
            -m|--manual)
                shift
                apt-mark manual "$@"
                ;;
            -sh|--showhold)
                shift
                apt-mark showhold "$@"
                ;;
            -sa|--showauto)
                shift
                apt-mark showauto "$@"
                ;;
            -sm|--showmanual)
                shift
                apt-mark showmanual "$@"
                ;;
            -u|--unhold)
                shift
                apt-mark unhold "$@"
                ;;
            *)
                apt-mark "$@"
                ;;
        esac
        ;;
    in|install)
        shift
        apt install "$@"
        ;;
    rm|remove)
        shift
        case $1 in
            -p|--purge)
                shift
                apt remove --purge "$@"
                ;;
            -ar|--auto)
                shift
                apt remove --autoremove "$@"
                ;;
            -par|--pauto)
                shift
                apt remove --purge --autoremove "$@"
                ;;
            *)
                apt remove "$@"
                ;;
        esac
        ;;
    par|paremove)
        shift
        apt remove --purge --autoremove "$@"
        ;;
    ar|aremove)
        shift
        apt autoremove "$@"
        ;;
    up|update)
        shift
        apt update && sudo apt upgrade "$@"
        ;;
    fu|fupgrade)
        shift
        apt full-upgrade "$@"
        ;;
    add|addrepo)
        shift
        apt-add-repository "$@"
        ;;
    help|*)
        if grep -q 'wrapt' ~/.zshrc; then
            rm -f "$HOME"/.wrapt.comp
            wget -qO ~/.wrapt.comp "https://raw.githubusercontent.com/simoniz0r/wrapt/master/wrapt.comp"
        fi
        helpfunc
        ;;
esac    
