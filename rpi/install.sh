#!/usr/bin/env bash

# Should be converted to Ansible

sudo apt install -y vim # quality of life
sudo apt install -y dnsutils # dig

sudo apt install -y unbound

# https://wiki.debian.org/NetworkConfiguration#Using_systemd-resolved_for_DNS_resolution
sudo apt install -y systemd-resolved
systemctl enable systemd-resolved
ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf

# https://unbound.docs.nlnetlabs.nl/en/latest/getting-started/configuration.html#set-up-remote-control
sudo unbound-control-setup

unbound-checkconf /etc/unbound/unbound.conf

sudo pkill -f unbound
sudo unbound-control start

# for further configuration updates use
# sudo unbound-control reload
