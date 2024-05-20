# debianPostinstall

Get a default debian install iso don't install any Desktop(only select the last box in the list!) then in the command line:

su
apt install git sudo
/usr/sbin/usermod -aG sudo n0ne
su n0ne
git clone https://github.com/systeminstall2/debianPostinstall
cd debianPostinstall
chmod +x postInstallScript.sh
./postInstallScript.sh
