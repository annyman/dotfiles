#!/bin/bash

dot_dir="$HOME/dotfiles"
conf_dir="$HOME/.config"
list_file="$dot_dir/dots.txt"

if [ ! -f "$list_file" ]; then
    echo "error: $list_file not found."
    exit 1
fi

cd "$dot_dir" || exit

# ensure the base config directory exists
mkdir -p "$conf_dir"

while IFS= read -r app || [ -n "$app" ]; do
    [ -z "$app" ] && continue

    target="$conf_dir/$app"

    # stow will fail if fedora generated a default config file.
    # this checks if a real file/folder is there, and renames it to .bak
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "moving default $app config out of the way..."
        mv "$target" "${target}.bak"
    fi

    echo "restoring $app..."
    stow "$app"

done < "$list_file"

echo "all configs linked."
