function fish_user_key_bindings
    bind \co '__run_cmd "yazi-cwd"'
#    bind \cu '__run_cmd "pwd && tree -L 1 -shDFCcr --dirsfirst"'
    bind \cu '__run_cmd "exa-pretty"'
    bind \ce '__run_cmd "exit"'
    bind \cl '__run_cmd "clear"'
    bind \ch '__run_cmd "btop"'
end

function __run_cmd -a cmd
    commandline -it --insert "$cmd"
    commandline -it --insert \n
    commandline -f execute
end

function yazi-cwd
    set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd < "$tmp"; and test -n "$cwd"; and test "$cwd" != "$PWD"
        builtin cd -- "$cwd"
        set_color green; echo "➜ $cwd"; set_color normal
    end
    rm -f -- "$tmp"
end

function exa-pretty
    set_color cyan; printf "📁 %s\n" (pwd); set_color normal
    exa --tree --level=1 -lh --time-style=long-iso -r --sort=modified --group-directories-first --icons
end
