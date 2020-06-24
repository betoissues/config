#! /bin/sh

if [ ${#} -eq 2 ]; then
    echo "Provide a session name" 2>&1
    exit 1
fi
name=${1}

if tmux list-sessions | grep "^${name}:"; then
    tmux -2 attach-session -d -t ${name}
else
    case "${name}" in
        freebsd) dir=freebsd/base/head ;;
        freebsd-10) dir=freebsd/base/stable/10 ;;
        netbsd) dir=netbsd/src ;;
        ports) dir=freebsd/ports ;;
        *) dir="${name}" ;;
    esac
    if test -d "os/${dir}"; then
        ( cd "os/${dir}" && tmux -2 new-session -s ${name})
    else
        ( tmux -2 new-session -s "${name}")
    fi
fi
