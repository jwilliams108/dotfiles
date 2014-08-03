#CURRENT_BG='NONE'
SEGMENT_SEPARATOR='⮀'

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

prompt_context () {
  local user=`whoami`
  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    echo -n "%F{blue}$user%f on %F{green}%m%f"
  fi
}

# Dir: current working directory
prompt_dir() {
  prompt_segment 10 250 '%~'
}

# PROMPT
PROMPT_DIR='[$(prompt_context)$(prompt_dir)$(prompt_end) ]'

PROMPT_SIGN='%F{red}%B➜ %b%f'

GIT_PROMPT_INFO='$(git_prompt_info)'
GIT_PROMPT_STATUS='$(git_prompt_status)'

PROMPT="${PROMPT_DIR}${GIT_PROMPT_INFO}${GIT_PROMPT_STATUS}
${PROMPT_SIGN} "

# Git stuff
ZSH_THEME_GIT_PROMPT_PREFIX=" %F{cyan}%B~%b%f git:(%F{blue}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=")%F{yellow} ✗ "
ZSH_THEME_GIT_PROMPT_CLEAN=")%F{green} ✔ "
ZSH_THEME_GIT_PROMPT_ADDED="%F{green}✚ %F{black}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%F{blue}✹ %F{black}"
ZSH_THEME_GIT_PROMPT_DELETED="%F{red}✖ %F{black}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{yellow}✭ %F{black}"
ZSH_THEME_GIT_PROMPT_RENAMED=" ➜ "
ZSH_THEME_GIT_PROMPT_UNMERGED="═"
ZSH_THEME_GIT_PROMPT_AHEAD="⬆ "
ZSH_THEME_GIT_PROMPT_BEHIND="⬇ "
ZSH_THEME_GIT_PROMPT_DIVERGED="⬍ "
