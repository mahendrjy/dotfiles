# ALIASES

alias c="coding $HOME/Code"

alias v="nvim"
alias vim="nvim"
alias n="npm"
alias r="ranger"

alias gig=git-ignore
alias git="hub"
alias gi="git init"
alias ga="git add"
alias gc="git commit -m"
alias gs="git status"
alias gpu="git pull"
alias gf="git fetch"
alias gp="git push"
alias gd="git diff"

alias pls=please

alias mk=make
alias mkc="make clean"
alias mkr="make run"
alias mkt="make test"

# terminal rickroll 🕺💃
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

alias t="touch"

alias v=vim
alias vi=vim

alias c="code"
alias cr="code -r"

alias r=ranger-cd
alias vm="vifm ."

alias ru=ruby
alias n="node"

alias python="python3"
alias p="python3"
alias pip="pip3"
alias pi="pip3"
alias ve="virtualenv"

# Changing "ls" to "exa"
alias l='exa --color=always --group-directories-first'      # some files and dirs
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -1 --color=always --group-directories-first'  # long format
alias ls='exa -a1 --color=always --group-directories-first' # my preferred listing

alias cp="cp -i" # confirm before overwriting something
alias df='df -h' # human-readable sizes
alias grep='grep --colour=auto'

alias pg="echo 'Pinging Google' && ping www.google.com"

alias vz="vim ~/.zshrc"
alias vn="vim ~/.config/nvim/init.vim"
alias vr="vim ~/.config/ranger/rc.conf"

alias apti="sudo apt install"
alias aptr="sudo apt remove"
alias aptu="sudo apt update"
alias aptg="sudo apt upgrade"
alias aptar="sudo apt auto-remove"
alias aptgi="sudo apt-get install"
alias aptgr="sudo apt-get remove"
alias aptgu="sudo apt-get update"
alias aptgg="sudo apt-get upgrade"
alias aptgar="sudo apt-get auto-remove"

alias ni="npm install"
alias nrs="npm run start -s --"
alias nrb="npm run build -s --"
alias nrd="npm run dev -s --"
alias nrt="npm run test -s --"
alias nrtw="npm run test:watch -s --"
alias nrv="npm run validate -s --"
alias rmn="rm -rf node_modules"
alias flush-npm="rm -rf node_modules && npm i && say NPM is done"
alias nicache="npm install --prefer-offline"
alias nioff="npm install --offline"

# yarn aliases
alias y="sudo yarn"
alias ya="sudo yarn add"
alias yad="sudo yarn add --dev"
alias yr="sudo yarn run"
alias ys="sudo yarn run start"
alias yb="sudo yarn run build"
alias yt="sudo yarn run test"
alias yv="sudo yarn run validate"
alias yoff="sudo yarn add --offline"
alias ypm="sudo echo \"Installing deps without lockfile and ignoring engines\" && yarn install --no-lockfile --ignore-engines"

alias agi="add-gitignore"

alias d='ddgr'
alias wi="wikit"
alias lc="lolcat"
alias iu="imgur-uploader"
