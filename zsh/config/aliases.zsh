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

# fasd/fzf
alias v='fv'
alias m='fm'
alias j='fz'
alias mj='fmz'

# help
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

# dev
alias gentags='find . -type f -iregex ".*\.js$" -not -path "./node_modules/*" -exec jsctags {} -f \; | sed '/^$/d' | sort'
alias inspect='node --inspect-brk'
alias php56='PATH=/usr/local/opt/php@5.6/bin:"$PATH" php'
alias canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary --remote-debugging-port=9222 --user-data-dir=$HOME/.config/chrome-canary 2>/dev/null"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222 --user-data-dir=$HOME/.config/chrome 2>/dev/null"
