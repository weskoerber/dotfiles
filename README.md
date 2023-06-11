# Wes Koerber's dotfiles

A collection of configuration files for all my favorite software.
Also includes a script for easy installation.

# Table of contents

- [Installation](#installation)
- [Screenshots](#screenshots)
- [Updating](#updating)
- [Uninstallation](#uninstallation)
- [Contributing](#contributing)
- [TODO](#todo)

# Installation

1. Install all desired programs
2. [Download](https://www.nerdfonts.com/font-downloads) and install a Nerd
Font. Have a look at the
[Nerd Font README](https://github.com/ryanoasis/nerd-fonts/blob/master/readme.md)
for installation instructions.

    *Note for `iTerm2` users - Please enable the Nerd Font at iTerm2 > Preferences > Profiles > Text > Non-ASCII font > Hack Regular Nerd Font Complete.*

    *Note for `HyperJS` users - Please add `"Hack Nerd Font"` Font as an option to `fontFamily` in your `~/.hyper.js` file.*

3. Run the `install.sh` script

[(Back to top)](#table-of-contents)

# Screenshots

TODO

[(Back to top)](#table-of-contents)

# Updating

Because the `install.sh` script installs config files using symlinks, all you
need to do is pull changes from the repo. The config files should automatically
be updated via the symlink.

If for some reason you need to update manually, re-run the `install.sh` script.
It will skip already symlinked targets, as well as targets that are physical
directories.

[(Back to top)](#table-of-contents)

# Uninstallation

Run `uninstall.sh`. By default, it will only remove targets that are symlinked.
This is done as a precautionary measure as to not remove any config files that
were not linked by the `install.sh` script.

Removal of config files must be done one at a time; there is no `--all` option
like there is in the `install.sh` script.

If you wish to force removal of config files, even if the target is a physical
directory, you may provide the `--force` option.

[(Back to top)](#table-of-contents)

# Contributing

Don't lol

[(Back to top)](#table-of-contents)

# TODO

- Automate installation of certain applications
    - cargo
    - yarn
    - dotnet
    - go
    - composer

[(Back to top)](#table-of-contents)
