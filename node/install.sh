#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring Node..."
echo_info "Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

echo_info "Installing Node.js..."
nvm install node

npm i -g add-gitignore
npm i -g lite-server
npm i -g pageres
npm i -g surge
npm i -g imgur-uploader-cli
npm i -g share-cli
npm i -g prettier
# npm i --g brightness-cli

nvm install node

echo_done "Node configuration!"
