#!/usr/bin/env sh

basedir=$(pwd)          # Sets the base directory for the find command
depth=0                 # Max depth to look
noswitch=0              # 0=stay in current session, 1=switch to new session
git=0                   # 0=git worktrees only, 1=all directories
running=0               # 1=list running sessions only
verbose=0               # 1=show verbose output
exec=""                 # tmux exec command or path to new session directory
filter=""               # directory filter

die() {
    elog "$1"
    exit 1
}

elog() {
    echo "err: $1" >&2
}

vlog() {
    if [ $verbose -ne 0 ]; then
        echo "dbg: $1" >&2
    fi
}

usage() {
    name=$(basename $0)
    bold=$(tput bold)
    uline=$(tput smul)
    reset=$(tput sgr0)
    cat <<< "Quickly create and switch between tmux sessions!

${bold}${uline}Usage:${reset} ${bold}${name}${reset} [OPTIONS]${reset}

${bold}${uline}Options:${reset}
    ${bold}-g, --git${reset}                Fuzzy find git worktrees only
    ${bold}-n, --noswitch${reset}           Don't switch to new tmux session.
    ${bold}-r, --running${reset}            Fuzzy find running sessions only
    ${bold}-v, --verbose${reset}            Enable verbose output
    ${bold}-b, --basedir${reset} <basedir>  Specify the base directory for the search
    ${bold}-d, --depth${reset} <depth>      Specify the max depth to search
    ${bold}-e, --exec${reset} <command>     Evaluate a shell command within session
    ${bold}-f, --filter${reset} <filter>    Filter directories with string (PCRE allowed)
    ${bold}-h, --help${reset}               Show simplified help page
    ${bold}-hh, --morehelp${reset}          Show detailed help page (this page)"
}

usage_detailed() {
    name=$(basename $0)
    bold=$(tput bold)
    uline=$(tput smul)
    reset=$(tput sgr0)
    cat <<< "${bold}$name${reset} - Quickly create and switch between tmux sessions!

Usage:
    ${bold}${name}${reset} [${bold}-ghnrv${reset}] [${bold}-b${reset} ${uline}basedir${reset}] [${bold}-d${reset} ${uline}depth${reset}] [${bold}-e${reset} ${uline}exec${reset}] [${bold}-f${reset} ${uline}filter${reset}]

Options:
    ${bold}-g, --git${reset}
        Fuzzy find git worktrees only.

    ${bold}-n, --noswitch${reset}
        Don't switch to new tmux session. If the tmux session already exists,
        nothing happens. If the session does not exist, it is created in the
        background and the shell stays attached to the current session (e.g.
        ${uline}:new-session -d${reset}).

    ${bold}-r, --running${reset}
        Fuzzy find running sessions only. Useful for when you're not
        currently attached to a tmux session. If you're attached to a tmux
        session, consider using ${uline}:choose-session${reset}.

    ${bold}-v, --verbose${reset}
        Enable verbose output. Useful for debugging.

    ${bold}-b, --basedir${reset} ${uline}basedir${reset}
        Specify the base directory for the search. For example, if
        ${uline}/home/user/Documents${reset} is specified, all directories above - such as
        ${uline}/home/user/Downloads${reset} - will not be searched. Use this when your
        target directory is not a subdirectory of your current directory. For
        example, you're in ${uline}/home/user${reset} and you want to start a session in
        ${uline}/var/log${reset}.

    ${bold}-d, --depth${reset} ${uline}depth${reset}
        Specify the max depth to search. Useful for very large directories.

    ${bold}-e, --exec${reset} ${uline}command${reset}
        Evaluate a shell ${uline}command${reset} within a tmux session. Especially useful for
        performing long-running tasks in the background that you don't want
        to tie up a terminal with. For example, you could do some logging
        in the background:

        \$ ${name} -n -e 'tail -f my_log.log | grep \'text\''

    ${bold}-f, --filter${reset}
        Filter directories with ${uline}filter${reset} string. Useful for when you have a
        directory fragment to filter on. This is passed to ${uline}grep -P${reset}, so PCRE
        regular expressions are allowed.

    ${bold}-h, --help${reset}
        Show simplified help page (this page)

    ${bold}-hh, --morehelp${reset}
        Show detailed help page"
}

for arg in "${@}"; do
    if [ -z "$1" ]; then
        continue
    fi

    case "$1" in
        -b | --basedir)
            basedir="$2"
            shift 2
            ;;
        -d | --depth)
            depth=$2
            shift 2
            ;;
        -e | --exec)
            exec="$2"
            shift 2
            ;;
        -f | --filter)
            filter=$2
            shift 2
            ;;
        -g | --git)
            git=1
            shift 1
            ;;
        -hh | --morehelp)
            usage_detailed
            exit 0
            ;;
        -h | --help)
            usage
            exit 0
            ;;
        -n | --noswitch)
            noswitch=1
            shift 1
            ;;
        -r | --running)
            running=1
            shift 1
            ;;
        -v | --verbose)
            verbose=1
            shift 1
            ;;
        *)
            elog "unrecognized argument: '${1}'"
            exit 1
            ;;
    esac
done

if [ -d "$filter" ]; then
    vlog "specified directory '$filter'"
    selected_dir=$(realpath $filter)
    new_session=$(basename $selected_dir)
    filter=""
elif [ $running -eq 0 ]; then
    vlog "filter directories"

    cmdstring="fd --type directory"

    if [ $depth -eq 1 ]; then
        cmdstring="${cmdstring} --maxdepth ${depth}"
    fi

    if [ $git -eq 1 ]; then
        # if git=1, we're looking for git worktrees only
        cmdstring="${cmdstring} --unrestricted --glob '.git'"
    else
        # otherwise, find all subdirs
        cmdstring="${cmdstring} ."
    fi

    cmdstring="${cmdstring} ${basedir}"

    if [ -n "$filter" ]; then
        vlog "filter: $filter"
        cmdstring="${cmdstring} | grep -P '${filter}'"
    fi

    selected_dir=$(eval $cmdstring | fzf)        # get fzf selection
    selected_dir=${selected_dir%.git/*}          # strip .git subdir when git=1
    new_session=$(basename "$selected_dir")      # name session the directory name
    new_session=${new_session//./_}
else
    vlog "filter runnning sessions"
    running_sessions=$(tmux list-sessions 2> /dev/null) || die "no sessions"
    new_session=$(echo "$running_sessions" | awk '{print substr($1, 0, length($1)-1)}' | fzf)
fi

if [ -z "$new_session" ] && [ -z "$selected_dir" ]; then
    vlog "nothing selected"
    exit 0
fi

current_session=""
if [ -n "$TMUX" ]; then
    # we're currently inside a tmux session.
    # detach first as to not nest sessions, saving the current session name

    current_session=$(tmux display-message -p '#S')

    if [ "$current_session" == "$new_session" ]; then
        vlog "client is already attached to session '$new_session'"

        exit 0
    fi

    vlog "currently attached to session '$current_session'"
fi

pgrep tmux > /dev/null 2>&1
if [ $? -ne 0 ]; then
    vlog "tmux is not running"
    vlog "creating session '$new_session' in '$selected_dir'"

    # tmux is not running, create and attach to session
    tmux new-session -s "$new_session" -c "$selected_dir" $exec > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        elog "failed creating session '$new_session' in '$selected_dir'"
        exit 1
    fi

    exit 0
fi

tmux has-session -t "$new_session" > /dev/null 2>&1
if [ $? -ne 0 ]; then
    # tmux session does not exist; create it
    vlog "creating session '$new_session' in '$selected_dir'"

    tmux new-session -d -s "$new_session" -c "$selected_dir" $exec > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        elog "failed creating session '$new_session' in '$selected_dir'"
        exit 1
    fi
else
    vlog "session '$new_session' exists"
fi

if [ $noswitch -eq 0 ]; then
    # attach to new session
    if [ -z "$current_session" ]; then
        vlog "attaching to session '$new_session'"
        tmux attach-session -t "$new_session" > /dev/null 2>&1
    else
        vlog "switching client to session '$new_session'"
        tmux switch-client -t "$new_session" > /dev/null 2>&1
        if [ $? -ne 0 ]; then
            elog "failed switching client to session '$new_session'"
            exit 1
        fi
    fi
fi
