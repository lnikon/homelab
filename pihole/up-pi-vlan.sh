#!/usr/bin/env bash

set -x

sudo docker network create -d ipvlan \
	--subnet=192.168.5.0/24 \
	--gateway=192.168.5.1 \
	--ip-range 192.168.5.192/27 \
	--aux-address="piholeserver=192.168.5.223" \
	-o ipvlan_mode=l2 \
	-o parent=wlan0 macvlan0 

sudo ip link set wlan0 promisc on
sudo ip link add macvlan-shim link wlan0 type ipvlan mode l2 bridge
sudo ip addr add 192.168.5.223/32 dev macvlan-shim
sudo ip link set macvlan-shim up
sudo ip route add 192.168.5.192/27 dev macvlan-shim
sudo ifconfig macvlan-shim

docker-compose up -d
