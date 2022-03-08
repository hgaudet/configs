#!/bin/zsh

# +---------+
# | PRIVATE |
# +---------+
# Load private environment variables
[ -f $DOTFILES/private.zsh ] && . $DOTFILES/private.zsh


zstyle ':autocomplete:*' default-context ''
# '': Start each new command line with normal autocompletion.
# history-incremental-search-backward: Start in live history search mode.

zstyle ':autocomplete:*' min-delay 0.05  # float
# Wait this many seconds for typing to stop, before showing completions.

zstyle ':autocomplete:*' min-input 2  # int
# Wait until this many characters have been typed, before showing completions.

zstyle ':autocomplete:*' ignored-input '' # extended glob pattern
# '':     Always show completions.
# '..##': Don't show completions when the input consists of two or more dots.

zstyle ':autocomplete:*' list-lines 16  # int
# If there are fewer than this many lines below the prompt, move the prompt up
# to make room for showing this many lines of completions (approximately).

zstyle ':autocomplete:history-search:*' list-lines 10  # int
# Show this many history lines when pressing ↑.

zstyle ':autocomplete:history-incremental-search-*:*' list-lines 10  # int
# Show this many history lines when pressing ⌃R or ⌃S.

zstyle ':autocomplete:*' recent-dirs cdr
# cdr:  Use Zsh's `cdr` function to show recent directories as completions.
# no:   Don't show recent directories.
# zsh-z|zoxide|z.lua|z.sh|autojump|fasd: Use this instead (if installed).
# ⚠️ NOTE: This setting can NOT be changed at runtime.

zstyle ':autocomplete:*' insert-unambiguous no
# no:  Tab inserts the top completion.
# yes: Tab first inserts a substring common to all listed completions, if any.

zstyle ':autocomplete:*' widget-style complete-word
# complete-word: (Shift-)Tab inserts the top (bottom) completion.
# menu-complete: Press again to cycle to next (previous) completion.
# menu-select:   Same as `menu-complete`, but updates selection in menu.
# ⚠️ NOTE: This setting can NOT be changed at runtime.

zstyle ':autocomplete:*' fzf-completion no
# no:  Tab uses Zsh's completion system only.
# yes: Tab first tries Fzf's completion, then falls back to Zsh's.
# ⚠️ NOTE: This setting can NOT be changed at runtime and requires that you
# have installed Fzf's shell extensions.

# Add a space after these completions:
zstyle ':autocomplete:*' add-space \
    executables aliases functions builtins reserved-words commands

source ~/zsh-autocomplete/zsh-autocomplete.plugin.zsh


##
# NOTE: All configuration below should come AFTER sourcing zsh-autocomplete!
#

# Up arrow:
# bindkey '\e[A' up-line-or-search
# bindkey '\eOA' up-line-or-search
# up-line-or-search:  Open history menu.
# up-line-or-history: Cycle to previous history line.

# Down arrow:
# bindkey '\e[B' down-line-or-select
# bindkey '\eOB' down-line-or-select
# down-line-or-select:  Open completion menu.
# down-line-or-history: Cycle to next history line.

# Control-Space:
# bindkey '\0' list-expand
# list-expand:      Reveal hidden completions.
# set-mark-command: Activate text selection.

# Uncomment the following lines to disable live history search:
zle -A {.,}history-incremental-search-forward
zle -A {.,}history-incremental-search-backward

# Return key in completion menu & history menu:
bindkey -M menuselect '\r' .accept-line
# .accept-line: Accept command line.
# accept-line:  Accept selection and exit menu.


# Which plugins would you like to load?
plugins=(git)

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Autoload zsh add-zsh-hook and vcs_info functions (-U autoload w/o substition, -z use zsh style)
autoload -Uz add-zsh-hook vcs_info
# Enable substitution in the prompt.
setopt prompt_subst
# Run vcs_info just before a prompt is displayed (precmd)
add-zsh-hook precmd vcs_info
# add ${vcs_info_msg_0} to the prompt
# e.g. here we add the Git information in red  
PROMPT='%F{210}%~%f ${vcs_info_msg_0_} > '
RPROMPT='%F{015}%T%f'

# Display the existence of files not yet known to VCS
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='%F{014}!%f'
    fi
}

# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr '%F{196}*%f'
zstyle ':vcs_info:*' stagedstr '%F{028}+%f'
# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats       '(%F{069}%b%u%c%f)'
zstyle ':vcs_info:git:*' actionformats '(%F{069}%b|%a%u%c%f)'


# When iterating through history, skip continuous duplicate commands
setopt HIST_IGNORE_DUPS

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.


DOTFILES="$HOME/projects/configs"
# Add .zsh to fpath for git autocompletion
zstyle ':completion:*:*:git:*' script $DOTFILES/zsh/git/git-completion.bash
fpath=(~/.zsh $fpath)
autoload -Uz compinit && compinit

alias lsa="ls -a"

export PATH="/opt/homebrew/bin:$PATH"
export PATH="/Users/hgaudet/Library/Python/3.8/bin:$PATH"
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh