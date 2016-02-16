# incremental search
#bindkey '^R' history-incremental-search-backward
#bindkey '^S' history-incremental-search-forward

# history search
#bindkey "^[[A" history-beginning-search-backward
#bindkey "^[[B" history-beginning-search-forward
#bindkey '^[[A' history-substring-search-up
#bindkey '^[[B' history-substring-search-down

# emacs like command line movement
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^W" backward-delete-word
bindkey "^B" backward-word
bindkey "^F" forward-word
bindkey "^D" delete-word
bindkey "^K" kill-line
#bindkey "${key[Delete]}" delete-char
