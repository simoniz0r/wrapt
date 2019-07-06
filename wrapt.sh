#!/bin/bash
# wrapt - a simple wrapper for apt that brings all useful apt commands into one easy to use script
# Created by simonizor
# License: GPLv2 Only

# output help
function helpfunc() {
printf "
wrapt - http://www.simonizor.gq
A simple wrapper for apt that brings all useful apt commands into one easy to use script

wrapt               - Show this help output (alias: wrapt -h)
wrapt list, ls      - apt list - List packages based on package names
    list arguments:
    --installed, -i   - dpkg --get-selections | grep -v deinstall - List all installed packages

wrapt search, se    - apt search - Search in package descriptions
wrapt info, if      - apt show - Show package details
    info arguments:
    --files, -f       - dpkg -L - List files installed by a package
    --provides, -p    - dpkg -S - Show which package a file belongs to
    --depends, -d     - apt-cache depends - List dependencies of a package
    --rdepends, -rd   - apt-cache rdepends - List reverse dependencies of a package

wrapt mark, mk      - apt-mark - Simple command line interface for marking packages as manually or automatically installed
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
    --autoremove, -arm
                      - apt remove --autoremove
    --purge-autoremove, -par
                      - apt remove --purge --autoremove

wrapt autoremove, arm 
                    - apt autoremove - Remove automatically all unused packages
wrapt purge-autoremove, par 
                    - apt remove --autoremove --purge - Remove packages, unused packages, and purge package config files
wrapt update, up    - apt update && apt upgrade - Run apt update and then apt upgrade
wrapt full-upgrade, fup 
                    - apt full-upgrade - Fully upgrade the system by removing/installing/upgrading packages
wrapt add-repo, ar  - apt-add-repository - A script for adding apt sources.list entries
"
}

# detect arguments and route them to apt or dpkg commands
case "$1" in
    ls|list)
        shift
        case "$1" in
            -i|--installed)
                shift
                # use dpkg to get package list and then grep to only get installed
                dpkg --get-selections | grep -v deinstall
                ;;
            *)
                # otherwise run apt list
                apt list "$@"
                ;;
        esac
        ;;
    se|search)
        shift
        apt search "$@"
        ;;
    info|if)
        shift
        case "$1" in
            -f|--files)
                shift
                # use dpkg to list installed files
                dpkg -L "$@"
                ;;
            -p|--provides)
                shift
                # use dpkg to list what provides something
                dpkg -S "$@"
                ;;
            -d|--depends)
                shift
                # use apt-cache to list depends of package
                apt-cache depends "$@"
                ;;
            -rd|--rdepends)
                shift
                # use apt-cache to list what packages depend on given package
                apt-cache rdepends "$@"
                ;;
            *)
                # otherwise run apt list
                apt show "$@"
                ;;
        esac
        ;;
    mk|mark)
        shift
        case "$1" in
            -a|--auto)
                shift
                # use apt-mark to mark package as auto installed
                apt-mark auto "$@"
                ;;
            -h|--hold)
                shift
                # use apt-mark to put package on hold (cannot be installed, removed, updated, etc)
                apt-mark hold "$@"
                ;;
            -m|--manual)
                shift
                # use apt-mark to mark package as manually installed
                apt-mark manual "$@"
                ;;
            -sh|--showhold)
                shift
                # use apt-mark to list packages that are on hold
                apt-mark showhold "$@"
                ;;
            -sa|--showauto)
                shift
                # use apt-mark to list packages that are marked as auto installed
                apt-mark showauto "$@"
                ;;
            -sm|--showmanual)
                shift
                # use apt-mark to list packages that are marked as manually installed
                apt-mark showmanual "$@"
                ;;
            -u|--unhold)
                shift
                # use apt-mark to remove hold on package
                apt-mark unhold "$@"
                ;;
            *)
                # send all other arguments directly to apt-mark
                apt-mark "$@"
                ;;
        esac
        ;;
    in|install)
        shift
        apt update && sudo apt install "$@"
        ;;
    rm|remove)
        shift
        case "$1" in
            -p|--purge)
                shift
                apt remove --purge "$@"
                ;;
            -arm|--autoremove)
                shift
                apt remove --autoremove "$@"
                ;;
            -par|--purge-autoremove)
                shift
                apt remove --purge --autoremove "$@"
                ;;
            *)
                apt remove "$@"
                ;;
        esac
        ;;
    par|purge-autoremove)
        shift
        apt remove --purge --autoremove "$@"
        ;;
    arm|autoremove)
        shift
        apt autoremove "$@"
        ;;
    up|update|upgrade)
        shift
        apt update && sudo apt upgrade "$@"
        ;;
    fup|full-upgrade)
        shift
        apt update && sudo apt full-upgrade "$@"
        ;;
    ar|add-repo)
        shift
        apt-add-repository "$@"
        ;;
    help|-h|--help|"")
        helpfunc
        ;;
    *)
        # send anything else to apt
        apt "$@"
        ;;
esac
