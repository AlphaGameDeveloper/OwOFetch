#!/bin/bash
set -xe
printf "Uninstalling...\n"
rm -f /usr/bin/owofetch
rm -rf /usr/lib/owofetch
rm -f /usr/lib/libfetch.so
rm -f /usr/include/fetch.h
rm -rf /etc/owofetch
rm -f /usr/share/man/man1/owofetch.1.gz
printf "Done!\n"

