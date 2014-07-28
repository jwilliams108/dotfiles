alias vm='VBoxManage'
alias vh='VBoxHeadless'

alias vl='VBoxManage list runningvms'
alias vla='VBoxManage list vms'

alias vinfo='VBoxManage showvminfo'
alias vclone='VBoxManage clonehd'
alias vmodify='VBoxManage modifyvm'

alias vstart='VBoxHeadless -s'
alias vstartgui='VBoxManage startvm'

alias vdiscard='VBoxManage discardstate'

function vsave() {
  VBoxManage controlvm $1 savestate
}

function vsnap() {
  VBoxManage snapshot $1 take $2
}

function vsnapdel() {
  VBoxManage snapshot $1 delete $2
}

function vsnaprestore() {
  VBoxManage snapshot $1 restore $2
}

function vsnapinfo() {
  VBoxManage snapshot $1 showinfo $2
}
