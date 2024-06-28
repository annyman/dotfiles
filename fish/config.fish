if status is-interactive
    pfetch
end

if status is-login
    bash /home/anny/hyprstart.sh
end

starship init fish | source
