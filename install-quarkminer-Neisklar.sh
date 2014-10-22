# Your quarkminer in the cloud - new manual
# see www.tiny.cc/_____ for what this is.
#
# version 6.01
# - tested on RaspberryPi
# - tested on DigitalOcean 5$ Droplet 
#
# Droplet ? ? 
# A cheap linux virtual server (VPS) in the cloud, created in 55seconds
# Sign up at digital ocean http://tiny.cc/digocean NL USA Singapur 
# You probably get 10$ welcome bonus if you go through my link before signing up.
#

## newest versions of everything:
sudo apt-get update
sudo apt-get upgrade -y

## necessary packages, no asking just do it:
sudo apt-get install git screen automake libcurl4-gnutls-dev -y
## in case git & screen is not installed yet.
## fixes the missing automake: error  aclocal: not found
## fixes the syntax error near unexpected token LIBCURL_CHECK_CONFIG


## git-clone the sourcecode from uncle-bob:
# git clone https://github.com/uncle-bob/quarkcoin-cpuminer uncle-bob
# cd uncle-bob
## uncle-bob doesn't work, because it forces sse2 
## jh_sse2_opt64.h:26:23: fatal error: emmintrin.h: No such file or directory
## and the switch --disable-sse2 is not recognized:
# ./configure CFLAGS="-O3" --disable-sse2
## configure: WARNING: unrecognized options: --disable-sse2


## so we choose the Neisklar miner:
git clone https://github.com/Neisklar/quarkcoin-cpuminer Neisklar
cd Neisklar

## fix the error possibly undefined macro: AC_MSG_ERROR
aclocal -I m4 --install

./autogen.sh
./configure CFLAGS="-O3"
make
sudo make install

cd ..
minerd --version
