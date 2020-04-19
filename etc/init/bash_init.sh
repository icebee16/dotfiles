#!/bin/bash

set -eu

# by OS
case ${OSTYPE} in
    darwin*)
        echo "Running on OSX"
        source etc/init/bash_darwin.sh
        ;;
    linux*)
        if   [ -e /etc/debian_version ] ||
                 [ -e /etc/debian_release ]; then
            # Check Ubuntu or Debian
            if [ -e /etc/lsb-release ]; then
                # Ubuntu
                echo "Running on ubuntu"
                source etc/init/bash_ubuntu.sh
            else
                # Debian
                echo "Not implemented debian.sh"
            fi
        elif [ -e /etc/fedora-release ]; then
            # Fedra
            echo "Not implemented fedora.sh"
        elif [ -e /etc/redhat-release ]; then
            if [ -e /etc/oracle-release ]; then
                # Oracle Linux
                echo "Not implemented oracle.sh"
            else
                # Red Hat Enterprise Linux
                # CentOS
                echo "Not implemented redhat.sh"
            fi
        elif [ -e /etc/turbolinux-release ]; then
            # Turbolinux
            echo "Not implemented turbol.sh"
        elif [ -e /etc/SuSE-release ]; then
            # SuSE Linux
            echo "Not implemented suse.sh"
        elif [ -e /etc/mandriva-release ]; then
            # Mandriva Linux
            echo "Not implemented mandriva.sh"
        elif [ -e /etc/vine-release ]; then
            # Vine Linux
            echo "Not implemented vine.sh"
        elif [ -e /etc/gentoo-release ]; then
            # Gentoo Linux
            echo "Not implemented gentoo.sh"
        else
            # Other
            echo "unkown distribution"
        fi
        ;;
esac
