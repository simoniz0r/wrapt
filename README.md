# wrapt
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
