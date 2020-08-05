#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "========================================================================================="
vagrant plugin install vagrant-libvirt #The vagrant-libvirt plugin is required when using KVM on Linux
vagrant plugin install vagrant-mutate #Convert vagrant boxes to work with different providers

# https://github.com/chef/bento/tree/master/packer_templates/centos
# vagrant box add "bento/centos-8.2" --provider=virtualbox
# vagrant mutate "bento/centos-8.2" libvirt
# vagrant up --provider=libvirt "vg-compute-06"

# https://app.vagrantup.com/fedora/boxes/32-cloud-base
# vagrant box add "centos/8" --provider=libvirt
# vagrant up --provider=libvirt "vg-compute-06"

# https://app.vagrantup.com/fedora/boxes/32-cloud-base
# vagrant box add "centos/8" --provider=libvirt
# vagrant up --provider=libvirt "vg-compute-13"

# https://github.com/chef/bento/tree/master/packer_templates/ubuntu
vagrant box add "bento/ubuntu-16.04" --provider=virtualbox
vagrant mutate "bento/ubuntu-16.04" libvirt
vagrant up --provider=libvirt "vg-moloch-01"


vagrant box list #veridy installed boxes
vagrant status #Check the status of the VMs to see that none of them have been created yet
vagrant status
virsh list --all #show all running KVM/libvirt VMs



echo "========================================================================================="
