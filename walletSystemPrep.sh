# Your wallet in the cloud - new manual
# see www.tiny.cc/linuxMUE for what this is.
#
# part 1: prepare the system
# part 1 of the complete instructions how to compile a wallet daemon from github sources

echo 
echo walletSystemPrep.sh by DRAKOIN - version v6.20
# - always assumes 'yes' also in very first apt-get update upgrade
# - relative paths
# - always assumes 'yes' in apt-get
# - rm -f because of 'remove write-protected ...' questions
# - check if /swapfile already exists

echo 
# I succeeded with this on Ubuntu 12.04 and Debian 7.0 x64.
# With swapfile, it will work even on the smallest Digital Ocean 5$ droplet (0.5GB RAM) ! 
# What?  "droplet"?  Your own server for 5$ per month!
# A cheap linux virtual server (VPS) in the cloud, created in 55seconds
# Sign up at digital ocean http://tiny.cc/digocean NL USA Singapur
# You probably get 10$ welcome bonus if you go through my link before signing up.


# Create droplet: Choose 512MB; Region close to you; "Debian 7.0 x64".
# Wait for the email with the root password. 
# To connect use ssh / putty.exe (data... auto-login: root)

# change password (at digitalocean now automatic when logging in for the first time)
# passwd

# become superuser
# sudo -i

# update all software (all the installed packages)
sudo apt-get update -y ; sudo apt-get upgrade  -y

# prep the system to be able to git & compile & build
sudo apt-get install git make automake build-essential libboost-all-dev nano -y

# might be necessary for other tools & distros (for this wallet on Debian 7 it is not):
# apt-get install yasm binutils libcurl4-openssl-dev openssl libssl-dev 

# compiling needs a large SWAP file:
[ -f /swapfile ] && sudo swapoff /swapfile
sudo dd if=/dev/zero of=/swapfile bs=60M count=16
sudo mkswap /swapfile; sudo swapon /swapfile


# For some reason, bitcoind is stuck in an old database version db4.8, 
# which is not supported by newest ubuntu / debian anymore, so we get it manually:

# Get db4.8 source, compile and install (takes 5 minutes - or > 1 hour on RaspberryPi)
wget http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz
tar zxf db-4.8.30.NC.tar.gz
cd db-4.8.30.NC/build_unix; ../dist/configure --enable-cxx
make; sudo make install
cd ../..

echo
echo DB4.8 is installed, now delete all sources
rm -Rf db-4.8.30.NC*   # delete the sources, -f because of 'remove write-protected ...' questions

# Link the libraries 
sudo ln -s /usr/local/BerkeleyDB.4.8/lib/libdb-4.8.so /usr/lib/libdb-4.8.so
sudo ln -s /usr/local/BerkeleyDB.4.8/lib/libdb_cxx-4.8.so /usr/lib/libdb_cxx-4.8.so

echo
echo SERVER IS PREPARED. FROM HERE ON YOU CAN INSTALL WALLETS
echo 

# where to find db4.8 tell your system  (needs to be redone after reboot)
export BDB_INCLUDE_PATH="/usr/local/BerkeleyDB.4.8/include"
export BDB_LIB_PATH="/usr/local/BerkeleyDB.4.8/lib"

