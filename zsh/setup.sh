#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

action="install zsh"
if ! check_dependency zsh; then
  if is_linux && confirm "$action"; then
    sudo apt install zsh
  elif is_mac && confirm "$action"; then
    brew install zsh
  else
    echo "Failed to $action: unsupported OS"
  fi
fi

action="install oh-my-zsh"
if [ ! -d "$HOME/.oh-my-zsh" ] && confirm "$action"; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

action="install starship prompt"
if ! check_dependency starship; then
  if is_linux && confirm "$action"; then
    sudo curl -fsSL https://starship.rs/install.sh | sh 
  elif is_mac && confirm "$action"; then
    brew install starship
  else
    echo "Failed to $action: unsupported OS"
  fi
fi

action="install zsh plugins/themes"
if confirm "$action"; then
  ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-completions.git $ZSH_CUSTOM/plugins/zsh-completions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi

action="change default shell to zsh"
if confirm "$action"; then
  chsh -s "$(which zsh)"
fi

action="link config"
if confirm "$action"; then
  if is_linux || is_mac; then
    link_config "$HOME/dotconfig/zsh/.zshrc" "$HOME/.zshrc"
  else
    echo "invalid OSTYPE $OSTYPE for zsh setup"
  fi
fi

action="link p10k"
if confirm "$action"; then
  if is_linux || is_mac; then
    link_config "$HOME/dotconfig/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
  else
    echo "invalid OSTYPE $OSTYPE for zsh setup"
  fi
fi
