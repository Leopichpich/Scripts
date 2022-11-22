mkdir blueteam_install
cd blueteam_install
siftcli='https://github.com/teamdfir/sift-cli/releases/download/v1.14.0-rc1/sift-cli-linux'
siftclisig='https://github.com/teamdfir/sift-cli/releases/download/v1.14.0-rc1/sift-cli-linux.sig'
siftclipub='https://github.com/teamdfir/sift-cli/releases/download/v1.14.0-rc1/sift-cli.pub'

wget $siftcli
wget $siftclisig
wget $siftclipub

apt install golang -y

go install github.com/sigstore/cosign/cmd/cosign@latest

cosign verify-blob --key sift-cli.pub --signature sift-cli-linux.sig sift-cli-linux

mv sift-cli-linux /usr/local/bin/sift
chmod 755 /usr/local/bin/sift
apt-get update

sift install --mode=packages-only


sleep 10

wget https://REMnux.org/remnux-cli

mv remnux-cli remnux
chmod +x remnux
mv remnux /usr/local/bin

apt install -y gnupg

python3 -m pip install importlib_metadata==4.13.0

remnux install --mode=addon


remnux upgrade
sift upgrade

rm -rf blueteam_install

reboot
