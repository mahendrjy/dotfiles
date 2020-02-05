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
  zgen oh-my-zsh plugins/yarn
  zgen oh-my-zsh plugins/web-search
  zgen oh-my-zsh plugins/ubuntu
  zgen oh-my-zsh plugins/nvm
  zgen oh-my-zsh plugins/npm
  zgen oh-my-zsh plugins/docker
  zgen oh-my-zsh plugins/docker-compose
  zgen oh-my-zsh plugins/copyfile
  zgen oh-my-zsh plugins/copydir
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-autosuggestions
  zgen load fdw/ranger_autojump
  zgen load djui/alias-tips
  zgen load lukechilds/zsh-better-npm-completion

  # completions
  zgen load zsh-users/zsh-completions src

  # theme
  zgen oh-my-zsh themes/robbyrussell

  # save all to init script
  zgen save
fi
