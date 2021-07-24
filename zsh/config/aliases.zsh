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

# macvim
alias mrem='mvim --remote-silent'
alias mtab='mvim -p --remote-tab-silent'

# fasd/fzf
alias v='fv'
alias m='fm'
alias j='fz'
alias mj='fmz'

# phpstan
alias phpstan='docker run -v $PWD:/app --rm ghcr.io/phpstan/phpstan'

# help
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help
