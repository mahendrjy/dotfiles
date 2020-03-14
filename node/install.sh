#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring Node..."
_install node

echo_info "Installing Node.js"

npm i -g add-gitignore
npm i -g lite-server
npm i -g wikit
npm i -g pageres
npm i -g surge
npm i -g imgur-uploader-cli
npm i -g share-cli
npm i -g prettier
# npm i --g brightness-cli

nvm install node

echo_done "Node configuration!"
