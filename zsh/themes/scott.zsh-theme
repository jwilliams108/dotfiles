# config vars {{{

CURRENT_BG='NONE'
SEGMENT_SEPARATOR='\ue0b0'
SEGMENT_SEPARATOR_RIGHT='\ue0b2'

# Git stuff
ZSH_THEME_GIT_PROMPT_PREFIX=" %F{cyan}%B~%b%f git:(%F{blue}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=")%F{yellow} ✗ %f"
ZSH_THEME_GIT_PROMPT_CLEAN=")%F{green} ✔ %f"
ZSH_THEME_GIT_PROMPT_ADDED="%F{green}✚ %f"
ZSH_THEME_GIT_PROMPT_MODIFIED="%F{blue}✹ %f"
ZSH_THEME_GIT_PROMPT_DELETED="%F{red}✖ %f"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{yellow}✭ %f"
ZSH_THEME_GIT_PROMPT_RENAMED=" ➜ "
ZSH_THEME_GIT_PROMPT_UNMERGED="═"
ZSH_THEME_GIT_PROMPT_AHEAD="⬆ "
ZSH_THEME_GIT_PROMPT_BEHIND="⬇ "
ZSH_THEME_GIT_PROMPT_DIVERGED="⬍ "

#}}}

# helper functions {{{

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%}"
  else
    echo -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# variant of prompt_segment with right separator
prompt_segment_right() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR_RIGHT%{$fg%}"
  else
    echo -n "$CURRENT_BG%{$bg%}%{$fg%}"
  fi
  [[ -n $3 ]] && echo -n "%{$bg%}%{$fg%}$3"
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

# current info
prompt_info() {
  local bg fg
  local user=`whoami`
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    echo -n "%F{blue}$user%f on %F{green}%m%f %{$bg%}%{$fg%}$SEGMENT_SEPARATOR%f%k"
  fi
}

prompt_context() {
  prompt_info 14 0
}

prompt_dir() {
  prompt_segment 14 0 ' %~'
}

prompt_time() {
  #prompt_segment_right 0 14 '%D{%H:%M:%S}'
  echo -n '%D{%H:%M:%S}'
}


#}}}

# build prompt {{{

PROMPT_DIR='[ $(prompt_context)$(prompt_dir)$(prompt_end) ]'
PROMPT_SIGN='%F{red}➜ %f'
PROMPT_TIME='[ $(prompt_time) ]'

GIT_PROMPT_INFO='$(git_prompt_info)'
GIT_PROMPT_STATUS='$(git_prompt_status)'

# left prompt
PROMPT="${PROMPT_DIR}${GIT_PROMPT_INFO}${GIT_PROMPT_STATUS}
${PROMPT_SIGN} "

# right prompt
RPROMPT="${PROMPT_TIME}"

#}}}
