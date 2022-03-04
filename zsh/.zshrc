#!/bin/zsh

# +---------+
# | PRIVATE |
# +---------+
# Load private environment variables
[ -f $DOTFILES/private.zsh ] && . $DOTFILES/private.zsh

zstyle ':autocomplete:*' min-input 2 # int
# Wait until this many characters have been typed, before showing completions.


source ~/zsh-autocomplete/zsh-autocomplete.plugin.zsh


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

