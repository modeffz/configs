#!/usr/bin/env bash

case "$1" in
    region)
        hyprshot -m region -o $HOME/Pictures/Screenshots/
        ;;
    output)
        hyprshot -m output -o $HOME/Pictures/Screenshots/
        ;;
esac
