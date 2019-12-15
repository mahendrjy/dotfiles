# Mahendra's config for the Z Shell (ZSH)

# Vim for life
export EDITOR=vim

# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"
    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/command-not-found
    zgen oh-my-zsh plugins/autojump
    zgen oh-my-zsh plugins/fasd
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zsh-autosuggestions
    zgen load fdw/ranger_autojump

    # completions
    zgen load zsh-users/zsh-completions src

    # theme
    zgen oh-my-zsh themes/robbyrussell

    # save all to init script
    zgen save
fi

ENABLE_CORRECTION="true"
export LANG=en_US.UTF-8

# history
SAVEHIST=100000

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# terminal rickroll 🕺💃
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
    [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] ||
    [[ ${KEYMAP} == viins ]] ||
    [[ ${KEYMAP} = '' ]] ||
    [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
    fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# For run custom scripts directly
PATH="$HOME/.scripts:$PATH"

# Load aliases and shortcuts if existent.
# [ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
# [ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"


# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

# Overcoming Muscle Memory
if type nvim > /dev/null 2>&1; then
    alias vim='nvim'
fi

# CDPATH ALTERATIONS
CDPATH=.:$HOME:$HOME/code:$HOME/Desktop

# Custom Aliases
alias v=vim
alias v.="vim ."
alias c="code"
alias cr="code -r"
alias vi=vim
alias please=sudo
alias r=ranger-cd
alias vm="vifm ."
alias ru=ruby
alias n="node"
alias python="python3"
alias p="python3"
alias pip="pip3"
alias pi="pip3"
alias ve="virtualenv"
alias t="touch"
alias icat="kitty +kitten icat"

# Changing "ls" to "exa"
alias l='exa --color=always --group-directories-first'  # some files and dirs
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -1 --color=always --group-directories-first'  # long format
alias ls='exa -a1 --color=always --group-directories-first' # my preferred listing

alias cp="cp -i"  # confirm before overwriting something
alias df='df -h'  # human-readable sizes
alias grep='grep --colour=auto'

alias pg="echo 'Pinging Google' && ping www.google.com";

alias vz="vim ~/.zshrc"
alias vn="vim ~/.config/nvim/init.vim"
alias vr="vim ~/.config/ranger/rc.conf"

alias de="cd ~/Desktop";

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

alias git="hub"

## git aliases
alias gi="git init";
alias ga="git add";
alias gc="git commit -m";
alias gs="git status";
alias gpu="git pull";
alias gf="git fetch";
alias gp="git push";
alias gd="git diff";

## npm aliases
alias ni="npm install";
alias nrs="npm run start -s --";
alias nrb="npm run build -s --";
alias nrd="npm run dev -s --";
alias nrt="npm run test -s --";
alias nrtw="npm run test:watch -s --";
alias nrv="npm run validate -s --";
alias rmn="rm -rf node_modules";
alias flush-npm="rm -rf node_modules && npm i && say NPM is done";
alias nicache="npm install --prefer-offline";
alias nioff="npm install --offline";

# yarn aliases
alias y="sudo yarn"
alias ya="sudo yarn add"
alias yad="sudo yarn add --dev"
alias yr="sudo yarn run";
alias ys="sudo yarn run start";
alias yb="sudo yarn run build";
alias yt="sudo yarn run test";
alias yv="sudo yarn run validate";
alias yoff="sudo yarn add --offline";
alias ypm="sudo echo \"Installing deps without lockfile and ignoring engines\" && yarn install --no-lockfile --ignore-engines"

alias agi="add-gitignore"

# Custom functions
mg () { mkdir "$@" && cd "$@" || exit; }
function cra { cp -R ~/.crapp "$@"; }
function cga { cp -R ~/.gapp "$@"; }
shorten() { node ~/code/pika.im/node_modules/.bin/netlify-shortener "$1" "$2"; }
killport() { lsof -i tcp:"$*" | awk 'NR!=1 {print $2}' | xargs kill -9 ;}

autoload -U edit-command-line
zle -N edit-command-line

bindkey '^E' edit-command-line                   # Opens Vim to edit current command line
bindkey '^R' history-incremental-search-backward # Perform backward search in command line history
bindkey '^S' history-incremental-search-forward  # Perform forward search in command line history
bindkey '^P' history-search-backward             # Go back/search in history (autocomplete)
bindkey '^N' history-search-forward              # Go forward/search in history (autocomplete)

# enable control-s and control-q
stty start undef
stty stop undef
setopt noflowcontrol

#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

alias d='ddgr'
alias wi="wikit"
alias lc="lolcat"
alias iu="imgur-uploader"
m () { figlet "$@" | lolcat; }
tm () { toilet -f mono12 "$@" | lc }
tb () { toilet -f bigmono12 "$@" | lc }
tf () { toilet -f future "$@" | lc; }
