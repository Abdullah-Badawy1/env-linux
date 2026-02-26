# ===========================
# Optimized Zsh configuration (Oh My Zsh + Powerlevel10k) for Arch Linux
# ===========================

# Keep this file focused on interactive shell behavior. Login/session env lives in ~/.zprofile and ~/.zshenv.

# Oh My Zsh base dir
export ZSH="$HOME/.oh-my-zsh"

# Powerlevel10k instant prompt — keep at the top for speed
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Theme and plugins
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Source Oh My Zsh if installed
if [ -s "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
fi

# Omarchy integration for zsh (portable pieces only)
OMARCHY_BASE="$HOME/.local/share/omarchy"
if [ -d "$OMARCHY_BASE/default/bash" ]; then
  [ -f "$OMARCHY_BASE/default/bash/aliases" ] && source "$OMARCHY_BASE/default/bash/aliases"
  [ -f "$OMARCHY_BASE/default/bash/functions" ] && source "$OMARCHY_BASE/default/bash/functions"
fi

# LAZY LOADING for mise and zoxide
# These functions will load the tools on first use, instead of on every shell start.

# if command -v mise >/dev/null 2>&1; then
#   mise() {
#     unfunction mise
#     eval "$(command mise activate zsh)"
#     mise "$@"
#   }
# fi

if command -v zoxide >/dev/null 2>&1; then
  zoxide() {
    unfunction zoxide
    eval "$(command zoxide init zsh)"
    zoxide "$@"
  }
fi


if command -v eza >/dev/null 2>&1; then
  alias ls='eza'
  alias ll='eza -lah'
  alias la='eza -A'
  alias tree='eza --tree'
  # if need the eza should install the eza first
elif command -v lsd >/dev/null 2>&1; then
  alias ls='lsd'
  alias ll='lsd -lah'
  alias la='lsd -A'
  alias tree='lsd --tree'
fi

# History (use XDG state dir)
HISTFILE="$XDG_STATE_HOME/zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_VERIFY SHARE_HISTORY APPEND_HISTORY INC_APPEND_HISTORY \
       HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS HIST_REDUCE_BLANKS

# Editing mode
set -o vi

# Useful options
setopt AUTO_CD AUTO_LIST AUTO_MENU AUTO_PARAM_SLASH COMPLETE_IN_WORD \
       ALWAYS_TO_END PATH_DIRS AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT
unsetopt CORRECT CORRECT_ALL

# Key bindings
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# Completion tuning and cache
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.zsh/cache
[[ -d ~/.zsh/cache ]] || mkdir -p ~/.zsh/cache
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B%d%b'

# Oh My Zsh speed tweaks
ZSH_DISABLE_COMPFIX=true
DISABLE_AUTO_UPDATE=true
DISABLE_UPDATE_PROMPT=true
DISABLE_MAGIC_FUNCTIONS=true

# Aliases
alias nano='nvim'
alias gv='nvim-qt'
alias nv='nvim'
alias c='cd'
alias cl='clear'
alias xx='exit'
alias gpp='g++'


# Quick dirs
alias doc='cd ~/Documents'
alias dow='cd ~/Downloads'
alias des='cd ~/Desktop'
alias conf='cd ~/.config'
alias omar='cd ~/.local/share/omarchy'

# Grep colors
alias grep='grep --color=auto'
alias fgrep='fgrep --color=always'
alias egrep='egrep --color=always'

# GPU app launch examples
alias reso='LD_LIBRARY_PATH="/opt/resolve/libs:$LD_LIBRARY_PATH" __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia /opt/resolve/bin/resolve > /dev/null 2>&1 & disown'
alias blend='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia blender'

# Sudo last cmd
alias please='doas $(fc -ln -1)'

# Directory stack
alias dirs='dirs -v'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias graph='git log --oneline --decorate --graph --all'

# Pacman/AUR
alias i='doas pacman -S'
alias u='doas pacman -Syu'
alias remove='doas pacman -Rns'
alias q='pacman -Ss'
alias qi='pacman -Qi'
alias qs='pacman -Qs'
alias qo='pacman -Qo'
alias clean='doas pacman -Sc'
alias autoremove='doas pacman -Rns $(pacman -Qtdq)'
alias yi='yay -S'
alias yu='yay -Syu'
alias yq='yay -Ss'

# Flatpak
alias flati='flatpak install'
alias flatu='flatpak update'
alias flatr='flatpak uninstall'
alias flatq='flatpak search'

# System info
alias ports='ss -tulanp'
alias meminfo='free -m -l -t'
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# ESP-IDF
alias esp='source /opt/esp-idf/export.sh'

# Systemd
alias sc='sudo systemctl'
alias scs='systemctl status'
alias sce='sudo systemctl enable'
alias scd='sudo systemctl disable'
alias scr='sudo systemctl restart'
alias sct='sudo systemctl stop'
alias scstart='sudo systemctl start'
alias screload='sudo systemctl reload'
alias scu='systemctl --user'
alias scus='systemctl --user status'
alias scue='systemctl --user enable'
alias scud='systemctl --user disable'
alias scur='systemctl --user restart'

# Journalctl
alias jc='journalctl'
alias jcf='journalctl -f'
alias jcu='journalctl -u'
alias jce='journalctl -p err'
alias jcw='journalctl -p warning'

# Helper aliases
alias utz="source ~/.zshrc"
alias theme="~/.config/alacritty/switch-theme.sh"

# Functions
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz)  tar xzf "$1" ;;
      *.bz2)     bunzip2 "$1" ;;
      *.rar)     unrar x "$1" ;;
      *.gz)      gunzip "$1" ;;
      *.tar)     tar xf "$1" ;;
      *.tbz2)    tar xjf "$1" ;;
      *.tgz)     tar xzf "$1" ;;
      *.zip)     unzip "$1" ;;
      *.Z)       uncompress "$1" ;;
      *.7z)      7z x "$1" ;;
      *.xz)      unxz "$1" ;;
      *.lzma)    unlzma "$1" ;;
      *) echo "Don't know how to extract '$1'..." ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}

mkcd() {
  if [ $# -eq 0 ]; then
    echo "Usage: mkcd <directory_name>"
    return 1
  fi
  mkdir -p "$@" && cd "$_"
}

pk() {
  if [ $# -eq 0 ]; then
    echo "Usage: pk <process_name>"
    return 1
  fi
  ps aux | grep -v grep | grep "$@" | awk '{print $2}' | xargs kill
}

myip() { curl -s ifconfig.me }

backup() {
  if [ $# -eq 0 ]; then
    echo "Usage: backup <file>"
    return 1
  fi
  cp -r "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
}

# Autosuggestions styling and performance
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8,underline"
bindkey '^ ' autosuggest-accept
bindkey '^[[Z' autosuggest-accept
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_IGNORE_WIDGETS=(original-widget bracketed-paste accept-line)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Syntax highlighting perf
ZSH_HIGHLIGHT_MAXLENGTH=300

# FZF integration (if installed)
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# Powerlevel10k config
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/abdo/.lmstudio/bin"
# End of LM Studio CLI section
