
set -U fish_color_command 66cccc
set -U fish_color_normal normal
set -U fish_color_redirection d3d0c8
set -U fish_color_end cc99cc
set -U fish_color_error f2777a
set -U fish_color_quote ffcc66
set -U fish_color_comment cc99cc
set -U fish_color_param 99cc99
set -U fish_color_match 6699cc
set -U fish_color_selection c0c0c0
set -U fish_color_search_match ffff00
set -U fish_color_history_current normal
set -U fish_color_operator 6699cc
set -U fish_color_escape 66cccc
set -U fish_color_cwd 008000
set -U fish_color_cwd_root 800000
set -U fish_color_valid_path normal
set -U fish_color_autosuggestion ffcc66
set -U fish_color_user 00ff00
set -U fish_color_host normal
set -U fish_pager_color_completion normal
set -U fish_color_cancel normal
set -U fish_pager_color_description B3A06D yellow
set -U fish_pager_color_prefix normal --bold --underline
set -U fish_pager_color_progress brwhite --background=cyan

starship init fish | source
alias t="zellij --layout main_layout"

alias gucon="nano ~/.config/guake.config"
alias stcon="nano ~/.config/starship.toml"
alias zecon="nano ~/.config/zellij/config.yaml"

eval ~/miniconda3/bin/conda "shell.fish" "hook" $argv | sourc
mamba deactivate
