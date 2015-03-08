#! /bin/zsh

function magnet-to-torrent () {
    [[ "$1" =~ xt=urn:btih:([^\&/]+) ]] || return 1

    hashh=${match[1]}

    if [[ "$1" =~ dn=([^\&/]+) ]]; then
        filename=${match[1]}
    else
        filename=${hashh}
    fi

    echo "d10:magnet-uri$#1:$1e" > "${filename}.torrent"

    unset hashh filename
}
