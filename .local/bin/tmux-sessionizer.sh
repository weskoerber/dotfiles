#!/usr/bin/env sh

basedir=$(pwd)          # Sets the base directory for the find command
depth=0                 # Max depth to look
noswitch=0              # 0=stay in current session, 1=switch to new session
git=0                   # 0=git worktrees only, 1=all directories
running=0               # 1=list running sessions only
verbose=0               # 1=show verbose output
exec=""                 # tmux exec command or path to new session directory

elog() {
    echo "err: $1" >&2
}

vlog() {
    if [ $verbose -ne 0 ]; then
        echo "dbg: $1" >&2
    fi
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
        -g | --git)
            git=1
            shift 1
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
            if [ -z "$exec" ]; then
                exec=$@
                break
            else
                vlog "unrecognized argument: '${1}'"
                exit 1
            fi
            ;;
    esac
done

if [ -d "$exec" ]; then
    vlog "specified directory '$exec'"
    selected_dir=$(realpath $exec)
    new_session=$(basename $selected_dir)
    exec=""
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

    cmdstring="${cmdstring} ${basedir}"          # finalize cmdstring

    selected_dir=$(eval $cmdstring | fzf)        # get fzf selection
    selected_dir=${selected_dir%.git/*}          # strip .git subdir when git=1
    new_session=$(basename "$selected_dir")      # name session the directory name
    # new_session="${new_session// /_}"            # replace spaces with underscores
else
    vlog "filter runnning sessions"
    new_session=$(tmux list-sessions | awk '{print substr($1, 0, length($1)-1)}' | fzf)
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
