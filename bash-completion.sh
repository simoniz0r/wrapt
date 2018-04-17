_wraptbash() {
    local cur prev opts base
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    #
    #  The basic options we'll complete.
    #
    opts="list search info mark install remove aremove paremove update fupgrade addrepo"


    #
    #  Complete the arguments to some of the basic commands.
    #
    case "${prev}" in
        list|l)
            local packagelist="$(apt-cache pkgnames) --installed"
            COMPREPLY=( $(compgen -W "${packagelist}" -- ${cur}) )
            return 0
            ;;
        info|show)
            local packagelist="$(apt-cache pkgnames) --files --provides --depends --rdepends"
            COMPREPLY=( $(compgen -W "${packagelist}" -- ${cur}) )
            return 0
            ;;
        mark|m)
            local packagelist="$(dpkg --get-selections | grep -v deinstall) --showauto --showmanual --auto --hold --manual --showhold --unhold"
            COMPREPLY=( $(compgen -W "${packagelist}" -- ${cur}) )
            return 0
            ;;
        remove|rm|aremove|ar|paremove|par)
            local packagelist="$(dpkg --get-selections | grep -v deinstall) --purge --auto --pauto"
            COMPREPLY=( $(compgen -W "${packagelist}" -- ${cur}) )
            return 0
            ;;
        search|se|install|in)
            local packagelist="$(apt-cache pkgnames)"
            COMPREPLY=( $(compgen -W "${packagelist}" -- ${cur}) )
            return 0
            ;;
        *)
        ;;
    esac

   COMPREPLY=($(compgen -W "${opts}" -- ${cur}))  
   return 0
}

complete -F _wraptbash wrapt
