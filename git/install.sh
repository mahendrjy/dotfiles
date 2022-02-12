#!/bin/bash

name="Mahendra Choudhary"
email="pikaatic@gmail.com"

echo_info "Configuring GIT..."
mkdir -p ${HOME}/.git

echo_info "Installing GIT..."
sudo apt install git

git config --global user.name ${name}
git config --global user.email ${email}

echo_done "GIT configuration!"
