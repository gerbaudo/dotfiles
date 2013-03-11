#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
#
# based on http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bashrc bash_aliases bash_profile  bash_prompt emacs screenrc sshconfig keydoublerc"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup ..."
mkdir -p $olddir

# change to the dotfiles directory
echo -n "cd to $dir ..."
cd $dir
echo "done"


function create_link {
	echo "Creating symlink to $1"
	ln -s $dir/$1 ~/.$1
}

function backup_file {
	echo "Moving .$1 from ~ to $olddir"
	mv ~/.$file ~/dotfiles_old/
}

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
	if [ -e ~/.$file ]
	then
		if [ -L ~/.$file ]
		then
			echo "Skip existing symlink for ${file}"
		else
			backup_file ${file}
			create_link $file
		fi
	else
		create_link $file
	fi
done

cd -
