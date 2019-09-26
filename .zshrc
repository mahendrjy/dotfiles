# Mahendra's config for the Z Shell (ZSH)

# Vim for life
export EDITOR=vim

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="random"
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" "avit" )
plugins=(git zsh-syntax-highlighting):
source $ZSH/oh-my-zsh.sh

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
alias c="code"
alias vi=vim
alias please=sudo
alias r=ranger

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

## git aliases
function gc { git commit -m "$@"; }
alias gs="git status";
alias gp="git pull";
alias gf="git fetch";
alias gpush="git push";
alias gd="git diff";
alias ga="git add .";

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
alias yar="yarn run";
alias yas="yarn run start -s --";
alias yab="yarn run build -s --";
alias yat="yarn run test -s --";
alias yav="yarn run validate -s --";
alias yoff="yarn add --offline";
alias ypm="echo \"Installing deps without lockfile and ignoring engines\" && yarn install --no-lockfile --ignore-engines"

# Custom functions
mg () { mkdir "$@" && cd "$@" || exit; }
function crapp { cp -R ~/.crapp "$@"; }
shorten() { node ~/code/pika.im/node_modules/.bin/netlify-shortener "$1" "$2"; }
killport() { lsof -i tcp:"$*" | awk 'NR!=1 {print $2}' | xargs kill -9 ;}

autoload -U edit-command-line
zle -N edit-command-line

bindkey '^E' edit-command-line                   # Opens Vim to edit current command line
bindkey '^R' history-incremental-search-backward # Perform backward search in command line history
bindkey '^S' history-incremental-search-forward  # Perform forward search in command line history
bindkey '^P' history-search-backward             # Go back/search in history (autocomplete)
bindkey '^N' history-search-forward              # Go forward/search in history (autocomplete)

# Make apps transparent and vice versa
# Firefox
alias tf="mv ~/.devilspie/firefox_transparent.ds.hide ~/.devilspie/firefox_transparent.ds"
alias utf="mv ~/.devilspie/firefox_transparent.ds ~/.devilspie/firefox_transparent.ds.hide"
# Vscode
alias tc="mv ~/.devilspie/vscode_transparent.ds.hide ~/.devilspie/vscode_transparent.ds"
alias utc="mv ~/.devilspie/vscode_transparent.ds ~/.devilspie/vscode_transparent.ds.hide"
# Terminal - Kitty
alias tt="mv ~/.devilspie/kitty_transparent.ds.hide ~/.devilspie/kitty_transparent.ds"
alias utt="mv ~/.devilspie/kitty_transparent.ds ~/.devilspie/kitty_transparent.ds.hide"

alias npm="sudo npm"
