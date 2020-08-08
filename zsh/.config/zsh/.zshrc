autoload -U colors && colors

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$XDG_CONFIG_HOME/zsh/history
LSCOLORS="Gxfxcxdxbxegedabagacad"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

source /usr/share/zsh/share/antigen.zsh
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle Tarrasch/zsh-autoenv
antigen use oh-my-zsh
antigen bundle cargo
antigen bundle docker
antigen bundle dotenv
antigen bundle fzf
antigen bundle git
antigen bundle sudo
antigen theme $XDG_CONFIG_HOME/zsh/themes --no-local-clone
antigen apply

alias s="$XDG_CONFIG_HOME/tmux/tmux_session.sh"
alias ls="exa"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source $XDG_CONFIG_HOME/cargo/env
