autoload -U colors && colors
export GPG_TTY=$(tty)
export PATH=~/.composer/vendor/bin:$PATH

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History in cache directory:
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTFILE=$HOME/.config/zsh/history
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
LSCOLORS="Gxfxcxdxbxegedabagacad"
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

source /opt/homebrew/share/antigen/antigen.zsh
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle Tarrasch/zsh-autoenv
antigen use ohmyzsh/ohmyzsh
antigen bundle copypath
antigen bundle copyfile
antigen bundle zoxide
antigen bundle fzf
antigen bundle git
antigen bundle sudo
antigen theme gianu
antigen bundle MichaelAquilina/zsh-autoswitch-virtualenv
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle Aloxaf/fzf-tab
antigen bundle lincheney/fzf-tab-completion
antigen apply

zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons --color=automatic $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --icons --color=automatic $realpath'

alias s="$HOME/.config/tmux/tmux_session.sh"
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

eval "$(zoxide init --cmd cd zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="$(brew --prefix)/bin:$(brew --prefix)/opt/python@3.12/libexec/bin:$PATH"
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
