# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ===========================
# Powerlevel10k Configuration
# ===========================

# Source Powerlevel10k configuration if it exists
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# ===================================
# Oh My Zsh Configuration and Plugins
# ===================================
# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set the theme to Powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Enable desired plugins
plugins=(git fzf tmux zsh-autosuggestions zsh-syntax-highlighting)

# Source Oh My Zsh to apply configurations
source $ZSH/oh-my-zsh.sh

# ===========================
# History and Update Settings
# ===========================

# Set history timestamp format
HIST_STAMPS="mm/dd/yyyy"

# Disable automatic Oh My Zsh updates
export UPDATE_ZSH_DAYS=324
export DISABLE_UPDATE_PROMPT=true

# ===========================
# Aliases

# ===========================

# General Aliases
alias gv='gvim'
alias vim='vim-x11'
alias nv='nvim'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias c='clear'

# Enhanced 'ls' with color support
alias ls='ls --color=auto'

# Quick Access to Common Directories
alias doc='cd ~/Documents'
alias dow='cd ~/Downloads'
alias des='cd ~/Desktop'

# Enhanced 'grep' with color
alias grep='grep --color=auto'

# Shortcut for executing the last command with privileges
alias please='doas $(fc -ln -1)'

# Directory Stack Controls
alias dirs='dirs -v'
alias 1='cd -'

# Git Aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias graph='git log --oneline --decorate --graph --all'

#xbps
alias i='doas xbps-install -S'         # Install packages
alias u='i; doas xbps-install -u xbps; doas xbps-install -u'
alias remove='doas xbps-remove -yR'          # Remove packages
alias q='xbps-query -Rs'                # Search for packages

# ===========================
# Custom Functions
# ===========================

# Function to extract archives
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "Don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# Function for making and entering a directory
mkcd() { mkdir -p "$@" && cd "$_"; }

# ===========================
# Clipboard Integration
# ===========================

# Clipboard Aliases
alias copy='xclip -selection clipboard'
alias paste='xclip -selection clipboard -o'

# Function to copy command output to clipboard
copycmd() {
    "$@" | xclip -selection clipboard
}

# Function to paste clipboard content into commands
pastecmd() {
    xclip -selection clipboard -o | "$@"
}

# ===========================
# Command Auto-Completion
# ===========================

# Enable command auto-completion
autoload -U compinit
compinit

# ===========================
# Zsh-Autosuggestions Configuration
# ===========================

# Set highlight style for autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=11"

# Set custom key binding to accept autosuggestions
bindkey '^ ' autosuggest-accept

# ===========================
# Zsh-Syntax-Highlighting Configuration
# ===========================

# Define highlighters for syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# ===========================
# Custom Zsh Theme Function
# ===========================

prompt_custom_theme() {
    local user_color="%F{green}"
    local directory_color="%F{blue}"
    local git_branch_color="%F{yellow}"
    local normal="%f%b"

    # User and Host information
    local user_host="${user_color}%n@%m${normal}"

    # Current working directory
    local current_directory="${directory_color}%~${normal}"

    # Git branch and status
    local git_branch='$(git_prompt_info)'
    ZSH_THEME_GIT_PROMPT_PREFIX="(${git_branch_color}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="${normal})"
    ZSH_THEME_GIT_PROMPT_CLEAN=""
    ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}*${normal}"

    # Construct the prompt
    PROMPT="${user_host} ${current_directory} ${git_branch} %# "
}

# Load custom theme
prompt_custom_theme

# Initialize colors and hooks
autoload -Uz colors && colors
autoload -Uz add-zsh-hook
add-zsh-hook precmd prompt_custom_theme

# ===========================
# Node Version Manager (NVM) Configuration
# ===========================

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"             # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# ===========================
# Editor and Shell Options
# ===========================

# Set default editor to Vim
export EDITOR=vim

# Enable Vi mode in Bash-like shells
set -o vi

# Ensure prompt_cr is unset to avoid conflicts
#unsetopt prompt_cr

# ===========================
# Reload .zshrc Alias
# ===========================

# Alias to reload .zshrc
alias utz="source ~/.zshrc"
#(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
#export XDG_RUNTIME_DIR=/run/user/$(id -u)
#export GDK_BACKEND=x11

