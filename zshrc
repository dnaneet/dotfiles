
# PS4='+$(date "+%s:%N") %N:%i> '
# exec 3>&2 2>/tmp/startlog.$$
# setopt xtrace prompt_subst


# Swedish and UTF8
export LANG='sv_SE.UTF-8'
export LC_ALL='sv_SE.UTF-8'

# Oh my ZSH
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM="$HOME/.oh-my-zsh-custom"
ZSH_THEME="powerline"
plugins=(git brew osx extract screen wakeonlan command-coloring)
source $ZSH/oh-my-zsh.sh

# Use vim for editing
alias vim="mvim -v"
export EDITOR="mvim -v"

# Path variable
PATH="/usr/local/sbin:${PATH}"
PATH="/usr/local/bin:${PATH}"
PATH="/usr/texbin:${PATH}"
PATH="/usr/local/mysql/bin:${PATH}"
PATH="/usr/local/Cellar/ruby/1.9.3-p286/bin:${PATH}"
PATH="${HOME}/bin:${PATH}"
PATH=".:${PATH}"

# Use vim editing mode
# Make sure backspace works as it should
# jj is the same as esc in insert mode
bindkey -v
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char
bindkey -M viins 'jj' vi-cmd-mode
bindkey -M viins 'kj' vi-cmd-mode

# Always run screen in utf8 mode
alias screen="screen -U"
alias tmux="nocorrect tmux"

alias glog="git log --graph --oneline --decorate --all"

# Use C-s to insert sudo
function insert_sudo() {
	zle beginning-of-line
	zle -U "sudo "
}
zle -N insert-sudo insert_sudo
bindkey "\C-s" insert-sudo

setopt AUTO_CD
setopt IGNORE_EOF

alias ls='pwd;ls -G'
alias sz='source ~/.zshrc'

bindkey -M viins ' ' magic-space

setopt HIST_IGNORE_ALL_DUPS

# Look for .localzsh from the current directory and upwards and runs it
#function chpwd; {
	#DIRECTORY="$PWD"
	#while true; do
		#if [ -f './.localzsh']; then
			#source './.localzsh'
			#break
		#fi
		#[ $PWD = '/' ] && break
		#cd -q ..
	#done
	#cd -q $DIRECTORY
#}

# Use C-l to run command into less
bindkey -s "\C-l" " 2>&1|less^M"

# unsetopt xtrace
# exec 2>&3 3>&-

export TTY=$(tty)

function fancy-ctrl-z () {
	if [[ $#BUFFER -eq 0 ]]; then
		bg
		zle redisplay
	else
		zle push-input
	fi
}
zle -N fancy-ctrl-z
bindkey '^z' fancy-ctrl-z

alias -g L='|less'

man() {
    env \
	LESS_TERMCAP_mb=$(printf "\e[1;31m") \
	LESS_TERMCAP_md=$(printf "\e[1;31m") \
	LESS_TERMCAP_me=$(printf "\e[0m") \
	LESS_TERMCAP_se=$(printf "\e[0m") \
	LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
	LESS_TERMCAP_ue=$(printf "\e[0m") \
	LESS_TERMCAP_us=$(printf "\e[1;32m") \
	man "$@"
}

expand-or-complete-with-dots() {
	echo -n "\e[31m......\e[0m"
	zle expand-or-complete
	zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey '^I' expand-or-complete-with-dots

db() { cd ~/Dropbox/$1; }
_db() { _files -W ~/Dropbox ~/; }
compdef _db db