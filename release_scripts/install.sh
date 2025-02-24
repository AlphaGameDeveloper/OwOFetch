#!/bin/bash
set -euo pipefail

# Configuration Options - feel free to change
INSTALL_OWOFETCH_TO=/usr/bin
INSTALL_LIBFETCH_TO=/usr/lib
INSTALL_MANUAL_TO=/usr/share/man/man1
OWOFETCH_CONFIGURATION_DIRECTORY=/etc/owofetch # Default location where OwOFetch looks!

# Color codes
YELLOW="\x1b[33m"
RESET="\x1b[0m"

function step {
	printf "[STEP] $*... "
}
function stepDone {
	printf "done!\n"
}

if [ "$UID" -ne "0" ]; then
	printf "$YELLOW[WARN] You're not running this script as root.  That might be a problem :/$RESET\n"
	printf "$YELLOW[WARN] sudo $0$RESET\n"
fi

step "Create needed folders"
mkdir -pv $INSTALL_OWOFETCH_TO $INSTALL_LIBFETCH_TO/owofetch /usr/share/man/man1 $OWOFETCH_CONFIGURATION_DIRECTORY
stepDone

step "Install binary"
cp owofetch $INSTALL_OWOFETCH_TO
stepDone

step "Install libFetch"
cp libfetch.so $INSTALL_LIBFETCH_TO
cp fetch.h /usr/include
stepDone

step "Install configuration"
cp -r res/* $INSTALL_LIBFETCH_TO/owofetch
cp default.config $OWOFETCH_CONFIGURATION_DIRECTORY/config
stepDone

step "Install manual page"
cp ./owofetch.1.gz $INSTALL_MANUAL_TO
stepDone

printf "Installation Complete!\n"
printf ""

