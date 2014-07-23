alias enw="emacs -nw"

alias ls="ls --color=auto"
alias ll="ls -l --color=auto"
alias lsn='stat -c "%a %n"'
alias kcern="kinit -f $USER@CERN.CH"
alias kfnal="kinit -f $USER@FNAL.GOV"
alias boxster="ssh -Y boxster-clued0.fnal.gov"
alias cayman="ssh -Y cayman-clued0.fnal.gov"
alias nifae06="ssh -Y nifae06.cern.ch"
alias nifae06tunnel="ssh -L 5902:localhost:5902 nifae06.cern.ch"
alias at3="ssh -Y at3.pic.es"
alias pcatr17='ssh -Y pcatr17.cern.ch'
alias pc3='ssh -Y atlaspc3.ps.uci.edu'
alias pc4='ssh -Y atlaspc4.ps.uci.edu'
alias pc5='ssh -Y atlaspc5.ps.uci.edu'
alias pc8='ssh -Y atlaspc8.ps.uci.edu'
alias pc9='ssh -Y atlaspc9.ps.uci.edu'
alias gp1='ssh -Y gpatlas1.ps.uci.edu'
alias gp2='ssh -Y gpatlas2.ps.uci.edu'
alias gp1hop='ssh -tCL 5906:localhost:5906 atlaspc5.ps.uci.edu ssh -CL 5906:localhost:22 gpatlas1.ps.uci.edu'
alias gp2hop='ssh -tCL 5907:localhost:5906 atlaspc5.ps.uci.edu ssh -CL 5907:localhost:22 gpatlas2.ps.uci.edu'
alias vproxy='voms-proxy-init -voms atlas -valid 144:00'
alias dipp='$HOME/bin/dipp.py' # get it from https://raw.github.com/davidegerbaudo/python-scripts/master/various/dipp.py
alias psu='pgrep -u $USER | xargs ps -f -p'

## ls with numeric permission, see http://stackoverflow.com/questions/1795976/can-the-unix-list-command-ls-output-numerical-chmod-permissions
# some problem with double quotes in alias...to be fixed
#lsn() {
#    ls -l $* | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf("%0o ",k);print}'
#    }
#

# cannot define an alias with arg; use a function instead
mktoday() {
    local target_dir="/tmp/${USER}/`date +%F`" && [[ $# -gt 0 ]]  && target_dir="/tmp/${USER}/${1}-`date +%F`" ;
    echo "mkdir ${target_dir}"
    mkdir -p ${target_dir}
    }

# determine whether this is an interactive shell
# (from http://tldp.org/LDP/abs/html/intandnonint.html)
isthisshellinteractive() {
 case $- in
 *i*)    # interactive shell
         echo yes
 ;;
 *)      # non-interactive shell
         echo no
 ;;
 esac
}

# short for 'find base-location -name "*some-name*" -exec grep some-thing {}' \; -print
fgrepp() {
    if [[ 2 -gt $# || $# -gt 3 ]]
    then
        echo "Usage: fgrep where [approxname] whattogrep"
    else
        local base_dir="${1}"
        local name_pattern="*"    && [[ $# -gt 2 ]]  && name_pattern="*${2}*" ;
        local word_pattern="${2}" && [[ $# -gt 2 ]]  && word_pattern="${3}" ;
        # echo "find  ${base_dir} -type f -iname \"${name_pattern}\" -exec grep --color='auto' ${word_pattern} {} \; -print"
        find  ${base_dir} -type f -iname "${name_pattern}" -exec grep --color='auto' ${word_pattern} {} \; -print
    fi
}

# handy stuff inspired from https://news.ycombinator.com/item?id=7981633
function lt() { ls -ltrsa "$@" | tail; }
function mkcd() { mkdir $1 && cd $1; }
function hgrep()  { history | grep -v grep | grep "$@" -i --color=auto; }
function psgrep() { ps axuf | grep -v grep | grep "$@" -i --color=auto; }
function fname() { find . -iname "*$@*"; } ## find something here with ~name
function remove_lines_from() { grep -F -x -v -f $2 $1; } ## removes lines from $1 if they appear in $2
alias sum="xargs | tr ' ' '+' | bc" ## Usage: echo 1 2 3 | sum

# A simple function to jot down my notes while working.
# Example usage
# > ls -ltrh *foo                         # nice command, I see it works
# > jot working from `pwd`, this works    # jot down a note to self
# > jot ls -ltrh *foo                     # and the command
function jot() {
    : ${JOT_DEST:?"Need to set a valid JOT_DEST file; use jot-set."}
    if [ ! -e ${JOT_DEST} ]
    then
        touch ${JOT_DEST}
    fi
    local TIMESTAMP=$(date +%F-%T)
    echo "${TIMESTAMP} -- ${@}" >> ${JOT_DEST}
}
function jot-set() {
    # function to pick a file where we jot things down
    # based on http://stackoverflow.com/questions/15807845/list-files-and-show-them-in-a-menu-with-bash
    local JOT_DIR="${HOME}/.jot/"
    if [ ! -d ${JOT_DIR} ]; then mkdir ${JOT_DIR}; fi
    local PROMPT="Please select a file:"
    local OPTIONS=( $(find ${JOT_DIR} -maxdepth 1 -type f -regex ".*\.\(org\|txt\)" -print0 | xargs -0) )
    local OPT=""
    PS3="$PROMPT "
    select OPT in "${OPTIONS[@]}" "Quit" ; do
        if (( REPLY == 1 + ${#OPTIONS[@]} )) ; then
            exit

        elif (( REPLY > 0 && REPLY <= ${#OPTIONS[@]} )) ; then
            echo  "You picked ${OPT} which is file ${REPLY}"
            export JOT_DEST=${OPT}
            break
        else
            echo "Invalid option. Try another one, or 'touch' ${JOT_DIR}/file if you want a new one."
        fi
    done
    # ls -ld ${OPT} # just for dbg
}

# git aliases
alias gad='git add'
alias gadp='git add -p'
alias gpu='git push'
alias glg='git log'
alias glp='git log --pretty=format:"%h - %an, %ad : %s"'
alias glt='git log --oneline --graph --decorate --all'
alias glts='git log --graph --simplify-by-decoration --pretty=format:%d --all'
alias gst='git status'
alias gdf='git diff'
alias gdfc='git diff --cached'
alias gci='git commit'
alias gcm='git commit -m'
alias gcma='git commit -am'
alias gbr='git branch'
alias gco='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpl='git pull'
alias gcl='git clone'

# svn aliases
alias svs='svn status'
alias svi='svn info'
alias svd='svn diff'
alias svdiw='svn diff -x --ignore-all-space'
alias svu='svn update'
alias svc='svn commit'
alias svcm='svn commit -m'
