#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring java..."
_install java

echo_info "Installing java..."
sudo apt install openjdk-11-jre-headless  # version 11.0.4+11-1ubuntu2~19.04, or
sudo apt install default-jre              # version 2:1.11-71
sudo apt install openjdk-12-jre-headless  # version 12.0.2+9-1~19.04
sudo apt install openjdk-8-jre-headless   # version 8u222-b10-1ubuntu1~19.04.1
sudo apt install openjdk-13-jre-headless  # version 13~13-0ubunt1

echo_done "Java configuration!"
