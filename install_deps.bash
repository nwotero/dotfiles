# Setup source for Nala
nala_deb="deb [arch=amd64,arm64,armhf] http://deb.volian.org/volian/ scar main"
grep -qxF $nala_deb || $(echo "Getting sources for Nala" \
    && echo $nala_deb | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list \
    && wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null)

# Apt Install Packages
sudo apt update && sudo apt install \
    bat                             \
    build-essential                 \
    cargo                           \
    cmake                           \
    curl                            \
    fontconfig                      \
    fzf                             \
    git                             \
    golang                          \
    make                            \
    nala                            \
    neofetch                        \
    nodejs                          \
    npm                             \
    python3-pip                     \
    ripgrep                         \
    sc-im                           \
    trash-cli                       \
    unzip

# Install Neovim
command -v nvim || $(echo "Getting Neovim" && bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/rolling/utils/installer/install-neovim-from-release))
command -v lvim || $(echo "Getting LunarVim" && $(LV_BRANCH=rolling bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh)))

# Install Nerd Fonts
apps_dir="$HOME/apps"
[[ -e "$apps_dir/getnf" ]] || $(echo "Getting NerdFont Installer" && git clone -C $apps_dir/getnf https://github.com/ronniedroid/getnf.git && pushd $apps_dir/getnf && ./install.sh && popd)
