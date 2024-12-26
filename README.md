## https://joachim8675309.medium.com/vagrant-with-macbook-mx-arm64-0f590fd7e48a

```code
# install VM solution
brew install qemu

# install Vagrant with QEMU support
brew install --cask vagrant
vagrant plugin install vagrant-qemu


# download and startup VM using hvf
vagrant up --provider=qemu

# log into the VM
vagrant ssh

# Testing the virtual machine (arm64)
sudo apt-get update
sudo apt install -y inxi neofetch
neofetch

inxi --system --machine -- cpu -- network --disk --info


# https://www.splunk.com/en_us/download/splunk-enterprise.html?locale=en_us

wget -O splunk-9.4.0-6b4ebe426ca6-linux-amd64.tgz "https://download.splunk.com/products/splunk/releases/9.4.0/linux/splunk-9.4.0-6b4ebe426ca6-linux-amd64.tgz"
wget -O splunk-9.4.0-6b4ebe426ca6.x86_64.rpm "https://download.splunk.com/products/splunk/releases/9.4.0/linux/splunk-9.4.0-6b4ebe426ca6.x86_64.rpm"
wget -O splunk-9.4.0-6b4ebe426ca6-linux-amd64.deb "https://download.splunk.com/products/splunk/releases/9.4.0/linux/splunk-9.4.0-6b4ebe426ca6-linux-amd64.deb"

wget -O splunkforwarder-9.4.0-6b4ebe426ca6-linux-amd64.deb "https://download.splunk.com/products/universalforwarder/releases/9.4.0/linux/splunkforwarder-9.4.0-6b4ebe426ca6-linux-amd64.deb"

sudo dpkg -i splunkforwarder-9.4.0-6b4ebe426ca6-linux-amd64.deb

vagrant status
Current machine states:

splunk                    not_created (qemu)
splunk_forwarder          not_created (qemu)


```
# vagrant
