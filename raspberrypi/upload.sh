#!/bin/bash

# 1. get into the git repository
cd ~/Documents/CPSC_334
git checkout raspberrypi
git pull origin raspberrypi

# 2. get the IP address into the ip.md file
hostname -I > ~/Documents/CPSC_334/misc/raspberrypi/ip.md

# 2. push to the git repository
git add -A
git commit -m "AUTO: Raspi IP address [$(date)]"
git push origin raspberrypi
