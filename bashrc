# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# check whether the current user has a ~/bin, ~/opt/bin and if so add it to the PATH
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH";
[ -d "$HOME/opt/bin" ] && export PATH="$HOME/opt/bin:$PATH";
[ -d "$HOME/opt/lib" ] && export LD_LIBRARY_PATH="$HOME/opt/lib:$LD_LIBRARY_PATH";

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

# export LC_ALL="C"

export EDITOR="emacs -nw"
export SVN_EDITOR="emacs -nw"

[[ -r "$HOME/.bash_prompt" ]]          && . $HOME/.bash_prompt
[[ -r "$HOME/.bash_profile_lxplus" ]]  && . $HOME/.bash_profile_lxplus
[[ -r "$HOME/.bash_profile_gpatlas" ]] && . $HOME/.bash_profile_gpatlas
[[ -r "$HOME/.bash_aliases" ]]         && . $HOME/.bash_aliases
