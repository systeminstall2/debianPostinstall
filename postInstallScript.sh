echo "a" | sudo -S echo

echo "Defaults passwd_timeout=1000" | sudo tee -a /etc/sudoers.d/custom_sudoers


printf "\n\n\n The Script will install everything now, you don't have to do anything!\n\n\n"

#Creating Basic folders

mkdir ~/Unwichtig
mkdir ~/Hashcat

#Installing Software

sudo apt install curl -y

#TODO PROTONVPN

LATEST_VERSION=$(curl -s https://api.github.com/repos/balena-io/etcher/releases/latest | grep tag_name | cut -d\" -f4)
LATEST_VERSION_ADAPTED=${LATEST_VERSION:1}
ETCHER_DEB_URL="https://github.com/balena-io/etcher/releases/download/${LATEST_VERSION}/balena-etcher_${LATEST_VERSION_ADAPTED}_amd64.deb"
sudo wget $ETCHER_DEB_URL
#sudo chown _apt balena-etcher_${LATEST_VERSION}_amd64.deb
sudo apt install ./balena-etcher_${LATEST_VERSION_ADAPTED}_amd64.deb -y

LATEST_VERSION=$(curl -s https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest | grep tag_name | cut -d\" -f4)
FASTFETCH_DEB_URL="https://github.com/fastfetch-cli/fastfetch/releases/download/${LATEST_VERSION}/fastfetch-linux-amd64.deb"
sudo wget $FASTFETCH_DEB_URL
sudo chown _apt fastfetch-linux-amd64.deb
sudo apt install ./fastfetch-linux-amd64.deb -y

LATEST_VERSION=$(curl -s https://api.github.com/repos/rustdesk/rustdesk/releases/latest | grep tag_name | cut -d\" -f4)
LATEST_VERSION_ADAPTED=${LATEST_VERSION}
RUSTDESK_DEB_URL="https://github.com/rustdesk/rustdesk/releases/download/${LATEST_VERSION_ADAPTED}/rustdesk-${LATEST_VERSION}-x86_64.deb"
echo "a" | sudo -S  wget $RUSTDESK_DEB_URL
echo "a" | sudo -S chown _apt rustdesk-${LATEST_VERSION}-x86_64.deb
echo "a" | sudo -S apt install ./rustdesk-${LATEST_VERSION}-x86_64.deb -y

sudo apt-get install wget gpg -y
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt-get update -y
sudo apt-get install code -y
sudo apt-get autoremove -y

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian $(lsb_release -d -a | tail -n 1 | awk '{print $2}') contrib" | sudo tee -a /etc/apt/sources.list
wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor
sudo apt update -y
sudo apt install virtualbox -y > testttt
virtualbox_name=$(head -n 5 testttt | tail -n 1 | awk '{print $1}')

sudo apt install flatpak -y 
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub org.torproject.torbrowser-launcher -y
printf "#!/bin/bash\n\nflatpak run org.torproject.torbrowser-launcher" | sudo tee /usr/bin/torbrowser-launcher
sudo chmod +x /usr/bin/torbrowser-launcher

ventoyVersion=$(curl https://github.com/ventoy/Ventoy/releases | grep -v "ventoy.*zip" | grep "ventoy-.*tar\.gz" -o | head -n 5 | head -n -2 | tail -n -1 | grep -Eo "[0-9].....")
ventoyURL="https://github.com/ventoy/Ventoy/releases/download/v$ventoyVersion/ventoy-$ventoyVersion-linux.tar.gz"
wget $ventoyURL -O ventoy.tar.gz
tar --extract -f ventoy.tar.gz
sudo cp ventoy-$ventoyVersion/ /opt/ventoy -r
# Very hacky solution and this deserves the death sentence but it works...
echo "sudo bash /opt/ventoy/Ventoy2Disk.sh \$1 \$2 \$3 \$4 \$5 \$6 \$7 \$8 \$9" | sudo tee /usr/bin/ventoy
sudo chmod +x /usr/bin/ventoy

sudo apt-get update -y && sudo apt upgrade -y && sudo apt install -y python3-pynvim ncdu sddm net-tools ark flatpak fzf dolphin firefox-esr wmname rustdesk syncthing code ripgrep fonts-hack-ttf brasero rofi feh polybar tree chromium cmake gnome-disk-utility netcat-openbsd gparted kate keepassxc btop prusa-slicer maim fastfetch nmap p7zip-full python3-pip ripgrep sxiv syncthing terminator ufw unzip vim $virtualbox_name wget whois xclip zenity zsh

# Setting up zsh plugins #####################

sudo mkdir -p /usr/share/zsh/plugins && sudo mkdir -p /usr/share/zsh/plugins/zsh-syntax-highlighting && sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /usr/share/zsh/plugins/zsh-syntax-highlighting  && sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git /usr/share/zsh-autosuggestions

# Install Nerdfonts for emojis

mkdir fonts && cd fonts && wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip" && unzip Hack.zip && sudo mkdir -p /usr/local/share/fonts && rm Hack.zip && sudo mv * /usr/local/share/fonts/ && cd ..
cd fonts && wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip" && unzip JetBrainsMono.zip && rm JetBrainsMono.zip && sudo mv * /usr/local/share/fonts/ && cd ..

# Copying all configs and stuff but only the important stuff not lunarvim(bc is done later) for kde and terminator etc etc

cat ~/debianPostinstall/zshrc > ~/.zshrc

sudo rm -rf ~/.config/* ~/.local/share/*
printf "A\n" | unzip configDirs.zip
cp ~/debianPostinstall/dotConfig/* ~/.config/ -r
cp ~/debianPostinstall/dotLocalShare/* ~/.local/share/ -r
sudo cp ~/debianPostinstall/sddmTheme/ /usr/share/sddm/themes/sugar-dark -r

#Burpsuite

wget https://portswigger.net/burp/releases/community/latest
VERSION=$(cat latest | grep -E "....\..\..\.." --color=auto -o | head -n 1)
wget "https://portswigger-cdn.net/burp/releases/download?product=community&version=2024.3.1.4&type=Linux" -O burp.sh
chmod +x burp.sh
printf "o\n \ny\n \n" | ./burp.sh -c

# Writing nvim #########################################

sudo chmod 777 /opt/

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
curl -s "https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh" > installLunarvim.sh && sudo chmod +x installLunarvim.sh && printf "y\nn\ny" | ./installLunarvim.sh
echo "export PATH=/home/n0ne/.local/bin:\$PATH" >> ~/.zshenv
rm -rf ~/.config/lvim && cp lvim ~/.config/lvim -r
#IDK/IDC IT ONLY WORKS LIKE THAT...
echo 'curl -s "https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh" > installLunarvim.sh && chmod +x installLunarvim.sh && printf "y\nn\ny" | ./installLunarvim.sh && echo "" > ~/.zprofile && reboot' > ~/.zprofile

sudo chsh -s /usr/bin/zsh
sudo chsh -s /usr/bin/zsh n0ne

sudo su -c 'echo "arch" > /etc/hostname'


#Wallpaper

cp ~/debianPostinstall/thisImage.jpg ~/Documents/thisImage.jpg

#finishing

sudo chmod 755 /opt/

sudo rm -rf /etc/sudoers.d/custom_sudoers

printf "\n\n\n\Installation Finished!\n\n\n"
echo -n "Rebooting in    " && for i in {10..1};do echo -n "$i   "&& sleep 1;done

systemctl reboot
