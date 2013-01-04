# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.

# history with timestamp
export HISTTIMEFORMAT="%F %T "
# set the terminal prompt
export PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \W \$\[\033[00m\] " # user@host <shortdir> $
# the 'ls' blue on dark background is illegible; change it to bold blue (see dircolors --print-database)
export LS_COLORS="`echo $LS_COLORS  | sed 's/\=00\;34\:/\=01\;34\:/g'`"
export SVN_EDITOR="emacs -nw"

# define several shorthands
alias enw="emacs -nw"
alias screen="screen -e^U^U" # use C-u instead of the default C-a
alias kcern="kinit -f $USER@CERN.CH"
alias kfnal="kinit -f $USER@FNAL.GOV"
alias boxster="ssh -Y boxster-clued0.fnal.gov"
alias cayman="ssh -Y cayman-clued0.fnal.gov"
alias nifae06="ssh -Y nifae06.cern.ch"
alias nifae06tunnel="ssh -L 5902:localhost:5902 nifae06.cern.ch"
alias at3="ssh -Y at3.pic.es"
alias pcatr17="ssh -Y pcatr17.cern.ch"
alias pc5='ssh -Y atlaspc5.ps.uci.edu'
alias gp1='ssh -Y gpatlas1.ps.uci.edu'
alias gp1hop='ssh -tCL 5906:localhost:5906 atlaspc5.ps.uci.edu ssh -CL 5906:localhost:22 gpatlas1.ps.uci.edu'

# set my default printer on CERN computers
if [[ "$HOSTNAME" == *.cern.ch ]]
then
    export PRINTER="32-SB02-CAN"
fi
