PROMPT_COLOUR='green'  # Must remain set, evaluated every prompt

case $(uname) in
	Linux)
		uname='Linux'
		eval $(grep -E '^PRETTY_NAME=' /etc/os-release)
		os=$PRETTY_NAME
		unset PRETTY_NAME
		;;
	Darwin)
		uname='Darwin'
		os='macOS'
		;;
esac

# Mac: Source global zprofile to set initial PATH
[[ $os == 'macOS' ]] && source /etc/zprofile


#-------------------------------------------------------------------------------
# Paths {{{
#-------------------------------------------------------------------------------

# Paths
if [[ $os == 'macOS' ]]; then
	# Homebrew
	## Disable analytics (https://docs.brew.sh/Analytics)
	export HOMEBREW_NO_ANALYTICS=1
	## Don't create Brewfile.lock.json
	## (https://github.com/Homebrew/homebrew-bundle#install)
	export HOMEBREW_BUNDLE_NO_LOCK=1

	PATH="/usr/local/sbin:$PATH"  # Mainly for brew doctor
	# curl
	PATH="/usr/local/opt/curl/bin:$PATH"
	MANPATH="/usr/local/opt/curl/share/man:$MANPATH"
	# GNU coreutils
	PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
	MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
	# GNU findutils
	PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
	MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"
	# GNU grep
	PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
	MANPATH="/usr/local/opt/grep/libexec/gnuman:$MANPATH"
	# GNU sed
	PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
	MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
	# GNU tar
	PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
	MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"
	export MANPATH
elif [[ $uname == 'Linux' ]]; then
	PATH="$PATH:/snap/bin"  # Canonical snaps
fi
export PATH="$HOME/bin:$PATH"
export CDPATH="$HOME:$HOME/git"
# }}}


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
setopt glob_star_short 2> /dev/null  # zsh 5.2 or newer
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
setopt inc_append_history_time 2> /dev/null  # zsh 5.0.6 or newer
## Following will probably be desirable if hist_ignore_dups is unset
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
	print -nP '\033]2;%n@%m:%3~\007'  # Window title
	vcs_info  # Version control system prompt
}

# Run before running command
preexec() {
	print -nP '\033]2;$1 (%n@%m:%3~)\007'  # Window title
}
# }}}


#-------------------------------------------------------------------------------
# Completion [zshcompsys(1)] {{{
#-------------------------------------------------------------------------------

# Initialisation
## Mac: Add zsh-completions to function path
[[ $os == 'macOS' ]] && fpath=('/usr/local/share/zsh-completions' $fpath)

autoload -Uz compinit
[[ $os == 'macOS' ]] && compinit -u || compinit

# Completion system configuration
## Case-insensitive matching for lowercase only
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
## Unconditional menu completion
zstyle ':completion:*' menu select

## Mac: Disable hosts file completion; only used for blocking, not manual hosts
## entries
[[ $os == 'macOS' ]] && zstyle ':completion:*' hosts false
# }}}


#-------------------------------------------------------------------------------
# Environment variables {{{
#-------------------------------------------------------------------------------

# Zsh history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=15000
SAVEHIST=10000

# Editor
if whence -p nvim &> /dev/null; then
	export EDITOR='nvim'
elif whence -p vim &> /dev/null; then
	export EDITOR='vim'
else
	export EDITOR='vi'
fi

# less
export manpager='less --line-numbers'
export LESS='--quit-if-one-screen --ignore-case --raw-control-chars --hilite-unread --no-init'
## Set LESSOPEN if source-highlight is found
if src_hilite_path=$(whence -p src-hilite-lesspipe.sh 2> /dev/null); then
	export LESSOPEN="| $src_hilite_path %s"
fi
unset src_hilite_path
# }}}


#-------------------------------------------------------------------------------
# Aliases and functions {{{
#-------------------------------------------------------------------------------

# Double quotes perform parameter expansion when sourced
# Regardless of quotes, aliases will be substituted in other aliases

# Editor
alias vi='$EDITOR'
alias vim='$EDITOR'
[[ $EDITOR == *'vim' ]] && alias vimdiff='$EDITOR -d'

# File operations/navigation
alias mkdir='mkdir --parents'
## cp
alias cpr='cp --recursive --reflink=auto --sparse=always'
alias cp='cp --reflink=auto --sparse=always'
## ls
alias l='ls --color=auto'
alias la='ls --all --color=auto'
alias lal='ls -l --all --color=auto --human-readable'
alias lA='ls --almost-all --color=auto'
alias lAl='ls -l --almost-all --color=auto --human-readable'
alias ll='ls -l --color=auto --human-readable'
alias lla='ls -l --all --color=auto --human-readable'
alias llA='ls -l --almost-all --color=auto --human-readable'
alias ls='ls --color=auto'
## tree
alias tre='tree -C'
alias trea='tree -aC'
alias tree='tree -C'

# File viewing/editing
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias igrep='grep --ignore-case --color=auto'
alias les='less'
alias lesn='less --LINE-NUMBERS'

# Package updates
[[ $os == 'Arch Linux' ]] && ud() {
	sudo pacman -Syu $@ && sudo pacman -Rsn --noconfirm $(pacman -Qdtq) 2> /dev/null
}

# Shell built-ins
alias .='source'
alias history='fc -liD 0'
alias src='source $HOME/.zshrc'
alias psd='pushd'
alias pod='popd'

# ssh
alias scpk='scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=off'
alias scpkr='scpk -r'
alias scpr='scp -r'
alias scprk='scpkr'
alias sshk='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=off'

# sudo
alias s='sudo '
alias se='sudo -e'
alias sE='sudo --preserve-env'
alias si='sudo --login'
alias siu='sudo --login --user'
alias sk='sudo --reset-timestamp'
alias sudo='sudo '

# tmux
alias ta='tmux -CC attach-session -dt'  # Detach other clients
alias taa='tmux -CC attach-session -t'
alias tl='tmux list-sessions'
alias tk='tmux kill-session -t'
alias tkd='for i in $(tmux list-sessions | awk -F ":" "!/attached/ { print \$1 }"); do
	tmux kill-session -t $i
done'
tm() {
	if [[ -z $1 ]]; then tmux -CC
	else tmux -CC new-session -s $1
	fi
}

# Miscellaneous
alias aria2c='aria2c --seed-time=0'
alias ddi='sudo dd bs=16K conv=fsync status=progress'
alias virsh='virsh -c qemu:///system'
for tool in virt-clone virt-convert virt-install virt-xml; do
	alias $tool="$tool --connect qemu:///system"
done
if [[ $os == 'macOS' ]]; then
	alias o='open'
	alias oh='open .'
fi
# }}}


#-------------------------------------------------------------------------------
# Prompts {{{
#-------------------------------------------------------------------------------

# Prompt colour set at line 1
if [[ $os == 'macOS' ]]; then
	# Presume Mac is local machine, don't show hostname
	PROMPT='%F{$PROMPT_COLOUR}%B%3~%b%f ${vcs_info_msg_0_}%B%(?.%#.%F{red}%#%f)%b '
else
	# Show full hostname
	PROMPT='%F{$PROMPT_COLOUR}%B%M:%3~%b%f ${vcs_info_msg_0_}%B%(?.%#.%F{red}%#%f)%b '
fi
# }}}


# pkgfile - shows which missing package provides command
[[ $os == 'Arch Linux' ]] && source /usr/share/doc/pkgfile/command-not-found.zsh


#-------------------------------------------------------------------------------
# Autosuggestions {{{
# https://github.com/zsh-users/zsh-autosuggestions
#-------------------------------------------------------------------------------

autosuggestions=1
if [[ $os == 'macOS' ]]; then
	source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
	autosuggestions=$?
elif [[ $os == 'Arch Linux' ]]; then
	source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
	autosuggestions=$?
elif [[ $os == 'Ubuntu'* ]]; then
	source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
	autosuggestions=$?
fi
# }}}


#-------------------------------------------------------------------------------
# Syntax highlighting {{{
# https://github.com/zsh-users/zsh-syntax-highlighting
#-------------------------------------------------------------------------------

if [[ $os == 'macOS' ]]; then
	source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ $os == 'Arch Linux' ]]; then
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ $os == 'Ubuntu'* ]]; then
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
# }}}


#-------------------------------------------------------------------------------
# History substring search {{{
# https://github.com/zsh-users/zsh-history-substring-search
#-------------------------------------------------------------------------------

history_substring_search=1
if [[ $os == 'macOS' ]]; then
	source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
	history_substring_search=$?
elif [[ $os == 'Arch Linux' ]]; then
	source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
	history_substring_search=$?
fi
# }}}


#-------------------------------------------------------------------------------
# iTerm2 shell integration {{{
# https://www.iterm2.com/documentation-shell-integration.html
#-------------------------------------------------------------------------------

source "$HOME"/.iterm2_shell_integration.zsh 2> /dev/null
# }}}


#-------------------------------------------------------------------------------
# ZLE [zshzle(1)] {{{
#-------------------------------------------------------------------------------

bindkey -v  # Set 'main' keymap to viins

# Standard Widgets
## Movement
bindkey -M main '^[[1;2D' vi-backward-word  # Shift-Left
bindkey -M main '^[[1;5D' vi-backward-word  # Ctrl-Left
bindkey -M main '^[[1;2C' vi-forward-word  # Shift-Right
bindkey -M main '^[[1;5C' vi-forward-word  # Ctrl-Right
bindkey -M main '^[[H' vi-digit-or-beginning-of-line  # Home
bindkey -M main '^[[F' vi-end-of-line  # End
## Modifying Text
bindkey -M main '^?' backward-delete-char  # Backspace
bindkey -M main '^[[3~' delete-char  # Delete
bindkey -M vicmd '^[[3~' delete-char  # Delete
## Completion
bindkey -M main ' ' magic-space  # History expansion on space
bindkey -M main '^[[Z' reverse-menu-complete  # Shift-Tab

# User-defined/external widgets
if [[ autosuggestions -eq 0 ]]; then
	autosuggest-accept-space() {
		zle autosuggest-accept
		# Using magic-space as it doesn't print '^@'. Ideally wouldn't use this.
		zle magic-space
	}
	zle -N autosuggest-accept-space
	bindkey -M main '^ ' autosuggest-accept-space  # Ctrl-Space
fi

if [[ history_substring_search -eq 0 ]]; then
	historysubstringup-vicmd() {
		zle -K vicmd
		zle history-substring-search-up
	}
	zle -N historysubstringup-vicmd
	bindkey -M main '^[[1;2A' historysubstringup-vicmd  # Shift-Up
	bindkey -M vicmd '^[[1;2A' historysubstringup-vicmd  # Shift-Up
	bindkey -M vicmd 'K' historysubstringup-vicmd

	historysubstringdown-vicmd() {
		zle -K vicmd
		zle history-substring-search-down
	}
	zle -N historysubstringdown-vicmd
	bindkey -M main '^[[1;2B' historysubstringdown-vicmd  # Shift-Down
	bindkey -M vicmd '^[[1;2B' historysubstringdown-vicmd  # Shift-Down
	bindkey -M vicmd 'J' historysubstringdown-vicmd
fi

historyup-vicmd() {
	zle -K vicmd
	zle history-beginning-search-backward
}
zle -N historyup-vicmd
bindkey -M main '^[[A' historyup-vicmd  # Up
bindkey -M main '^[OA' historyup-vicmd  # Up (Set)
bindkey -M vicmd '^[[A' historyup-vicmd  # Up
bindkey -M vicmd '^[OA' historyup-vicmd  # Up (Set)
bindkey -M vicmd 'k' historyup-vicmd

historydown-vicmd() {
	zle -K vicmd
	zle history-beginning-search-forward
}
zle -N historydown-vicmd
bindkey -M main '^[[B' historydown-vicmd  # Down
bindkey -M main '^[OB' historydown-vicmd  # Down (Set)
bindkey -M vicmd '^[[B' historydown-vicmd  # Down
bindkey -M vicmd '^[OB' historydown-vicmd  # Down (Set)
bindkey -M vicmd 'j' historydown-vicmd

expandorcomplete-vicmd() {
	zle -K main
	zle expand-or-complete
}
zle -N expandorcomplete-vicmd
bindkey -M vicmd '\t' expandorcomplete-vicmd  # Tab
# }}}


unset uname os autosuggestions history_substring_search

# vim: set foldmethod=marker:
