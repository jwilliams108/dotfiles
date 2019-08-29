# fv - edit given file or search in recently used files
function fv {
    local file
    file="$(fasd -Rfl "$*" | fzf -1 -0 --no-sort +m)" && [ -n "$file" ] && ${EDITOR:-vim} "${file}" || return 1
}

# fm - edit given file using mvim or search in recently used files
function fm {
    local file
    file="$(fasd -Rfl "$*" | fzf -1 -0 --no-sort +m)" && [ -n "$file" ] && mvim "${file}" || return 1
}

# ff - change into directory containing given file or search in recently used files
function ff() {
  local file
  file=$(fasd -Rfl "$*" | fzf -1 -0 --no-sort +m) && cd "$(dirname $file)" || return 1
}

# fz - change into given dir or search in recently used dirs
function fz() {
  local dir
  dir=$(fasd -Rdl "$*" | fzf -1 -0 --no-sort +m) && cd "${dir}" || return 1
}

# fz - change into given dir and open in mvim or search in recently used dirs
function fmz() {
  local dir
  dir=$(fasd -Rdl "$*" | fzf -1 -0 --no-sort +m) && cd "${dir}" && mvim . || return 1
}

# fh - repeat history
function fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# vagrant
function vs() {
  #List all vagrant boxes available in the system including its status, and try to access the selected one via ssh
  cd $(cat ~/.vagrant.d/data/machine-index/index | jq '.machines[] | {name, vagrantfile_path, state}' | jq '.name + "," + .state  + "," + .vagrantfile_path'| sed 's/^"\(.*\)"$/\1/'| column -s, -t | sort -rk 2 | fzf | awk '{print $3}'); vagrant ssh
}

# git helpers

# fshow - git commit browser
function fshow() {
  local out sha q
  while out=$(
      git log --decorate=short --graph --oneline --color=always |
      fzf --ansi --multi --no-sort --reverse --query="$q" --print-query); do
    q=$(head -1 <<< "$out")
    while read sha; do
      [ -n "$sha" ] && git show --color=always $sha | less -R
    done < <(sed '1d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
  done
}

# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
function fstash() {
  local out q k sha
    while out=$(
      git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
      fzf --ansi --no-sort --query="$q" --print-query \
          --expect=ctrl-d,ctrl-b);
    do
      q=$(head -1 <<< "$out")
      k=$(head -2 <<< "$out" | tail -1)
      sha=$(tail -1 <<< "$out" | cut -d' ' -f1)
      [ -z "$sha" ] && continue
      if [ "$k" = 'ctrl-d' ]; then
        git diff $sha
      elif [ "$k" = 'ctrl-b' ]; then
        git stash branch "stash-$sha" $sha
        break;
      else
        git stash show -p $sha
      fi
    done
}
