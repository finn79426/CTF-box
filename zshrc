# export
export EDITOR=vim

# 自訂alias
alias py='python'
alias cls='clear'
alias ge='gedit'
alias wea='curl http://wttr.in/taipei?lang=zh -s | head -n 17'
alias rm='sudo rm'
alias apt-get="sudo apt-get"

# substitute tool
alias dpkg="sudo gdebi"
alias npm='yarn'

# Cryptography
alias floss='~/Tools/floss/floss'
alias ezcrypt="python2 ~/Tools/EzCryptSolver/EzSolve.py"
alias pkcrack='~/Tools/PKcrack/pkcrack'

# NetHacking
alias nc='ncat'
alias nmap="sudo nmap"

# 備份用
alias EditToolList='vim ~/CTF-box/install.sh'
alias backupconf='~/CTF-box/backup.sh'

# python2.7
alias python=python2
alias pip='sudo -H pip2'

# Pwn
alias gdb='gdb -q'
alias cs='checksec'
alias cyclic_find='~/selfmade_tools/cyclic_find.py'
alias cx='chmod +x'

# web security
alias githacker='sudo python ~/Tools/GitHacker/GitHacker.py'
alias magichash='echo "Password147186970!"'
alias easywebsolve="ruby ~/Tools/EasyWebSolver/EasySolver.rb"
alias sqlmap="python ~/Tools/sqlmap/sqlmap.py"
alias tplmap="python ~/Tools/tplmap/tqlmap.py"
alias commix="python ~/Tools/commix/commix.py"

# LogBook
function lb() {
	vim ~/Logbook/$(date '+%Y-%m-%d')
}

# cd && ls
function cd {
	builtin cd "$@" && ls --color=auto
}

# iTerm-like
ZSH_THEME="agnoster"
eval `dircolors ~/.dir_colors/dircolors`


# enable oh-my-zsh Plugins
export ZSH=$HOME/.oh-my-zsh

# plugin enable
plugins=(git zsh_reload sudo cp encode64 autojump ubuntu zsh-syntax-highlighting)

# autojump
[[ -s /home/howpwn/.autojump/etc/profile.d/autojump.sh  ]] && source /home/howpwn/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u

# ignore it
source $ZSH/oh-my-zsh.sh
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"/usr/lib/nvidia-384"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
