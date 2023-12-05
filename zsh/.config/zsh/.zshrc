autoload -U colors && colors
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
export PATH="$PATH:$HOME/.yarn/bin"

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
antigen use ohmyzsh/ohmyzsh
antigen bundle cargo
antigen bundle docker
antigen bundle fzf
antigen bundle git
antigen bundle sudo
antigen bundle MichaelAquilina/zsh-autoswitch-virtualenv
antigen theme $XDG_CONFIG_HOME/zsh/themes --no-local-clone
antigen apply

alias s="$XDG_CONFIG_HOME/tmux/tmux_session.sh"
alias l='exa -hbG --icons --color=automatic'
alias ll='exa -lhbrG@ --icons --color=automatic'
alias ls='exa --icons --color=automatic'
alias llm='exa -lbGd --sort=modified'
alias la='exa -albigmhHS --icons --color=automatic'
alias lx='exa -albigmhrHS --icons --color=automatic'
alias lS='exa -1 --icons --color=automatic'
alias lt='exa --tree --level=2'
alias grep="grep --color=auto"
alias mkdir="mkdir -pv"
alias cp='cp -iv -r'
alias mv="mv -iv"
alias rm="rm -Iv"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#source $XDG_CONFIG_HOME/cargo/env
