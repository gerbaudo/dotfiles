# /etc/skel/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
[[ -f ~/.bashrc ]] && . ~/.bashrc


if [[ -s "$HOME/.bash_prompt" ]]; then
  source "$HOME/.bash_prompt"
fi

if [[ -s "$HOME/.bash_profile_lxplus" ]]; then
  source "$HOME/.bash_profile_lxplus"
fi

if [[ -s "$HOME/.bash_profile_gpatlas" ]]; then
  source "$HOME/.bash_profile_gpatlas"
fi


if [[ -s "$HOME/.bash_aliases" ]]; then
   source "$HOME/.bash_aliases"
fi