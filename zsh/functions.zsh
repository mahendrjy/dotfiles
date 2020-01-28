# FUNCTIONS

function backup() {
  git add --all
  git commit -am ':wrench: [WIP] Done for today, cya tomorrow [ci skip] :wave:'
  git push $@
}

function git-ignore() {
  curl -L -s https://www.gitignore.io/api/$@
}

function mkcd() {
  mkdir -p $@
  cd $@
}

function open() {
  xdg-open $@ &
  disown
}

function coding() {
  local PROJECT=$(ls $1 | fzf)

  tmuxinator start code "$1/$PROJECT"
}

function find-file() {
  local FILE=$(fzf --preview-window=right:60% --preview='bat --color "always" {}')

  if [ ! -z $FILE ]; then
    $EDITOR $FILE
  fi
}

function please() {
  local CMD=$(history -1 | cut -d" " -f4-)
  sudo "$CMD"
}

function weather() {
  curl 'wttr.in/~'${1:-Braga}'+'$2'?'${3:-0}
}

# Change cursor shape for different vi modes.
function zle-keymap-select() {
  if [[ ${KEYMAP} == vicmd ]] ||
    [[ $1 == 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
    [[ ${KEYMAP} == viins ]] ||
    [[ ${KEYMAP} == '' ]] ||
    [[ $1 == 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

zle -N zle-keymap-select

zle-line-init() {
  zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
  echo -ne "\e[5 q"
}

zle -N zle-line-init

echo -ne '\e[5 q'                # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q'; } # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd() {
  tmp="$(mktemp)"
  lf -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
  fi
}

bindkey -s '^o' 'lfcd\n'

shorten() { node ~/code/pika.im/node_modules/.bin/netlify-shortener "$1" "$2"; }
killport() { lsof -i tcp:"$*" | awk 'NR!=1 {print $2}' | xargs kill -9; }

fig() { figlet "$@" | lolcat; }
tm() { toilet -f mono12 "$@" | lolcat; }
tf() { toilet -f future "$@" | lolcat; }
tb() { toilet -f bigmono12 "$@" | lolcat; }

function ranger-cd() {
  tempfile="$(mktemp -t tmp.XXXXXX)"
  ranger --choosedir="$tempfile" "${@:-$(pwd)}"
  test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n $(pwd))" ]; then
      cd -- "$(cat "$tempfile")"
    fi
  rm -f -- "$tempfile"
}

function cra() { cp -R ~/.crapp "$@"; }
function crat() { cp -R ~/.crappt "$@"; }
function cga() { cp -R ~/.gapp "$@"; }
