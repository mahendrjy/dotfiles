source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
# load zgen
if ! zgen saved; then
  echo "Creating a zgen save"
  zgen oh-my-zsh

  # plugins
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/sudo
  zgen oh-my-zsh plugins/command-not-found
  zgen oh-my-zsh plugins/fasd
  zgen oh-my-zsh plugins/yarn
  zgen oh-my-zsh plugins/nvm
  zgen oh-my-zsh plugins/npm
  zgen oh-my-zsh plugins/copyfile
  zgen oh-my-zsh plugins/copydir
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-autosuggestions
  zgen load djui/alias-tips
  zgen load lukechilds/zsh-better-npm-completion

  # completions
  zgen load zsh-users/zsh-completions src

  # theme
  # zgen oh-my-zsh themes/robbyrussell
  zgen load denysdovhan/spaceship-prompt spaceship

  # save all to init script
  zgen save
fi

# Theme Options
SPACESHIP_PROMPT_ORDER=(
  time # Time stamps section
  user # Username section
  dir  # Current directory section
  host # Hostname section
  git  # Git section (git_branch + git_status)
  # hg        # Mercurial section (hg_branch  + hg_status)
  package # Package version
  node    # Node.js section
  # ruby      # Ruby section
  # elixir    # Elixir section
  # xcode     # Xcode section
  # swift     # Swift section
  # golang    # Go section
  # php       # PHP section
  # rust      # Rust section
  # haskell   # Haskell Stack section
  # julia     # Julia section
  # docker    # Docker section
  # aws       # Amazon Web Services section
  # venv      # virtualenv section
  # conda     # conda virtualenv section
  # pyenv     # Pyenv section
  # dotnet    # .NET section
  # ember     # Ember.js section
  # kubectl   # Kubectl context section
  # terraform # Terraform workspace section
  # exec_time # Execution time
  # line_sep  # Line break
  battery # Battery level and status
  # vi_mode   # Vi-mode indicator
  # jobs      # Background jobs indicator
  # exit_code # Exit code section
  char # Prompt character
)
function random_element() {
  declare -a array=("$@")
  r=$((RANDOM % ${#array[@]}))
  printf "%s\n" "${array[$r]}"
}

SPACESHIP_CHAR_SYMBOL="$(random_element 😅 👽 🔥 🚀 👻 ⛄ 👾 🍔 😄 🍰 🐑 😎 🤖 😇 😼 💪 🦄 🥓 🌮 🎉 💯 ⚛️ 🐠 🐳 🥳 🤩 🤯 🤠 🦸 🧙 🕺 🦁 🐶 🐵 🐻 🦊 🐙 🦎 🦖 🦕 🦍 🦈 🐊 🦂 🐍 🐢 🐘 🐉 🦚 ✨ ☄️ ⚡️ 💥 💫 🧬 🔮 ⚗️ 🎊 🔭 ⚪️ 🔱) "

# DIR
SPACESHIP_DIR_PREFIX='' # disable directory prefix, cause it's not the first section
SPACESHIP_DIR_TRUNC='1' # show only last directory
