echo "a" | sudo -S chmod 777 /opt/

LV_BRANCH='release-1.3/neovim-0.9'
rustup default stable && curl -s "https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh" > installLunarvim.sh && chmod +x installLunarvim.sh && printf "y\nn\ny" | ./installLunarvim.sh
rm -rf ~/.config/lvim && cp ~/debianPostinstall/lvim ~/.config/ -r

sudo chmod 755 /opt/
