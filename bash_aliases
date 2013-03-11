alias enw="emacs -nw"

#- should be in screenrc
#- alias screen="screen -e^U^U" # use C-u instead of the default C-a

alias ls="ls --color=auto"
alias ll="ls -l --color=auto"
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

# git aliases
alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gst='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'