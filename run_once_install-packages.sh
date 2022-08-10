#!/bin/sh

main() {
  apt_update
  install_vscode
  install_zsh
  install_oh_my_zsh
  install_zsh_plugins
}

apt_update() {
 sudo apt-get update
}

# https://code.visualstudio.com/docs/setup/linux
install_vscode() {
 sudo apt-get install wget gpg apt-transport-https -y
 wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
 sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
 sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
 rm -f packages.microsoft.gpg
 apt_update
 sudo apt-get install code -y
}

install_zsh() {
  sudo apt-get install zsh -y
  chsh -s $(which zsh) # Make it the default shell
}

# https://github.com/ohmyzsh/ohmyzsh#unattended-install
install_oh_my_zsh() { 
  OH_MY_ZSH=~/.oh-my-zsh
  if [![-d "$OH_MY_ZSH" ]]; then 
    sudo apt-get install git -y
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi
}

install_zsh_plugins() {
  sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
  sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
}

install_powerlevel10k() {
  sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
}

main "$@"; exit
