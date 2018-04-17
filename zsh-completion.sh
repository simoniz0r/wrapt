#compdef wrapt

__wrapt () {
    local curcontext="$curcontext" state line
    typeset -A opt_args
 
    _arguments \
        '1: :->args'\
        '2: :->input'
 
    case $state in
    args)
        _arguments '1:arguments:(list search info mark install remove aremove paremove update fupgrade addrepo)'
        ;;
    *)
        case $words[2] in
        list|l)
            compadd "$@" $(echo "$(apt-cache pkgnames) --installed")
            ;;
        info|show)
            compadd "$@" $(echo "$(apt-cache pkgnames) --files --provides --depends --rdepends")
            case $words[3] in
                *)
                    compadd "$@" $(echo "$(apt-cache pkgnames)")
                    _files
                    ;;
            esac
            ;;
        mark|m)
            compadd "$@" $(echo "$(dpkg --get-selections | grep -v deinstall) --showauto --showmanual --auto --hold --manual --showhold --unhold")
            case $words[3] in
                *)
                    compadd "$@" $(echo "$(dpkg --get-selections | grep -v deinstall)")
                    ;;
            esac
            ;;
        remove|rm|aremove|ar|paremove|par)
            compadd "$@" $(echo "$(dpkg --get-selections | grep -v deinstall) --purge --auto --pauto")
            case $words[3] in
                *)
                    compadd "$@" $(echo "$(dpkg --get-selections | grep -v deinstall)")
                    ;;
            esac
            ;;
        search|se)
            compadd "$@" $(echo "$(apt-cache pkgnames)")
            ;;
        install|in)
            compadd "$@" $(echo "$(apt-cache pkgnames)")
            _files
            ;;
        *)
            _files
            ;;
        esac
    esac
}

__wrapt
