# mueminerstart.sh
# see www.tiny.cc/linuxMUE for what this is.
#
# version 6.03 by drakoin 
# reward me at 7CYDzgs5wyXXZqBWJJPmuXkovXbESrSTKT - THANKS!

# username, for P2POOLS it is simply your wallet address:
POOLUSERNAME=7JZwoTYXc4RV1TapAhBfxCWp1EPdyy6Rk3

# cpulimit will watch your miner, and keep it at a moderate level
# Makes a lot of sense, if you use your machine for anything else, 
# or if it is a virtual server, and your provider should not get 
# suspicious that you are using their machines for mining.
# (N.B.: If it's a quad core, then maximum is 400)
CPUPERCENT=50


# you probably do NOT have to change anything below here.

# address of your pool, incl protocol, and port:
POOLADDRESS=stratum+tcp://muepool.com:3333

# password is usually x
POOLPASSWORD=x

# algorithm
ALGO=quark

cpulimit -b -e minerd  -l $CPUPERCENT
screen -S miner echo CTRL-A D to leave this screen; echo; minerd -a $ALGO -o $POOLADDRESS -p $POOLPASSWORD -u $POOLUSERNAME
