# ======================= PLUGINS  ======================= #
# Plugins dir
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# ====================== Installing ====================== #
# Install zinit
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode

# ================== zsh-vi-mode config ================== #
# Do the initialization when the script is sourced (i.e. Initialize instantly)
ZVM_INIT_MODE=sourcing

# Always starting with insert mode
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT

zvm_after_init_commands+=(
    # History search rebinding zsh-vi-mode defaults after load
    "zvm_bindkey viins '^n' history-search-backward"
    "zvm_bindkey viins '^p' history-search-forward"
    # Fzf shell integration
    "command -v fzf > /dev/null 2>&1 && source <(fzf --zsh)"
)

# ======================= HISTORY  ======================= #
HISTZISE=1000
HISTFILE="${HOME}/.zsh_history"
SAVEHIST=$HISTZISE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ====================== COMPLETION ====================== #
# Incase completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Completion colors
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Activate competion system
autoload -Uz compinit
compinit

# Fzf shell integration
# source <(fzf --zsh)

# ======================== ENVARS ======================== #
# direnv faint log text
export DIRENV_LOG_FORMAT=$'\033[2mdirenv: %s\033[0m'

if [ -d "$HOME/.local/bin" ]; then
    path+=("$HOME/.local/bin")
    export PATH
fi

# ======================= KEYBINDS ======================= #
# Vi mode
bindkey -v

# Better movement on insert mode
bindkey -M viins '^[h' backward-char
bindkey -M viins '^[l' forward-char

# History search
bindkey -M viins '^n' history-search-backward
bindkey -M viins '^p' history-search-forward

# ======================= ALIASES  ======================= #
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'

# Human readable commands
alias df='df -h'
alias du='du -h'
alias free='free -h'

# ======================== EXTRA  ======================== #
# replace cat with bat and used as manpager
if command -v bat > /dev/null 2>&1; then
    alias cat="$(which bat) -pp"
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    export MANROFFOPT="-c"
    alias -g -- --help="--help 2>&1 | bat --language=help --style=plain"
    export LESSOPEN="|bat --paging=never --color=always %s"
fi

# replace ls and tree with lsd unless not found
if command -v lsd > /dev/null 2>&1; then
    alias ls=$(which lsd)
    command -v tree > /dev/null 2>&1 || alias tree="$(which lsd) --tree"
else
    alias ls='ls --color=auto'
fi

# Enables syntax highlighting (needs to be last)
zinit light zsh-users/zsh-syntax-highlighting

# Use starship promt
command -v starship > /dev/null 2>&1 && eval "$(starship init zsh)"
