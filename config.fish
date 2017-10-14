set -x EDITOR vim
set -x TERM xterm-256color

function fish_user_key_bindings
  bind \c] peco_select_ghq_repository
  bind \cr peco_select_history
  bind \x1b peco_z # Ctrl-[にバインドする
end

set -g theme_display_ruby no
set -g theme_display_date no
