#!/bin/bash

echo_info "Configuring exa..."

echo_info "Installing cargo..."
sudo apt install cargo

echo_info "Installing exa..."
cargo install exa

echo_done "exa configuration!"
