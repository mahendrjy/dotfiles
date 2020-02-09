# ALIASES

alias c="coding $HOME/Code"

alias v="nvim"
alias vim="nvim"
alias n="npm"
alias r="ranger"

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
alias cr.="code -r ."

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
alias vza="vim ~/dotfiles/zsh/aliases.zsh"
alias vzp="vim ~/dotfiles/zsh/plugins.zsh"
alias vzf="vim ~/dotfiles/zsh/functions.zsh"
alias vn="vim ~/.config/nvim/init.vim"
alias vr="vim ~/.config/ranger/rc.conf"

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

alias d='ddgr'
alias wi="wikit"
alias lc="lolcat"
alias iu="imgur-uploader"

# Easier directory navigation.
alias ~="cd ~"
alias .="cd .."
alias ..="cd ../.."
alias ...="cd ../../.."
alias ....="cd ../../../.."

# Docker
alias d="docker"
alias dr="docker run"
alias drrm="docker run --rm"
alias drit="docker run -it"
alias dritrm="docker run -it --rm"
alias dritirm="docker run -it --init --rm"
alias dritrmn="docker run -it --rm --name"
alias dc="docker create"
alias ds="docker start"
alias dl="docker logs"
alias dsa="docker start -a"
alias dps="docker ps"
alias dpsa="docker ps --all"
alias dst="docker stop"
alias dk="docker kill"
alias dsp="docker system prune"
alias deit="docker exec -it"
alias db="docker build"
alias dcc="docker commit -c"
alias de="docker exec"
alias dbt="docker build --tag"
alias dcp="docker container prune"
alias dils="docker image ls"

# Git
alias git="hub"
alias gs="git status"
alias gc="git clone"
alias agi="add-gitignore"

# Heroku
alias gphm="git push heroku master"

# Yarn
alias ys="yarn server"
alias ysr="yarn server"

# Scrot
alias s="scrot"

# Youtube DL
alias ydl="youtube-dl"
alias ydlb="youtube-dl -f bestvideo+bestaudio"
alias ydlbd="youtube-dl -f bestvideo+bestaudio -ci --batch-file=download.txt"
alias ydd="youtube-dl -f bestvideo+bestaudio -ci --batch-file=download.txt"

alias postgres="sudo -u postgres"
alias pg="sudo -u postgres"
