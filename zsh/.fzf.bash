# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

# Auto-completion
# ---------------
source "$HOME/.fzf/shell/completion.bash"

# Key bindings
# ------------
source "$HOME/.fzf/shell/key-bindings.bash"
