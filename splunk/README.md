## <https://joachim8675309.medium.com/vagrant-with-macbook-mx-arm64-0f590fd7e48a>

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

cd splunk
vagrant up splunk --provision

vagrant status
Current machine states:

splunk                    not_created (qemu)

```
