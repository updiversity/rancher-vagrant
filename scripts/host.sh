#!/bin/bash -x
vagrant_user=${1:-updiversity}
vagrant_box_path=${2:-$HOME}

sudo apt-get update
sudo apt-get -y install upstart

echo "description \"Start vagrant rancher boxes on system startup\"
author \"$vagrant_user\"
env VAGRANTUSR=$vagrant_user
env VAGRANTBOXPATH=$vagrant_box_path
start on stopped rc
stop on runlevel [016]

pre-start script
    cd \${VAGRANTBOXPATH}
    su -c \"/usr/bin/vagrant up\" \${VAGRANTUSR}
end script

post-stop script
    cd \${VAGRANTBOXPATH}
    su -c \"/usr/bin/vagrant halt\" \${VAGRANTUSR}
end script" | sudo tee --append /etc/init/upstart-vagrant-rancher.conf
