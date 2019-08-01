PROMPT_COLOUR="green"

case "$(uname)" in
    Linux)
        uname='Linux'
        os="eval $(grep -E '^PRETTY_NAME' /etc/os-release)"
        ;;
    Darwin)
        uname='Darwin'
        os='macOS'
        ;;
esac

# Mac: Source global zprofile to set initial PATH
[[ $os == 'macOS' ]] && source /etc/zprofile


#-------------------------------------------------------------------------------
# Options [zshoptions(1)] {{{
#-------------------------------------------------------------------------------

# Changing Directories
setopt auto_cd

# Completion
setopt complete_in_word
setopt list_packed

# Expansion and Globbing
setopt brace_ccl
setopt extended_glob
setopt glob_star_short
setopt hist_subst_pattern
setopt mark_dirs
setopt numeric_glob_sort
setopt rc_expand_param

# History
setopt extended_history
setopt hist_fcntl_lock
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt inc_append_history_time
# Following will probably be desirable if hist_ignore_dups is unset
#setopt hist_expire_dups_first
#setopt hist_find_no_dups

# Input/Output
setopt correct
setopt interactive_comments

# Prompting
setopt prompt_subst

# ZLE
unsetopt beep
# }}}


#-------------------------------------------------------------------------------
# vcs_info [zshcontrib(1)] {{{
#-------------------------------------------------------------------------------

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '%F{magenta}(%b)%f%c%u '
zstyle ':vcs_info:*' actionformats '%F{magenta}(%b)%f%c%u %B%a%%b '
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{green}●%f'  # dot: Unicode U+25CF
zstyle ':vcs_info:*' unstagedstr '%F{red}●%f'  # dot: Unicode U+25CF
# }}}


#-------------------------------------------------------------------------------
# Pre-commands {{{
#-------------------------------------------------------------------------------

# Run before displaying prompt
precmd() {
    # Window title
    print -nP '\033]2;%n@%m:%3~\007'

    # Version control system prompt
    vcs_info
}

# Run before running command
preexec() {
    # Window title
    print -nP '\033]2;$1 (%n@%m:%3~)\007'
}
# }}}


#-------------------------------------------------------------------------------
# Completion [zshcompsys(1)] {{{
#-------------------------------------------------------------------------------

# Mac: Add zsh-completions to function path
[[ $os == 'macOS' ]] && fpath=('/usr/local/share/zsh-completions' $fpath)

# compinit
autoload -Uz compinit
if [[ $os == 'macOS' ]]; then
    compinit -u
else
    compinit
fi

# Unconditional menu completion
zstyle ':completion:*' menu select

# Case insensitive matching for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# }}}


#-------------------------------------------------------------------------------
# ZLE [zshzle(1)] {{{
#-------------------------------------------------------------------------------

bindkey -v  # Set 'main' keymap to viins 

# User-defined widgets, declarations and bindings
historyup-vicmd() {  # Switch to vicmd and search on up arrow
    zle -K vicmd
    zle history-beginning-search-backward
}

historydown-vicmd() {  # Switch to vicmd and search on down arrow
    zle -K vicmd
    zle history-beginning-search-forward
}

expandorcomplete-vicmd() {  # Switch to main and expand/complete on tab
    zle -K main
    zle expand-or-complete
}

# Declarations
zle -N historyup-vicmd
zle -N historydown-vicmd
zle -N expandorcomplete-vicmd

# Bindings
bindkey -M main  "^[[A" historyup-vicmd  # Up Arrow
bindkey -M vicmd "^[[A" historyup-vicmd  # Up Arrow
bindkey -M vicmd "k"    historyup-vicmd 
bindkey -M main  "^[[B" historydown-vicmd  # Down Arrow
bindkey -M vicmd "^[[B" historydown-vicmd  # Down Arrow
bindkey -M vicmd "j"    historydown-vicmd
bindkey -M vicmd "\t"   expandorcomplete-vicmd  # Tab


# Standard Widgets
# Movement
bindkey -M main "^[[1;2D" vi-backward-word  # Shift-Left Arrow
bindkey -M main "^[[1;5D" vi-backward-word  # Ctrl-Left Arrow
bindkey -M main "^[[1;2C" vi-forward-word  # Shift-Right Arrow
bindkey -M main "^[[1;5C" vi-forward-word  # Ctrl-Right Arrow
bindkey -M main "^[[H"    vi-digit-or-beginning-of-line  # Home
bindkey -M main "^[[F"    vi-end-of-line  # End

# Modifying Text
bindkey -M main "^?"     backward-delete-char  # Backspace
bindkey -M main  "^[[3~" delete-char  # Delete
bindkey -M vicmd "^[[3~" delete-char  # Delete

# Completion
bindkey -M main " " magic-space  # History expansion on space
# }}}


#-------------------------------------------------------------------------------
# Variables {{{
#-------------------------------------------------------------------------------

# Zsh history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=15000
SAVEHIST=10000

# Editors/pagers
export EDITOR="nvim"
export MANPAGER="less --line-numbers"
less_opts=(
    "--quit-if-one-screen"
    "--ignore-case"
    "--RAW-CONTROL-CHARS"
    "--HILITE-UNREAD"
    "--no-init"
)
export LESS="$(eval echo $less_opts)"
unset less_opts

if [[ $os == 'macOS' ]]; then
    # source-highlight with less
    export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"

    # Disable Homebrew analytics (https://docs.brew.sh/Analytics)
    export HOMEBREW_NO_ANALYTICS=1

    # Paths
    PATH="/usr/local/sbin:$PATH"  # Mainly for brew doctor
    # GNU coreutils
    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
    # GNU findutils
    PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
    MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"
    # GNU sed
    PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
    MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
    # GNU tar
    PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
    MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"
    export PATH MANPATH
else
    # source-highlight with less
    export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
fi

export PATH="$HOME/bin:$PATH"
export CDPATH="$HOME"

# Intel
export http_proxy="http://proxy-chain.intel.com:911"
export https_proxy="http://proxy-chain.intel.com:912"
# }}}


#-------------------------------------------------------------------------------
# Aliases {{{
#-------------------------------------------------------------------------------

# Notes
## Use single quotes; double quotes perform parameter expansion when sourced.
## Regardless of quotes, aliases will be substituted in other aliases.

# Shell built-ins
alias .='source'
alias src='source "$HOME"/.zshrc'
alias psd='pushd'
alias pod='popd'

# sudo
alias s='sudo '
alias se='sudo -e'
alias si='sudo -i'
alias sudo='sudo '

# File viewing/editing
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias les='less'
alias lesn='less --LINE-NUMBERS'
alias o='open'

# Process management
alias top='htop'

# Applications
alias aria2c='aria2c --seed-time=0'
alias dl='aria2c'
alias ddi='sudo dd bs=16K conv=fsync status=progress'
alias gitpullall='for i in "$HOME"/git/*; do git -C "$i" pull; done'
alias hist='fc -liD -31'
alias scpk='scp -o UserKnownHostsFile=/dev/null'
alias sshk='ssh -o UserKnownHostsFile=/dev/null'

# cp
alias cpr='cp --recursive --reflink=auto --sparse=always'
alias cp='cp --reflink=auto --sparse=always'

# ls
alias l='ls --color=auto'
alias la='ls --all --color=auto'
alias lal='ls -l --all --color=auto --human-readable'
alias lA='ls --almost-all --color=auto'
alias lAl='ls -l --almost-all --color=auto --human-readable'
alias ll='ls -l --color=auto --human-readable'
alias lla='ls -l --all --color=auto --human-readable'
alias llA='ls -l --almost-all --color=auto --human-readable'
alias ls='ls --color=auto'

# tree
alias tre='tree -C'
alias trea='tree -aC'
alias tree='tree -C'

# tmux
alias tm='tmux -CC'
alias ta='tmux -CC attach-session -dt'  # Detach other clients
alias taa='tmux -CC attach-session -t'
alias tl='tmux list-sessions'
alias tk='tmux kill-session -t'
alias tkd='for i in $(tmux list-sessions | awk -F ":" "!/attached/ { print \$1 }"); do tmux kill-session -t "$i"; done'

# Neovim
alias vi='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'

if [[ $os == 'macOS' ]]; then
    alias ud='brew update && brew upgrade && brew cask upgrade --greedy && brew cleanup'
elif [[ $os == 'Arch Linux' ]]; then
    alias ud='pikaur -Syu $@ && sudo pacman -Rsn --noconfirm $(pacman -Qdtq) 2> /dev/null'
fi
# }}}


#-------------------------------------------------------------------------------
# Prompts {{{
#-------------------------------------------------------------------------------

# Prompt colour set at top of .zshrc
# "~ % " or "~ (root) # "
PROMPT='%B%F{$PROMPT_COLOUR}%3~%f%b ${vcs_info_msg_0_}%B%(!.%F{red}(root) %#%f.%#)%b '
# }}}


# pkgfile - shows which missing package provides command
[[ $os == 'Arch Linux' ]] && source /usr/share/doc/pkgfile/command-not-found.zsh


#-------------------------------------------------------------------------------
# Syntax highlighting {{{
# zsh-syntax-highlighting must be at end of zshrc
#-------------------------------------------------------------------------------

if [[ $os == 'macOS' ]]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
# }}}

unset uname os

# vim: set expandtab shiftwidth=0 tabstop=4 foldmethod=marker:

