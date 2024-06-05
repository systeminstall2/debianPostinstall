echo "a" | sudo -S chmod 777 /opt/

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > installRust.sh && sudo chmod +x installRust.sh && ./installRust.sh -q -y
echo 'export RUSTUP_HOME=/opt/rust' | sudo tee -a /etc/profile.d/rust.sh
echo 'export PATH=$PATH:/opt/rust/bin' | sudo tee -a /etc/profile.d/rust.sh
source ~/.cargo/env
source /etc/profile
rustup default stable
source ~/.cargo/env
source /etc/profile
#Temporary alias bc after reboot it works anyway
export PATH=$PATH:~/.cargo/bin
cargo install fd-find --force
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
sudo chmod +x nvim.appimage
sudo mv nvim.appimage /usr/bin/nvim
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh" | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install --lts
LV_BRANCH='release-1.3/neovim-0.9'
source ~/.cargo/env
source /etc/profile
rustup default stable
source ~/.cargo/env
source /etc/profile
echo "export PATH=/home/n0ne/.local/bin:\$PATH" >> ~/.zshenv
rm -rf ~/.config/lvim && cp lvim ~/.config/lvim -r
rustup default stable && curl -s "https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh" > installLunarvim.sh && chmod +x installLunarvim.sh && printf "y\nn\ny" | ./installLunarvim.sh

sudo chmod 755 /opt/
