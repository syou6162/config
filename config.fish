set -x EDITOR vim
set -x TERM xterm-256color

function fish_user_key_bindings
  bind \c] peco_select_ghq_repository
end

set -g theme_display_ruby no
set -g theme_display_date no
