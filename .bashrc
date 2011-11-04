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
alias enw="emacs -nw"
alias kcern="kinit -f $USER@CERN.CH"
alias kfnal="kinit -f $USER@FNAL.GOV"
alias boxster="ssh -Y boxster-clued0.fnal.gov"
alias cayman="ssh -Y cayman-clued0.fnal.gov"
alias nifae06="ssh -Y nifae06.cern.ch"
alias nifae06tunnel="ssh -L 5902:localhost:5902 nifae06.cern.ch"
alias at3="ssh -Y at3.pic.es"
