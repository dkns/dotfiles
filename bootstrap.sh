#!/bin/bash
set -euo pipefail

function package_installed() {
  dpkg-query -W -f='${Status}' "$1" 2>/dev/null | grep -c "ok installed";
}

function install_package() {
  if [ $(package_installed "$1") -eq 0 ]; then
    sudo apt-get install "$1"
    echo "Installed $1"
  else
    echo "$1 already installed"
  fi
}

function install_multiple_packages() {
  sudo apt-get update;

  for package in $1; do
    install_package "$package";
  done
}

function bootstrap_docker_compose() {
  if [ ! -f /usr/bin/docker-compose ]; then
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
  fi
}

function bootstrap_docker() {
  install_multiple_packages "ca-certificates curl gnupg lsb-release"

  if [ ! -f /usr/share/keyrings/docker-archive-keyring.gpg ]; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  fi

  if [ ! -f /etc/apt/sources.list.d/docker.list ]; then
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  fi

  install_multiple_packages "docker-ce docker-ce-cli containerd.io";
  bootstrap_docker_compose
}

function bootstrap_rg() {
  sudo apt-get update
  install_package "ripgrep"
}

function setup_clipboard_for_nvim() {
  if [ ! -f /usr/local/bin/win32yank.exe ]; then
    curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
    unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
    chmod +x /tmp/win32yank.exe
    sudo mv /tmp/win32yank.exe /usr/local/bin/
  fi
}  

#bootstrap_docker
#bootstrap_rg
setup_clipboard_for_nvim
