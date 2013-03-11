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

# check whether the current user has a ~/bin and if so add it to the PATH
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH";

export EDITOR="emacs -nw"
export SVN_EDITOR="emacs -nw"

# set my default printer on CERN computers
if [[ "$HOSTNAME" == *.cern.ch ]]
then
		export PRINTER="32-SB02-CAN"
fi
