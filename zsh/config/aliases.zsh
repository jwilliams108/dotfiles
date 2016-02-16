# misc
alias vhosts='vi /etc/hosts'
alias pwdcp="pwd | tr -d '\n' | pbcopy"
alias h='history | grep'

# cmus
alias cmus='cmus 2>/dev/null'
# chrome
alias canary='/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary'
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

# homebrew
alias bi='brew -v install'
alias bu='brew -v upgrade --all'
alias bup='brew update'
alias bcup='brew cleanup'
alias bout='brew outdated'

# tmux
alias tmux='tmux -u'

# macvim
alias mtab='mvim -p --remote-tab'

# fasd
alias j='z'
alias m='d -e mvim'

# js/phpcs
alias jscs='jscs -p airbnb'
alias phpcs="phpcs --standard=$HOME/.phpcs/phpcs.xml"

# help
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

# misc
alias tldr='man'
