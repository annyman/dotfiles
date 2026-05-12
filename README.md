a simple, automated way to manage configuration files using GNU stow.

## dependencies

you need these installed on your system:

- `git`
- `stow`

## setup

1. clone this repository to your home folder:

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
```

2. create a `dots.txt` file in the root of the repo.
3. list the names of the config folders you want to track, one per line. example
   `dots.txt`:

```text
waybar
fish
nvim
```

4. make sure the scripts are executable:

```bash
chmod +x backup.sh restore.sh
```

## backup.sh

run this to add new apps from `~/.config` to your repo.

```bash
chmod +x backup.sh
./backup.sh
```

this reads `dots.txt`, moves the target folders from `~/.config/` into
`~/dotfiles/`, and uses stow to link them back.

## restore.sh

run this on a new machine to apply your configs.

```bash
chmod +x restore.sh
./restore.sh
```

this reads `dots.txt`, moves any existing default configs out of the way
(renaming them to `.bak`), and uses stow to link your repo configs into
`~/.config/`.

it keeps everything generic so you can just drop it straight into your repo.

---

_made by annyman_
