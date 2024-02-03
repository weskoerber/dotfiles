#!/bin/sh

deref=0
force=0
hard=0
verbose=0

src=""
dst=""

err() {
    echo "  E: $1" >&2
}

vlog() {
    [ $verbose -eq 1 ] && echo "  V: $1" >&2
}

usage() {
    echo "TODO"
}

for arg in "$@"; do
    case "$1" in
        -d | --deref)
            deref=0
            shift
            ;;
        -f | --force)
            force=1
            shift
            ;;
        -h | --help)
            usage
            exit 0
            ;;
        -v | --verbose)
            verbose=1
            shift
            ;;
        *)
            if [ -n "$dst" ]; then
                err "Invalid argument '$1'"
                exit 1
            fi

            if [ -z "$src" ]; then
                src="$1"
            else
                dst="$1"
            fi
            shift
            ;;
    esac
done

if [ -z "$src" ]; then
    err "Missing source"
    exit 1
fi

if [ -z "$dst" ]; then
    err "Missing destination"
    exit 1
fi

cmdstring="ln"
lnopts="-s"

if [ $force -eq 1 ]; then
    lnopts="${lnopts} -f"
fi

if [ $verbose -eq 1 ]; then
    lnopts="${lnopts} -v"
fi

if [ $deref -eq 1 ]; then
    lnopts="${lnopts} -L"
fi

src="$(realpath -q "$src")"
dst="$(realpath -q "$dst")"

vlog "$src => $dst"

if ! [ -a "$src" ]; then
    err "src does not exist"
    exit 1
fi

vlog "opts: $lnopts"

res=$(ln $lnopts "${src}" "${dst}" > /dev/null 2>&1)
e=$?

if [ $e -ne 0 ]; then
    err "ln failed ($e)"
    exit 1
fi
