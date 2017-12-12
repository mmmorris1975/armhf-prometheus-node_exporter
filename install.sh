#!/bin/bash -x

function cp_set_perms() {
  src=$1
  dest=$2
  mode=$3
  owner=$4

  sudo cp $src $dest
  sudo chown $owner $dest
  sudo chmod $mode $dest
}

REPO_DIR=$(dirname $0)
INSTALL_DIR=/usr/local/prometheus/bin

sudo mkdir -m 0755 -p $INSTALL_DIR
sudo chown root:root $INSTALL_DIR

# FIXME stop service, if already installed
cp_set_perms $REPO_DIR/node_exporter $INSTALL_DIR/ 0755 root:root

if [ $(ps -q 1 -o comm=) == systemd ]
then
  cp_set_perms $REPO_DIR/systemd-node_exporter.service /etc/systemd/system/node_exporter.service 0644 root:root
  sudo systemctl enable node_exporter.service
  # FIXME restart service
else
  echo "TODO: add install steps for other init systems (SysV/upstart would be next)"
fi
