#!/bin/bash

personal_email="mahendrjy@gmail.com"
work_email="mahendrjy@gmail.com"

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring SSH..."
mkdir -p ${HOME}/.ssh
mkdir -p ${HOME}/work
cd ${HOME}/.ssh

# How to Setup SSH Keys on GitHub
# https://devconnected.com/how-to-setup-ssh-keys-on-github/
echo_info "Generating an RSA token for GitHub"
echo_info "Personal - id_rsa_personal"
echo_info "Work - id_rsa_work"
ssh-keygen -t rsa -b 4096 -C ${personal_email} -f id_rsa_personal
ssh-keygen -t rsa -b 4096 -C ${work_email} -f id_rsa_work

echo_info "Symlink config..."
ln -sf "$HOME/dotfiles/ssh/config" "$HOME/.ssh/config"
ln -sf "$HOME/dotfiles/ssh/gitconfig" "$HOME/.gitconfig"
ln -sf "$HOME/dotfiles/ssh/work-gitconfig" "$HOME/work/.gitconfig"

echo_info "Add SSH key to your GitHub Account"
echo_info "Copy id_rsa_personal.pub and id_rsa_work.pub and add to respective github account."
echo_info "ssh -T github.com-pika"
echo_info "ssh -T github.com-work"
echo_info "Always clone repo by adding hostname in remote url"
echo_info "e.g. git@github.com to git@github.com-pika"

echo_done "SSH configuration!"

cd ${HOME}/dotfiles/ssh
