#!/bin/sh
printf '\033c\033]0;%s\a' Delivery Game
base_path="$(dirname "$(realpath "$0")")"
"$base_path/my_game.x86_64" "$@"
