# coreutils
alias ls='ls -N --color=auto'

# misc
alias vhosts='vi /etc/hosts'
alias pwdcp="pwd | tr -d '\n' | pbcopy"
alias h='history | grep'
alias tldr='man'

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

# dev
alias gentags='find . -type f -iregex ".*\.js$" -not -path "./node_modules/*" -exec jsctags {} -f \; | sed '/^$/d' | sort'
alias inspect='node --inspect-brk'
alias php56='PATH=/usr/local/opt/php@5.6/bin:"$PATH" php'
