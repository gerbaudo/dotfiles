# /etc/skel/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
[[ -r ~/.bashrc ]] && . ~/.bashrc
[[ -r "$HOME/.bash_prompt" ]]          && . $HOME/.bash_prompt
[[ -r "$HOME/.bash_profile_lxplus" ]]  && . $HOME/.bash_profile_lxplus
[[ -r "$HOME/.bash_profile_gpatlas" ]] && . $HOME/.bash_profile_gpatlas
[[ -r "$HOME/.bash_aliases" ]]         && . $HOME/.bash_aliases
