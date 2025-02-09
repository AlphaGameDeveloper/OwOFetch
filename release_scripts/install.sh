#!/bin/bash
set -xe
printf "Installing binary...\n"
mkdir -pv /usr/bin /usr/lib/owofetch /usr/share/man/man1 /etc/owofetch
cp owofetch /usr/bin
cp libfetch.so /usr/lib
cp fetch.h /usr/include
cp -r res/* /usr/lib/owofetch
cp default.config /etc/owofetch/config
cp ./owofetch.1.gz /usr/share/man/man1
printf "Done!\n"

