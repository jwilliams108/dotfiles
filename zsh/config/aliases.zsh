# coreutils
alias ls=ls -N --color=tty

# misc
alias vhosts='vi /etc/hosts'
alias pwdcp="pwd | tr -d '\n' | pbcopy"
alias h='history | grep'

# cmus
alias cmus='cmus 2>/dev/null'

# homebrew
alias bi='brew -v install'
alias bu='brew -v upgrade'
alias bup='brew update'
alias bcup='brew cleanup'
alias bout='brew outdated'

# tmux
alias tmux='tmux -u'

# macvim
alias mrem='mvim --remote-silent'
alias mtab='mvim -p --remote-tab-silent'

# fasd
alias j='z'
alias m='d -e mvim'

# help
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

# misc
alias tldr='man'
