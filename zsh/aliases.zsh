# ALIASES

# Editors
alias v="nvim"
alias vim="nvim"
alias vi="nvim"

# Git UI
alias lg="lazygit"

# zoxide (smarter cd — use 'z dirname' to jump to frequent dirs)
alias cd="z"

# Files
alias t="touch"

# Code editor
alias c="code"
alias cr="code -r"
alias cr.="code -r ."

# File manager
alias r="ranger"
alias vm="vifm ."

# Languages
alias ru="ruby"
alias n="node"
alias python="python3"
alias p="python3"
alias pip="pip3"
alias pi="pip3"
alias ve="virtualenv"

# Listing — eza (maintained fork of exa)
alias l='eza --color=always --group-directories-first'
alias la='eza -a --color=always --group-directories-first'
alias ll='eza -l --color=always --group-directories-first'
alias ls='eza -a1 --color=always --group-directories-first'

# Core utils
alias cp="cp -i"
alias df='df -h'
alias grep='grep --colour=auto'

# Navigation
alias ~="cd ~"
alias .="cd .."
alias ..="cd ../.."
alias ...="cd ../../.."
alias ....="cd ../../../.."

# Network
alias pg="echo 'Pinging Google' && ping www.google.com"

# Build shortcuts
alias mk="make"
alias mkc="make clean"
alias mkr="make run"
alias mkt="make test"

# Zsh config editing
alias vz="nvim ~/.zshrc"
alias vza="nvim ~/dotfiles/zsh/aliases.zsh"
alias vzp="nvim ~/dotfiles/zsh/plugins.zsh"
alias vzf="nvim ~/dotfiles/zsh/functions.zsh"
alias vn="nvim ~/.config/nvim/init.vim"
alias vr="nvim ~/.config/ranger/rc.conf"

# npm
alias ni="npm install"
alias nid="npm install -D"
alias nst="npm run start -s --"
alias ns="npm run server -s --"
alias nb="npm run build -s --"
alias nf="npm fund -s --"
alias nd="npm run dev -s --"
alias nt="npm run test -s --"
alias ntw="npm run test:watch -s --"
alias nv="npm run validate -s --"
alias na="npm audit"
alias naf="npm audit fix"
alias nr="rm -rf node_modules"
alias flush="rm -rf node_modules && npm i && say NPM is done"
alias nicache="npm install --prefer-offline"
alias nioff="npm install --offline"

# Docker
alias d="sudo docker"
alias dr="sudo docker run"
alias drrm="sudo docker run --rm"
alias drit="sudo docker run -it"
alias dritrm="sudo docker run -it --rm"
alias dritirm="sudo docker run -it --init --rm"
alias dritrmn="sudo docker run -it --rm --name"
alias dc="sudo docker container"
alias ds="sudo docker start"
alias dl="sudo docker logs"
alias dsa="sudo docker start -a"
alias dps="sudo docker ps"
alias dpsa="sudo docker ps --all"
alias dst="sudo docker stop"
alias dk="sudo docker kill"
alias dsp="sudo docker system prune"
alias deit="sudo docker exec -it"
alias db="sudo docker build"
alias dbt="docker build --tag"
alias dcp="docker container prune"
alias dcc="sudo docker commit -c"
alias de="sudo docker exec"
alias dils="sudo docker image ls"

# Git
alias gs="git status"
alias agi="add-gitignore"

# Heroku
alias gphm="git push heroku master"

# Yarn
alias ys="yarn server"
alias yrw="yarn run watch"

# YouTube DL
alias ydl="youtube-dl"
alias ydlb="youtube-dl -f bestvideo+bestaudio"
alias ydlbd="youtube-dl -f bestvideo+bestaudio -ci --batch-file=download.txt"
alias ydd="youtube-dl -f bestvideo+bestaudio -ci --batch-file=download.txt"
alias ydla="youtube-dl -cio '0%(autonumber)s %(title)s.%(ext)s' -f bestvideo+bestaudio -ci --batch-file=download.txt ; rename 's/000//g' *"
alias ydlas="youtube-dl -cio '0%(autonumber)s %(title)s.%(ext)s' -f bestvideo+bestaudio -ci --write-auto-sub --batch-file=download.txt ; rename 's/000//g' *"

# Notes
alias todo="nvim ~/.todo.txt"
alias project="nvim ~/.project.txt"
alias notes="nvim ~/.notes.txt"

# terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

# Taskbook
alias tb="taskbook"

# ddgr search
alias ddg="ddgr"
alias wi="wikit"

# lolcat
alias lc="lolcat"

# History (atuin)
alias hist="atuin history list"   # browse full history
alias histsearch="atuin search"   # search history non-interactively

# Command correction
alias fix="fk"    # type 'fix' after a failed command

# Cheatsheets
alias cheat="navi"                # interactive cheatsheet picker
alias tldr="tldr --color"

# System info
alias sysinfo="fastfetch"
alias info="fastfetch"

# DuckDuckGo terminal search (shows results in terminal, no browser)
alias ddg="ddgr --num 5"

# Tmux sessionizer
alias proj="tmux-sessionizer"     # pick a project
