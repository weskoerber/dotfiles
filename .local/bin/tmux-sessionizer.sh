#!/usr/bin/env sh

basedir=$(pwd)          # Sets the base directory for the find command
depth=0                 # Max depth to look
reattach=0              # 0=switch to new session, 1=stay in current session
git=0                   # 0=git worktrees only, 1=all directories
exec=""                 # command to exec after attaching to tmux session

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
        -r | --reattach)
            reattach=1
            shift 1
            ;;
        *)
            if [ -z "$exec" ]; then
                exec=$@
                break
            else
                echo "unrecognized argument: '${1}'"
                exit 1
            fi
            ;;
    esac
done

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

if [ -z "$selected_dir" ]; then
    exit 0 # nothing was selected
fi

pgrep tmux > /dev/null 2>&1
if [ $? -ne 0 ]; then
    # tmux is not running, create and attach to session
    tmux new-session -s $new_session -c $selected_dir $exec > /dev/null 2>&1
    exit 0
fi

if [ -n "$TMUX" ]; then
    # we're currently inside a tmux session.
    # detach first as to not nest sessions, saving the current session name
    current_session=$(tmux display-message -p '#S')
fi

tmux has-session -t $new_session > /dev/null 2>&1
if [ $? -ne 0 ]; then
    # tmux session does not exist; create it
    tmux new-session -d -s $new_session -c $selected_dir $exec > /dev/null 2>&1
fi

if [ $reattach -eq 0 ]; then
    # attach to new session
    tmux switch-client -t $new_session > /dev/null 2>&1
fi
