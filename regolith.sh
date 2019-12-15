#!/bin/bash

# Written by Mahendra Choudhary
# Run without downloading:
# git clone https://github.com/iampika/dotfiles.git && cd dotfiles && chmod +x regolith.sh && ./regolith.sh

# Ask for the administrator password upfront
sudo -v

email='jakepintu@gmail.com'

PKGS=(
    curl
    wget
    zsh
    git
    neovim
    ranger
    vifm
    toilet
    lolcat
    figlet
    vlc
    transmission
    ffmpeg
    htop
    neofetch
    tree
    nethogs
    variety
    exa
    kitty
    python-chardet
    ffmpegthumbnailer
    python3
    python3-pip
    python3-venv
    pipenv
    caca-utils
    highlight
    bsdtar
    w3m
    nodejs
    ddgr
    xclip
    taskwarrior
#    rbenv
#    sqlite
)

blue=$(tput setaf 4)
green=$(tput setaf 2)
red=$(tput setaf 1)
yellow=$(tput setaf 3)
normal=$(tput sgr0)

function echo_error() {
  printf "[${red}!!${normal}] $1 \n"
}

function echo_warning() {
  printf "[${yellow}/\${normal}] $1 \n"
}

function echo_success() {
  printf "[${green}OK${normal}] $1 \n"
}

function echo_info() {
  printf "[${blue}..${normal}] $1 \n"
}

function _install() {
    pkgs=("$@")
    echo_info "Installing ${pkgs[@]}..."
    sudo apt install ${pkgs[@]}
    echo_success "Installed ${pkgs[@]}"
}

function _install() {
    pkgs=("$@")
    echo_info "Installing ${pkgs[@]}..."
    sudo apt install -y ${pkgs[@]}
    echo_success "Installed ${pkgs[@]}"
}

function _update() {
    echo_info "Updating $1"
    sudo apt update
    sudo apt upgrade
    sudo apt auto-remove
    echo_success "Updated $1"
}

# Keep-alive: update existing `sudo` time stamp until `install` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Hello $(whoami)! Let's get you set up."

echo_info "Updating system"
_update

echo_info "Installing packages..."
_install "${PKGS[@]}"

echo_info "Installing A lightweight and simple plugin manager for ZSH"
git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"

echo_info "Installing devilspie"
sudo apt-get install devilspie
mkdir -p ~/.devilspie

echo_info "Installing vscode"
sudo snap install --classic code

echo_info "Installing Node.js"
# Node.js download and run the official install script
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash

npm i -g add-gitignore
npm i -g lite-server
npm i -g wikit
npm i -g pageres
npm i -g surge
npm i -g imgur-uploader-cli
npm i -g share-cli
# npm i --g brightness-cli

# fasd sudo add-apt-repository ppa:aacebedo/fasd
sudo apt-get update
sudo apt-get install fasd

#echo_info "Installing ruby"
#sudo apt-get install ruby-full
#
#echo_info "Installing bundler pry byebug"
#sudo gem install bundler pry byebug
#
#echo_info "Installing PostgreSQL"
#sudo apt-get install postgresql-client
#sudo apt-get install postgresql postgresql-contrib
#apt-cache search postgres
#sudo apt-get install pgadmin3

# install rails
#sudo gem install rails

# How to Setup SSH Keys on GitHub
# https://devconnected.com/how-to-setup-ssh-keys-on-github/
echo "Generating an RSA token for GitHub"
cd ~/.ssh/
echo "ssh-keygen -t rsa -b 4096 -C ${email}"
echo "cat ~/.ssh/id_rsa.pub"
echo "xclip -sel clip < ~/.ssh/id_rsa.pub"
echo "Add SSH key to your GitHub Account"
cd ~/dotfiles/

mkdir ${HOME}/.config/kitty
mkdir ${HOME}/.config/nvim
mkdir ${HOME}/.config/ranger
mkdir ${HOME}/.config/ranger/plugins
mkdir ${HOME}/.config/regolith
mkdir ${HOME}/.config/regolith/i3
mkdir ${HOME}/.devilspie
mkdir ${HOME}/.Xresources.d
mkdir ${HOME}/code

ln -sf "${HOME}/dotfiles/.zshrc" "${HOME}/.zshrc"
ln -sf "${HOME}/dotfiles/.config/kitty/kitty.conf" "${HOME}/.config/kitty/kitty.conf"
ln -sf "${HOME}/dotfiles/.config/nvim/init.vim" "${HOME}/.config/nvim/init.vim"
ln -sf "${HOME}/dotfiles/.config/ranger/rc.conf" "${HOME}/.config/ranger/rc.conf"
ln -sf "${HOME}/dotfiles/.config/ranger/scope.sh" "${HOME}/.config/ranger/scope.sh"
ln -sf "${HOME}/dotfiles/.config/ranger/commands.py" "${HOME}/.config/ranger/commands.py"
ln -sf "${HOME}/dotfiles/.config/ranger/plugins/autojump.py" "${HOME}/.config/ranger/plugins/autojump.py"
ln -sf "${HOME}/dotfiles/.config/ranger/plugins/plugin_fasd_log.py.py" "${HOME}/.config/ranger/plugins/plugin_fasd_log.py.py"
ln -sf "${HOME}/dotfiles/.config/regolith/i3/config" "${HOME}/.config/regolith/i3/config"
ln -sf "${HOME}/dotfiles/.ssh/config" "${HOME}/.ssh/config"
ln -sf "${HOME}/dotfiles/.devilspie/firefox_transparent.ds" "${HOME}/.devilspie/firefox_transparent.ds"
ln -sf "${HOME}/dotfiles/.devilspie/kitty_transparent.ds" "${HOME}/.devilspie/kitty_transparent.ds"
ln -sf "${HOME}/dotfiles/.devilspie/transmission_transparent.ds" "${HOME}/.devilspie/transmission_transparent.ds"
ln -sf "${HOME}/dotfiles/.devilspie/vscode_transparent.ds" "${HOME}/.devilspie/vscode_transparent.ds"
ln -sf "${HOME}/dotfiles/.Xresources" "${HOME}/.Xresources"
ln -sf "${HOME}/dotfiles/.Xresources.d/color-palenight" "${HOME}/.Xresources.d/color-palenight"
