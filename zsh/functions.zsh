# FUNCTIONS

# ── Web search from terminal ───────────────────────────────────────────────
# Usage: search [flag] query
#   search hello world           → DuckDuckGo
#   search -g how to use fzf     → Google
#   search -s bash arrays        → Stack Overflow
#   search -gh tmux-sessionizer  → GitHub
#   search -yt vim tutorial      → YouTube
#   search -npm lodash           → npm
#
# Aliases: google, so, yt, gh-search, npm-search
function search() {
  local engine="https://duckduckgo.com/?q="
  case "$1" in
    -g|--google)    engine="https://www.google.com/search?q=";               shift;;
    -s|--so)        engine="https://stackoverflow.com/search?q=";            shift;;
    -gh|--github)   engine="https://github.com/search?q=";                   shift;;
    -yt|--youtube)  engine="https://www.youtube.com/results?search_query=";  shift;;
    -npm|--npm)     engine="https://www.npmjs.com/search?q=";                shift;;
    -mdn|--mdn)     engine="https://developer.mozilla.org/search?q=";        shift;;
    -wiki|--wiki)   engine="https://en.wikipedia.org/wiki/Special:Search?search="; shift;;
  esac
  local query
  query=$(python3 -c "import urllib.parse,sys; print(urllib.parse.quote(' '.join(sys.argv[1:])))" "$@")
  open "${engine}${query}"
}

alias google="search -g"
alias so="search -s"
alias yt="search -yt"
alias gh-search="search -gh"
alias npm-search="search -npm"
alias mdn="search -mdn"

# ── System info ────────────────────────────────────────────────────────────
function sysinfo() {
  command -v fastfetch &>/dev/null && fastfetch || neofetch
}

# ── tmux-sessionizer as a shell function (fallback if script not in PATH) ─
function tmux-sessionizer() {
  bash "$DOTFILES/scripts/tmux-sessionizer" "$@"
}

function backup() {
  git add --all
  git commit -am ':wrench: [WIP] Done for today, cya tomorrow [ci skip] :wave:'
  git push $@
}

function git-ignore() {
  curl -L -s https://www.gitignore.io/api/$@ | pbcopy
}

alias gi="git-ignore"

function mkcd() {
  case "$1" in
    */..|*/../) cd -- "$1";;
    /*/../*) (cd "${1%/../*}/.." && mkdir -p "./${1##*/../}") && cd -- "$1";;
    /*) mkdir -p "$1" && cd "$1";;
    */../*) (cd "./${1%/../*}/.." && mkdir -p "./${1##*/../}") && cd "./$1";;
    ../*) (cd .. && mkdir -p "${1#.}") && cd "$1";;
    *) mkdir -p "./$1" && cd "./$1";;
  esac
}

alias md="mkcd"

function find-file() {
  local FILE=$(fzf --preview-window=right:60% --preview='bat --color "always" {}')
  if [ ! -z $FILE ]; then
    $EDITOR $FILE
  fi
}

function please() {
  local CMD=$(fc -ln -1)
  sudo $CMD
}

alias pls="please"

function weather() {
  curl 'wttr.in/~'${1:-Parbatsar}'+'$2'?'${3:-0}
}

alias m="weather"

# Change cursor shape for different vi modes
function zle-keymap-select() {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 == 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} == '' ]] || [[ $1 == 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

zle -N zle-keymap-select

zle-line-init() {
  zle -K viins
  echo -ne "\e[5 q"
}

zle -N zle-line-init

echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q'; }

# lf — always cd to the last visited directory when you quit
# Works whether you type 'lf' or use the Ctrl+O shortcut
function lf() {
  local tmp="$(mktemp -t lf-cwd.XXXXXX)"
  command lf -last-dir-path="$tmp" "$@"
  if [[ -f "$tmp" ]]; then
    local dir="$(< "$tmp")"
    rm -f "$tmp"
    [[ -d "$dir" && "$dir" != "$PWD" ]] && cd "$dir"
  fi
}

bindkey -s '^o' 'lf\n'

killport() { lsof -i tcp:"$*" | awk 'NR!=1 {print $2}' | xargs kill -9; }

fig() { figlet "$@" | lolcat; }
tm() { toilet -f mono12 "$@" | lolcat; }
tf() { toilet -f future "$@" | lolcat; }
tbg() { toilet -f bigmono12 "$@" | lolcat; }

# ranger — always cd to the last visited directory when you quit
function ranger() {
  local tmp="$(mktemp -t ranger-cwd.XXXXXX)"
  command ranger --choosedir="$tmp" "$@"
  if [[ -f "$tmp" ]]; then
    local dir="$(< "$tmp")"
    rm -f "$tmp"
    [[ -d "$dir" && "$dir" != "$PWD" ]] && cd "$dir"
  fi
}

function cra()  { cp -R ~/.rapp  "$@"; cd "$@"; }
function crat() { cp -R ~/.rappt "$@"; cd "$@"; }
function cna()  { cp -R ~/.napp  "$@"; cd "$@"; }
function cnat() { cp -R ~/.nappt "$@"; cd "$@"; }
function cga()  { cp -R ~/.gapp  "$@"; cd "$@"; }
function csa()  { cp -R ~/.sapp  "$@"; cd "$@"; }
function csat() { cp -R ~/.sappt "$@"; cd "$@"; }

function 3000()  { curl http://localhost:3000/"$@"; }
function 3001()  { curl http://localhost:3001/"$@"; }
function 4000()  { curl http://localhost:4000/"$@"; }
function 3000i() { curl http://localhost:3000/"$@" --include; }
function 3001i() { curl http://localhost:3001/"$@" --include; }
function 4000i() { curl http://localhost:4000/"$@" --include; }

gccd() {
  git clone "$1" && cd "$(basename "$1" .git)"
}

alias gc="gccd"
