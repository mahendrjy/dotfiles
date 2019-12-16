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
