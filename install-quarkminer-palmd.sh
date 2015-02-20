echo
echo install-quarkminer-palmd.sh
echo
echo Your quarkminer in the cloud - new manual
echo  see  www.tiny.cc/linuxMUE   for what this is.
echo version 6.36 by drakoin 
echo
echo reward me 
echo MUE to 7CYDzgs5wyXXZqBWJJPmuXkovXbESrSTKT or
echo BTC to 1M2zGd4LJTpt8fcsBTexFPQSq4gdYYHdA9 or
echo get your VPS at www.tiny.cc/digocean - Thanks!
echo

# 
# - tested on RaspberryPi - DOES NOT WORK due to lack of sse2
# - tested on DigitalOcean 5$ Droplet - DOES WORK PERFECTLY
#
# Droplet ? ? 
# A cheap linux virtual server (VPS) in the cloud, created in 55seconds
# Sign up at digital ocean http://tiny.cc/digocean NL USA Singapur 
# You probably get 10$ welcome bonus if you go through my link before signing up.


## newest versions of everything:
sudo apt-get update
sudo apt-get upgrade -y

## necessary packages, no asking just do it:
sudo apt-get install git screen cpulimit automake libcurl4-gnutls-dev -y
## in case git & screen is not installed yet.
## fixes the missing automake: error  aclocal: not found
## fixes the syntax error near unexpected token LIBCURL_CHECK_CONFIG



## uncle-bob miner:
#git clone https://github.com/uncle-bob/quarkcoin-cpuminer uncle-bob
#cd uncle-bob
## uncle-bob doesn't work on RaspberrPi, because it forces sse2 
## jh_sse2_opt64.h:26:23: fatal error: emmintrin.h: No such file or directory
## and the switch --disable-sse2 is not recognized:
# ./configure CFLAGS="-O3" --disable-sse2
## configure: WARNING: unrecognized options: --disable-sse2

## palmd miner:
git clone git://github.com/palmd/quarkcoin-cpuminer palmd
cd palmd
# N.B. palmd miner does NOT work on RaspberryPi 
# because of lack of SSE2 support,
# and this miner forces the use of  #include "jh_sse2_opt64.h"
# https://github.com/palmd/Cp3u/blob/master/quark.c#L15

## Neisklar miner:
#git clone https://github.com/Neisklar/quarkcoin-cpuminer Neisklar
#cd Neisklar



## fix the error possibly undefined macro: AC_MSG_ERROR
# aclocal -I m4 --install

./autogen.sh
./configure CFLAGS="-O3"
make
sudo make install

cd ..
minerd --version
