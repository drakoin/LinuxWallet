# Your wallet in the cloud - new manual
# see www.tiny.cc/linuxMUE for what this is.
#
# part 2: download sources, build, install and configure
# part 2 of the complete instructions how to compile a wallet daemon from github sources


# new version 5.4 
# - relative paths where possible
# - assumes 'yes' in apt-get
# - sudo only where necessary ( cp to /usr/local/bin )
# - automatically generate random rpcpassword


# where to find db4.8 tell your system  (needs to be redone after reboot)
export BDB_INCLUDE_PATH="/usr/local/BerkeleyDB.4.8/include"
export BDB_LIB_PATH="/usr/local/BerkeleyDB.4.8/lib"


# Wallet sources from github, and 
# build the headless server daemon "monetaryunitd" (takes 7 minutes)

git clone https://github.com/MonetaryUnit/MUE

cd MUE/src
mkdir obj; chmod a+x leveldb/build_detect_platform # fix 2 problems with these sources
make -f makefile.unix USE_UPNP=-
sudo cp monetaryunitd /usr/local/bin
cd ../..

# create config file in HOME folder 
# - copy-paste all in one go. Make sure to change your password.

mkdir ~/.monetaryunit
cat << "CONFIG" >> ~/.monetaryunit/monetaryunit.conf
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
sed -i 's/VERYSECURESUPERLONGSUPERSAFEPASSWORD/'$YOURPASS'/g' ~/.monetaryunit/monetaryunit.conf
# accessible only for this user:
chmod 700 ~/.monetaryunit/monetaryunit.conf
chmod 700 ~/.monetaryunit
ls -la ~/.monetaryunit

echo 
echo your random RPC password is $YOURPASS
echo but you can simply always look it up with 
echo less ~/.monetaryunit/monetaryunit.conf
echo --> 
cat ~/.monetaryunit/monetaryunit.conf | grep rpcpassword



# start server. Should result in: "Monetaryunit server starting"
monetaryunitd

echo
echo DONE. READY.
echo
echo to change your RPC password, edit monetaryunit.conf  then restart server:
echo nano ~/.monetaryunit/monetaryunit.conf
echo "monetaryunitd stop; sleep 2; monetaryunitd"
echo
echo Most important RPC commands: See   www.tiny.cc/linuxMUE    e.g. how to tip me:
echo monetaryunitd sendtoaddress 7QzuXv5p2Ys181CsLiYR9PFvqwzCW1aPmK 111 ThanksToDrakoin ThanksForTutorial
echo 

