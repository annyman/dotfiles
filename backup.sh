#!/bin/bash

dot_dir="/home/anny/dotfiles"
conf_dir="/home/anny/.config"
list_file="$dot_dir/dots.txt"

if [ ! -f "$list_file" ]; then
    echo "error: $list_file not found."
    exit 1
fi

cd "$dot_dir" || exit

while IFS= read -r app || [ -n "$app" ]; do
    # skip empty lines
    [ -z "$app" ] && continue

    target="$conf_dir/$app"
    pkg_dir="$dot_dir/$app/.config"

    # check if the config actually exists
    if [ ! -e "$target" ]; then
        echo "skipping $app: not found in .config"
        continue
    fi

    # check if it is already symlinked by stow
    if [ -L "$target" ]; then
        echo "skipping $app: already a symlink"
        continue
    fi

    echo "moving and stowing $app..."
    
    # create the mirror structure
    mkdir -p "$pkg_dir"
    
    # move the config into the repo
    mv "$target" "$pkg_dir/"
    
    # create the symlink
    stow "$app"

done < "$list_file"

echo "backup complete."
