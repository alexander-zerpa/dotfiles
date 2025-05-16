# ======================= PLUGINS  ======================= #
# Plugins dir
ZSH_PLUGINS_DIR="${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/plugins"

plugins=(
    "zsh-users/zsh-completions"
    "zsh-users/zsh-autosuggestions"
    "jeffreytse/zsh-vi-mode"
    "zsh-users/zsh-syntax-highlighting"
)

# ================== zsh-vi-mode config ================== #
# Do the initialization when the script is sourced (i.e. Initialize instantly)
ZVM_INIT_MODE=sourcing

# ======================= Loading  ======================= #

for plugin in $plugins; do
    pluging_dir="$ZSH_PLUGINS_DIR/${plugin##*'/'}"
    if [ ! -d $pluging_dir ]; then
        mkdir -p $pluging_dir
        git clone https://github.com/$plugin $pluging_dir
    fi
    source $pluging_dir/*.plugin.zsh
done


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
command -v fzf > /dev/null 2>&1 && source <(fzf --zsh)

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

# Use starship promt
command -v starship > /dev/null 2>&1 && eval "$(starship init zsh)"
