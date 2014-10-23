# mueminerstart.sh
# see www.tiny.cc/linuxMUE for what this is.
#
# version 6.04 by drakoin 
# reward me at 7CYDzgs5wyXXZqBWJJPmuXkovXbESrSTKT - Thanks!


# username, for P2POOLS it is simply your WALLET ADDRESS:
POOLUSERNAME=7JZwoTYXc4RV1TapAhBfxCWp1EPdyy6Rk3



# cpulimit will watch your miner, and keep it at a moderate level
# Makes a lot of sense, if you use your machine for anything else, 
# or if it is a virtual server, and your provider should not get 
# suspicious that you are using their machines for mining.
# (N.B.: If it's a quad core, then maximum is 400)
CPUPERCENT=50

# 19 = the miner will always step aside if there is something more important to do
NICELEVEL=19

# you probably do NOT have to change anything below here.
##########################################################

# address of your pool, incl protocol, and port:
POOLADDRESS=stratum+tcp://muepool.com:3333

# password is usually x
POOLPASSWORD=x

# algorithm
ALGO=quark

# yes, you want that to be true, otherwise the cpulimit tasks are piling up:
KILLCPULIMIT=true

rm -f mmmm.sh

echo echo >mmmm.sh
echo echo starting minerd with cpulimit $CPUPERCENT and nicelevel $NICELEVEL ... >>mmmm.sh
echo cpulimit -b -e minerd  -l $CPUPERCENT>>mmmm.sh
echo echo>>mmmm.sh
echo echo _____ CTRL-A D ________________ to leave this screen>>mmmm.sh
echo echo _____ screen -r miner _________ to return to this screen>>mmmm.sh
echo echo>>mmmm.sh
echo nice -n $NICELEVEL minerd -a $ALGO -o $POOLADDRESS -p $POOLPASSWORD -u $POOLUSERNAME>>mmmm.sh

if $KILLCPULIMIT; then
	echo kill all process IDs with cpulimit and minerd in their commandline
	kill $(ps gux | grep cpulimit | grep minerd |  tr -s ' ' | cut -d ' ' -f 2)
	sleep 1.5
fi

chmod a+x ./mmmm.sh
mv mmmm.sh minerd_$POOLUSERNAME.sh

screen -S miner ./minerd_$POOLUSERNAME.sh
