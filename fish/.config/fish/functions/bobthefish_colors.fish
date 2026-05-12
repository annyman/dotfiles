function bobthefish_colors -S -d 'Noisy Boy color scheme for bobthefish'
    # Base terminal and command text
    set -x fish_color_normal f2b705
    set -x fish_color_command d95204
    set -x fish_color_param f2b705
    set -x fish_color_error ff0000

    # Base prompt segments
    set -x color_initial_segment_exit     5a0273 f2b705 --bold
    set -x color_initial_segment_su       73265e f2b705 --bold
    set -x color_initial_segment_jobs     5a0273 f2b705 --bold

    # Path segments 
    set -x color_path                     5a0273 f2b705
    set -x color_path_basename            5a0273 f28705 --bold
    set -x color_path_nowrite             5a0273 f28705
    set -x color_path_nowrite_basename    5a0273 f28705 --bold

    # VCS/Git segments (unchanged)
    set -x color_repo                     73265e f2b705
    set -x color_repo_work_tree           73265e f2b705 --bold
    set -x color_repo_dirty               73265e d95204
    set -x color_repo_staged              73265e f28705

    # User and Hostname
    set -x color_username                 5a0273 f28705 --bold
    set -x color_hostname                 73265e f2b705

    # Virtual environments (Fixed syntax and set to dark armor background)
    set -x color_rvm                      0f0518 d95204
    set -x color_virtualfish              0f0518 f28705
    set -x color_virtualgo                0f0518 f2b705
    set -x color_desk                     0f0518 f28705
    set -x color_node                     0f0518 d95204
    set -x color_nix                      0f0518 d95204
end
