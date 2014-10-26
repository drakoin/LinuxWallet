COPYRIGHT1="MUEminerStart"
COPYRIGHT2="see www.tiny.cc/linuxMUE for what this is."
COPYRIGHT3="version 6.13 by drakoin."
COPYRIGHT4="reward me MUE to my 7CYDzgs5wyXXZqBWJJPmuXkovXbESrSTKT - thanks."


# username, for P2POOLS it is simply your WALLET ADDRESS:

POOLUSERNAME=79v7igjJW5sqtbb4N6FTY7eUmHUcewQbyv


## address of your pool, incl protocol, and port:
#POOLADDRESS=stratum+tcp://goldmin.es:7112   # difficulty 0.01
POOLADDRESS=stratum+tcp://goldmin.es:7113   # difficulty 0.1
#POOLADDRESS=stratum+tcp://goldmin.es:7114   # difficulty 1



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


# password is usually x
POOLPASSWORD=x

# algorithm
ALGO=quark

# yes, you want that to be true, otherwise the cpulimit tasks are piling up:
KILLCPULIMIT=true

rm -f mmmm.sh

echo echo >mmmm.sh
echo echo $COPYRIGHT1>>mmmm.sh
echo echo $COPYRIGHT2>>mmmm.sh
echo echo $COPYRIGHT3>>mmmm.sh
echo echo $COPYRIGHT4>>mmmm.sh
echo echo >>mmmm.sh
echo echo >>mmmm.sh
echo echo starting minerd with cpulimit $CPUPERCENT and nicelevel $NICELEVEL ... >>mmmm.sh
echo echo mining on pool $POOLADDRESS - your username is $POOLUSERNAME>>mmmm.sh
echo cpulimit -b -e minerd  -l $CPUPERCENT>>mmmm.sh
echo echo>>mmmm.sh
echo echo _____ CTRL-A D ________________ to leave this screen>>mmmm.sh
echo echo _____ screen -r miner _________ to return to this screen>>mmmm.sh
echo echo>>mmmm.sh
echo nice -n $NICELEVEL minerd -a $ALGO -o $POOLADDRESS -p $POOLPASSWORD -u $POOLUSERNAME>>mmmm.sh

if $KILLCPULIMIT; then
	echo kill all process IDs with cpulimit and minerd in commandline, get rid of old cpulimit processes 
	kill $(ps gux | grep cpulimit | grep minerd |  tr -s ' ' | cut -d ' ' -f 2)
	sleep 1.7
fi

chmod a+x ./mmmm.sh
mv mmmm.sh minerd_$POOLUSERNAME.sh

screen -S miner ./minerd_$POOLUSERNAME.sh
