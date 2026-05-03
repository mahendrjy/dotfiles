source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
  echo "Creating a zgen save"
  zgen oh-my-zsh

  # plugins
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/sudo
  zgen oh-my-zsh plugins/command-not-found

  zgen oh-my-zsh plugins/yarn
  zgen oh-my-zsh plugins/npm
  zgen oh-my-zsh plugins/copyfile
  zgen oh-my-zsh plugins/copypath
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-autosuggestions
  zgen load djui/alias-tips
  zgen load lukechilds/zsh-better-npm-completion

  # completions
  zgen load zsh-users/zsh-completions src

  # theme
  zgen load denysdovhan/spaceship-prompt spaceship

  zgen save
fi

# Spaceship prompt — only show sections that are fast
SPACESHIP_PROMPT_ORDER=(
  user
  dir
  git
  char
)

SPACESHIP_DIR_PREFIX=''
SPACESHIP_DIR_TRUNC='1'

function random_element() {
  declare -a array=("$@")
  r=$((RANDOM % ${#array[@]}))
  printf "%s\n" "${array[$r]}"
}

SPACESHIP_CHAR_SYMBOL="$(random_element 😅 👽 🔥 🚀 👻 ⛄ 👾 🍔 😄 🍰 🐑 😎 🤖 😇 😼 💪 🦄 🥓 🌮 🎉 💯 ⚛️ 🐠 🐳 🥳 🤩 🤯 🤠 🦸 🧙 🕺 🦁 🐶 🐵 🐻 🦊 🐙 🦎 🦖 🦕 🦍 🦈 🐊 🦂 🐍 🐢 🐘 🐉 🦚 ✨ ☄️ ⚡️ 💥 💫 🧬 🔮 ⚗️ 🎊 🔭 ⚪️ 🔱) "
