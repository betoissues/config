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

source /opt/homebrew/share/antigen/antigen.zsh
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle Tarrasch/zsh-autoenv
antigen use ohmyzsh/ohmyzsh
antigen bundle cargo
antigen bundle docker
antigen bundle fzf
antigen bundle git
antigen bundle sudo
antigen theme gianu
antigen bundle MichaelAquilina/zsh-autoswitch-virtualenv
antigen apply

alias s="$XDG_CONFIG_HOME/tmux/tmux_session.sh"
alias l='eza -hbG --icons --color=automatic'
alias ll='eza -lhbrG@ --icons --color=automatic'
alias ls='eza --icons --color=automatic'
alias llm='eza -lbGd --sort=modified'
alias la='eza -albigmhHS --icons --color=automatic'
alias lx='eza -albigmhrHS --icons --color=automatic'
alias lS='eza -1 --icons --color=automatic'
alias lt='eza --tree --level=2'
alias grep="grep --color=auto"
alias mkdir="mkdir -pv"
alias cp='cp -iv -r'
alias mv="mv -iv"
alias rm="rm -Iv"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#source $XDG_CONFIG_HOME/cargo/env
export PATH="/opt/homebrew/bin:/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"
