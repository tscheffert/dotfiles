function test_exists() {
  type $1 >/dev/null 2>&1
}

function install_neovim_dependencies {
  echo " -- Updating apt-get package info from sources --"
  sudo apt-get update

  # Install NeoVim dependencies_solarized
  echo ""
  echo " -- Updating and installing nvim dependencies --"
  sudo apt-get install \
    autoconf \
    automake \
    cmake \
    g++ \
    gettext \
    libtool \
    libtool-bin \
    ninja-build \
    pkg-config \
    unzip \
    --assume-yes
}
install_neovim_dependencies

# Clone and Build
function build_neovim {
  echo ""
  echo " --- Building Neovim --"
  local nvim_code_dir="$HOME/dev/github/neovim/neovim"
  if [[ ! -d "$nvim_code_dir" ]]; then
    echo ""
    echo " --- Pulling down code to $nvim_code_dir --"
    mkdir -p "$nvim_code_dir"
    git clone https://github.com/neovim/neovim.git "$nvim_code_dir"
  else
    echo ""
    echo " --- Neovim code exists at $nvim_code_dir, building there --"
  fi

  echo ""
  echo " --- Pulling latest --"
  cd "$nvim_code_dir"
  git pull

  if [[ -n "$REBUILD" ]]; then
    if [[ -d build ]]; then
      echo ""
      echo " --- Removing existing build folder --"
      rm -r build
    fi
    echo ""
    echo " --- Starting Neovim Build --"
    make clean
    make CMAKE_BUILD_TYPE=Release
    echo ""
    echo " --- Installing Neovim --"
    sudo make install
  fi
}
build_neovim

function uninstall_neovim {
  echo ""
  echo " -- Uninstalling Neovim --"
  sudo rm /usr/local/bin/nvim
  sudo rm -r /usr/local/share/nvim/
}

# Link config
function link_neovim_config {
  echo ""
  echo " -- Linking Neovim config --"
  mkdir -p "$HOME/.config/nvim"
  ln -sf "$HOME/.dotfiles/.config/nvim/init.vim" "$HOME/.config/nvim/init.vim"
}
link_neovim_config
