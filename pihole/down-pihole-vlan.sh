#!/usr/bin/bash

set -x

sudo docker-compose down
sudo rm -rf backups/ etc-dnsmasq.d/ etc-pihole/
sudo docker network rm macvlan0
sudo ip link delete macvlan-shim
