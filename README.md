# debianPostinstall

Get a default debian install iso don't install any Desktop(only select the last box in the list!) then in the command line:

su
/usr/sbin/usermod -aG sudo n0ne
su n0ne
sudo apt install git
git clone https://github.com/systeminstall2/debianPostinstall
cd debianPostinstall
chmod +x postInstallScript.sh
./postInstallScript.sh
