# Your wallet in the cloud - new manual
# see www.tiny.cc/linuxMUE for what this is.
#
# part 2: download sources, build, install and configure
# part 2 of the complete instructions how to compile a wallet daemon from github sources

echo 
echo walletInstallMUE.sh by DRAKOIN - version v6.36 = 2015 February 20th
# - new 2015 source
# - recompiled everything for testing that manual still works
# - increased donation suggestion sum, due to very different MUE2BTC2USD situation
# - added more ways to reward me

# version v6.11:
# - relative paths where possible
# - assumes 'yes' in apt-get
# - sudo only where necessary ( cp to /usr/local/bin )
# - automatically generate a random rpcpassword
# - delete the old .conf before making a new one.
# - CONFFILE and CONFPATH variables
# - corrected donation address
echo

# where to find db4.8 tell your system  (needs to be redone after reboot)
export BDB_INCLUDE_PATH="/usr/local/BerkeleyDB.4.8/include"
export BDB_LIB_PATH="/usr/local/BerkeleyDB.4.8/lib"


# Wallet sources from github, and 
# build the headless server daemon "monetaryunitd" (takes 7 minutes)

git clone https://github.com/MonetaryUnit/MUE-Src

cd MUE-Src/src
# mkdir obj; # not necessary anymore, fixed in sourcecode (6.32)
chmod a+x leveldb/build_detect_platform # fix 2 problems with these sources
make -f makefile.unix USE_UPNP=-
sudo cp monetaryunitd /usr/local/bin
cd ../..

echo 
echo COMPILING READY! NOW CONFIGURATION!
echo

CONFPATH=$HOME/.monetaryunit
CONFFILE=$CONFPATH/monetaryunit.conf

# create config file in dedicated folder: 
if [ -d $CONFPATH ];
then
	echo ALERT: $CONFPATH exists already! Moving old .conf file to .conf.old
	mv $CONFFILE $CONFFILE.old
else
	echo creating $CONFPATH directory for blockchain and wallet
	mkdir $CONFPATH
fi

if [ -e $CONFFILE ];
then
	# echo deleting old conf file
	rm $CONFFILE
fi

cat << "CONFIG" >> $CONFFILE
listen=1
server=1
daemon=1
testnet=0
rpcuser=LOCALUSER
rpcpassword=VERYSECURESUPERLONGSUPERSAFEPASSWORD
rpcport=29947
CONFIG

# create a random password
function randpw { < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-25};echo;}
YOURPASS=$(randpw)
sed -i 's/VERYSECURESUPERLONGSUPERSAFEPASSWORD/'$YOURPASS'/g' $CONFFILE

# restrict access to only this user:
chmod 700 $CONFFILE
chmod 700 $CONFPATH
ls -la $CONFPATH

echo 
echo your random RPC password is $YOURPASS
echo but you can simply always look it up with 
echo less $CONFFILE
echo and search for this line:
cat $CONFFILE | grep rpcpassword
echo


echo Start server. Should result in: "Monetaryunit server starting"
monetaryunitd

echo
echo DONE. READY.
echo
echo to change your RPC password, edit monetaryunit.conf , then restart server:
echo nano $CONFFILE
echo "monetaryunitd stop; sleep 2; monetaryunitd"
echo
echo Most important RPC commands: See   www.tiny.cc/linuxMUE    e.g. how to tip me in MUE:
echo monetaryunitd sendtoaddress 7E5tkMCg1VjGwVXVr8SDb5DPCaZ6DkzSHa 111111 ThanksToDrakoin ThanksForTutorial
echo 
echo Tips: BTC to 13Eh3XYwxbJaE9PkT6resFEAbzrC48yozN or get your VPS at www.tiny.cc/digocean - Thanks!
