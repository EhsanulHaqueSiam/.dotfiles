# Path to your oh-my-zsh installation.
setopt prompt_subst

# Enable case-insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Zsh completions
autoload bashcompinit && bashcompinit
autoload -Uz compinit
compinit

# Kubernetes completions
source <(kubectl completion zsh)

# AWS completions (replace with the correct path if needed)
complete -C '/usr/bin/aws_completer' aws

# Zsh autosuggestions (replace path with Ubuntu-specific location)
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^w' autosuggest-execute
bindkey '^e' autosuggest-accept
bindkey '^u' autosuggest-toggle

# Starship prompt
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Locale settings
export LANG=en_US.UTF-8

# Default editor
export EDITOR=/usr/bin/nvim

# Aliases
alias la='tree'
alias cat='bat'

# Git aliases
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'

# Docker aliases
alias dco="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dx="docker exec -it"

# Directory navigation
alias ..="cd .."
alias ...="cd ../.."

# Kubernetes aliases
export KUBECONFIG=~/.kube/config
alias k="kubectl"
alias ka="kubectl apply -f"
alias kg="kubectl get"
alias kd="kubectl describe"
alias kdel="kubectl delete"
alias kl="kubectl logs -f"

# HTTP requests (assuming `xh` is installed)
alias http="xh"

# Eza (modern replacement for `ls`, ensure it's installed)
alias l="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"

# FZF settings
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Ranger file manager function
function ranger {
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    ranger --cmd="map Q chain shell echo %d > \"$tempfile\"; quitall" "$@"
    [ -f "$tempfile" ] && cd "$(cat "$tempfile")" || return
    rm -f "$tempfile"
}

alias rr='ranger'

# Navigation with FZF
cx() { cd "$@" && l; }
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && l; }
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }

# Zoxide for quick directory navigation
eval "$(zoxide init zsh)"

# Atuin (ensure it's installed)
eval "$(atuin init zsh)"

# Direnv (ensure it's installed)
eval "$(direnv hook zsh)"

# SDKMAN configuration
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Update PATH to reflect Ubuntu defaults and your tools
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

