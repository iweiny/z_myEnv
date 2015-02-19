# .bashrc
# DO NOT MODIFY this file.
# This is Ira's Standard environment.
# local changes to a particular workstation can be added to .local_bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Some functions
                                                                                
PromBACK="\033[40m"
PromTEXT="\033[37m"
PromNO_COLOUR="\033[0m"
                                                                                
function prompt_command {
    LISTING=`ls -C -F --color=yes`
}

# git code stolen from Mitko
unset __is_git_repo
function __is_git_repo {
	git rev-parse --is-inside-work-tree > /dev/null 2>&1
	# turn this around because rev-parse is 0 on success
	return $((! ! ${?}))
}

unset __get_git_branch
function __get_git_branch {
	__is_git_repo || return
	branch=$(git branch -vvv| grep '*' | sed -e 's/.*\*\ //')
	echo $branch
}
                                                                                
function setPrompt {
    #PROMPT_COMMAND=prompt_command
    git_st=`__get_git_branch`
    if [ "$git_st" != "" ]; then
    	git_st="\n$PromBACK$PromTEXT GIT:$PromNO_COLOUR $git_st"
    fi
    PS1="$PromBACK$PromTEXT\u \h$PromNO_COLOUR \w${git_st}\n\t > "
    PS2="> "
}

# User specific aliases and functions
                                                                                
# Source global definitions
if [ -f /etc/bashrc ]; then
   . /etc/bashrc
fi
                                                                                
set -o vi
                                                                                
if [ "$PS1" != "" ]; then
   #setPrompt
    PROMPT_COMMAND=setPrompt
fi
                                                                                
# set up LS_COLORS
eval `dircolors -b .lscolors`
                                                                                
# Stuff for LaTeX
export TEXINPUTS=${TEXINPUTS}:.:/home/iweiny/latex/packages:/home/iweiny/Navanax/Corporate/latex
export BSTINPUTS=${BSTINPUTS}:.
                                                                                
export CVS_RSH=ssh
export SVN_RSH=ssh

export PATH=~/bin:~/sbin:$PATH:~/root/bin:~/root/enlightenment/bin:~/management/root/sbin/

# set up GNATS DB for chaos
# only on "z"
export GNATSDB=/chaos/gnats
                                                                                
source ~/.bzaliases

# set up to use my personal Perl extensions.
# ie Tk
#export PERL5LIB=/home/iweiny/Software/Tk-804.027/Tk:/home/iweiny/Software/Tk-804.027
                                                                                
# don't give the world access.
umask 027

# put "workstation" specific items in .local_bashrc
if [ -f ~/.local_bashrc ]; then
   . ~/.local_bashrc
fi
