#!/bin/bash

# Supply for CTF-box(Vagrant)

# Step 1 : Ask (if all as 'y')
# Step 2 : Update & Upgrade & Install sys-dev-tools
# Step 3 : Install Requirement
# Step 4 : Create Tools dir
# Step 5 : Crontab Update
# Step 6 : Update .tmux.conf
# Step 7 : Update .vimrc
# Step 8 : Update Code templates
# Step 9 : Git & GitHub Setting
# Step 10 : Install CTF-tools
# Step 11 : Install Zsh
# ALL DONE !

function ask()
{
	while true; do
		read -p "$2" choice
		case $choice in
			[Yy]* )
				declare -g "$1=true"
				break;
				;;
			[Nn]* )
				declare -g "$1=false"
				break;
				;;
			*)
				echo "Please enter y or n"
				;;
		esac
	done
}



ask DIR 'Do you want make directory "~/Tools"? (y/n):'
ask UPGRADE "Update and upgrade everything? (y/n):"
ask CRONTAB "Update crontab? (y/n)"
ask ZSH "Install zsh? (y/n):"
ask GIT "Setup SSH to GitHub? (y/n):"
ask ZSHRC "Update .zshrc? (y/n)"
ask VIMRC "Update .vimrc? (y/n)"
ask TEMPLATE "Update Code templates and Snippets? (y/n)"
ask GDBINIT "Update .gdbinit? (y/n)"
ask TMUX "Update .tmux.conf? (y/n)"



if $UPGRADE; then
	echo "+==========================+"
	echo "|Updating & Upgrading..... |"
	echo "+==========================+"
	sudo apt-get update
	sudo apt-get -y upgrade
	sudo apt-get -y dist-upgrade
	sudo apt-get -y install --fix-missing
	sudo apt-get -y autoremove
	sudo apt-get -y autoclean
	sudo apt-get install -y python-pip python3-pip python-dev libffi-dev build-essential virtualenvwrapper 
	sudo pip install autopep8	# vim-autopep8
	sudo pip3 install neovim		# deoplete.nvim 
	sudo apt-get 
	sudo -H pip install pip --upgrade
	sudo -H pip install --upgrade virtualenv
	# Install vim
	sudo apt-get install -y vim
	sudo apt-get install -y powerline
	# Install nodejs
	sudo apt-get install -y nodejs npm
	# Install Java8
	sudo add-apt-repository -y ppa:webupd8team/java
	sudo apt-get update
	sudo apt-get install -y oracle-java8-installer
	sudo apt-get install -y oracle-java8-set-default

fi



echo "+===========================+"
echo "|Install Require Tools..... |"
echo "+===========================+"
sudo apt-get install -y git	# vagrant 預設已有
sudo apt-get install -y curl
sudo apt-get install -y tmux	# vagrant 預設已有
sudo apt-get install -y gdebi
sudo apt-get install -y cmake



if $DIR; then
	mkdir ~/Tools
fi



if $CRONTAB; then
	cd "$(dirname "$0")"
	crontab "crontab"
fi



if $TMUX; then
	cd "$(dirname "$0")"
	cp tmux.conf ~/.tmux.conf
	git clone https://github.com/racterub/tmux-mem-cpu-load.git ~/.tmux
	cd ~/.tmux/
	cmake .
	sudo make
	sudo make install
fi



if $VIMRC; then
	cd "$(dirname "$0")"
	cp vimrc ~/.vimrc
	# vim-Solarized (這邊安裝的時候可能會有問題，需要手動檢查)
	cd /tmp ; git clone https://github.com/altercation/vim-colors-solarized.git
	cd vim-colors-solarized/colors ; mkdir ~/.vim/colors ; mv solarized.vim ~/.vim/colors/
	# Vundle Plugin
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
fi



if $TEMPLATE; then
	cd "$(dirname "$0")"
	cp -r templates .Code_templates
	cp -rf snippets ~/.vim/
fi



if $GIT; then
	echo "+========================+"
	echo "|Setup Git & GitHub..... |"
	echo "+========================+"
	git config --global user.name "howpwn" ; git config --global user.email "finn79426@gmail.com"
	git config --global core.editor vim
	git config --global alias.st status
	git config --global alias.lg log
	git config --global alias.cm commit
	ssh-keygen -t rsa -b 4096 -C "finn79426@gmail.com"
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_rsa
	sudo apt-get install -y xclip
	xclip -sel clip < ~/.ssh/id_rsa.pub
	echo "+================================+"
	echo "|Now copy your SSH key to GitHub |"
	echo "+================================+"
	sleep 3
fi



##############################################################################



echo "+=======================+"
echo "|Install CTF-Tools..... |"
echo "+=======================+"

# Multi architecture
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install -y gcc-multilib

# strace, ltrace
sudo apt-get install -y strace ltrace

# pwntools
sudo apt-get install -y python2.7 python-pip python-dev git libssl-dev libffi-dev build-essential
sudo pip install --upgrade pwntools

# ROPgadget
sudo -H pip install ropgadget

# angr
sudo apt-get -y install python-dev libffi-dev build-essential virtualenvwrapper
sudo -H pip install angr --upgrade

# Pwngdb + Peda
sudo apt-get install -y gdb
git clone https://github.com/scwuaptx/peda.git ~/Tools/peda
cp ~/Tools/peda/.inputrc ~/
git clone https://github.com/scwuaptx/Pwngdb.git ~/Tools/Pwngdb/
echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
if $GDBINIT; then
	cd "$(dirname "$0")"
	cp gdbinit ~/.gdbinit
fi

# floss
mkdir ~/Tools/floss
wget https://s3.amazonaws.com/build-artifacts.floss.flare.fireeye.com/travis/linux/dist/floss -P ~/Tools/floss
chmod +x ~/Tools/floss/floss

# radare2
git clone https://github.com/radare/radare2.git ~/Tools/radare2/
cd ~/Tools/radare2/ ; sudo sys/install.sh

##############################################################################



# XORtool
sudo -H pip install docopt
git clone https://github.com/hellman/xortool.git ~/Tools/XORtool
cd ~/Tools/XORtool ; sudo python setup.py install
cd ~/ ; rm -rf ~/Tools/XORtool

# EzCryptSolver
git clone https://github.com/finn79426/EzCryptSolver.git ~/Tools/EzCryptSolver
cd ~/Tools/EzCryptSovlver ; sudo -H pip install -r requirements.txt

# PKcrack
cd ~/Tools ; wget https://www.unix-ag.uni-kl.de/~conrad/krypto/pkcrack/pkcrack-1.2.2.tar.gz
tar xzf pkcrack-1.2.2.tar.gz ; mv pkcrack-1.2.2 PKcrack ; rm pkcrack-1.2.2.tar.gz
cd PKcrack/src ; sudo make
mv extract findkey makekey pkcrack zipdecrypt ../

# Hashpump
sudo apt-get install -y g++ libssl-dev
git clone https://github.com/bwall/HashPump.git ~/Tools/Hashpump
cd ~/Tools/Hashpump
sudo make
sudo make install
cd ~/ ; rm -rf ~/Tools/Hashpump

# libnum
cd /tmp ; git clone https://github.com/hellman/libnum
cd libnum ; python setup.py install

# factordb-pycli
sudo pip install factordb-pycli



##############################################################################



# EasyWebSolver
sudo apt-get install -y ruby
sudo gem install colorize
git clone https://github.com/w181496/EasySolver.git ~/Tools/EasyWebSolver

# SQLmap
sudo apt-get install -y sqlmap

# TPLmap
sudo -H pip install pyyaml
git clone https://github.com/epinna/tplmap.git ~/Tools/tplmap

# commix
git clone https://github.com/commixproject/commix.git ~/Tools/commix

# GitHacker
sudo -H pip install requests
git clone https://github.com/wangyihang/GitHacker.git ~/Tools/GitHacker

# php
sudo apt-get install -y php



##############################################################################



# foremost
sudo apt-get install -y foremost

# binwalk
sudo apt-get install -y binwalk

# nmap
sudo apt-get install -y nmap

# ngrok
## 需要手動下載、手動設定 Token
mkdir ~/Tools/ngrok



##############################################################################



if $ZSH; then
	echo "+======================+"
	echo "|Install ZSH.....      |"
	echo "|安裝完後請按 Ctrl + Z |"
	echo "+======================+"
	sudo apt-get install -y zsh
	# oh-my-zsh
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
	chsh -s /bin/zsh
	# autojump
	sudo apt-get install -y autojump
	# zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ; source ~/.zshrc
	# DEBUG => dircolors: .dir_colors/dircolors: No such file or directory
	sudo apt-get install -y dconf-cli
	git clone git://github.com/sigurdga/gnome-terminal-colors-solarized.git ~/.solarized
	cd ~/.solarized ; ./install.sh
fi
if $ZSHRC; then
	cd "$(dirname "$0")"
	cp zshrc ~/.zshrc
fi



##############################################################################
