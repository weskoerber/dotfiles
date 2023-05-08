#!/usr/bin/zsh

. $(dirname $0)/./utils.sh

install_antigen() {
    install_dir="${XDG_DATA_HOME:-$HOME/.local/share/antigen}"
    if [ $(dir_exists $install_dir) -eq 0 ]; then
        echo "Updating antigen..."
        rm -rf $install_dir
    else
        echo "Installing antigen..."
    fi

    curl -L -s --create-dirs git.io/antigen-nightly --output "${XDG_DATA_HOME:-$HOME/.local/share}/antigen/antigen.zsh"
    # chmod +x "${XDG_DATA_HOME:-$HOME/.local/share}/antigen/antigen.zsh"
}

install_p10k() {
    install_dir="${XDG_DATA_HOME:-$HOME/.local/share}/powerlevel10"
    if $(dir_exists $install_dir) -eq 0 ]; then
        echo "Updating powerlevel10k"
        rm -rf $install_dir
    else
        echo "Installing powerlevel10k..."
    fi

    git clone --quiet --depth=1 https://github.com/romkatv/powerlevel10k.git $install_dir
}

get_dotnet_install() {
    install_file="$HOME/.local/bin/dotnet-install"
    if [ $(file_exists $install_file) -eq 0 ]; then
        echo "Updating dotnet-install..."
        rm $install_file
    else
        echo "Installing dotnet-install..."
    fi

    curl -L -s https://dot.net/v1/dotnet-install.sh --output $install_file

}

install_tpm() {
    install_dir="$HOME/.tmux/plugins/tpm"
    if [ $(dir_exists $install_dir) -eq 0 ]; then
        echo "Updating tpm"
        rm -rf $install_dir
    else
        echo "Installing tpm..."
    fi

    git clone https://github.com/tmux-plugins/tpm $install_dir
}

semaphore_file="${XDG_STATE_HOME:-$HOME/.local/state}/.first_run_complete"
if [ $(file_exists $semaphore_file) -ne 0 ]; then
    echo "First run detected. Setting things up..."
    echo "--------------------------------------------------------------------------------"
    # install_antigen
    # get_dotnet_install
    install_tpm

    echo "--------------------------------------------------------------------------------"
    echo "First run completed!"
    echo "Note: You may need to log out in order for changes to take effect."
    echo "To run first run setup again, remove the following file:"
    echo "    $semaphore_file"
    echo ""

    date +"%s" > $semaphore_file
fi
