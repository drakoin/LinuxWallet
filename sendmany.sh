# sendmany
# v6.35 by drakoin 26.2.2014 update 13.2.2015
# helps if too many too small transactions are polluting your wallet
#
# hint: make wallets on 2 machines, then send all from wallet1 to wallet2
# (wallet2 contains the CNOTE address CTVHuvvdJj61fC1mzFAQ4V1TrYBb8QTpiA )
# (wallet2 contains the MUE address   793AKFakqZPGRyFWPp21dp8b9gRA7YFGnf )
#
# examples  
# ./sendmany.sh ~/C-Note/c-noted CTVHuvvdJj61fC1mzFAQ4V1TrYBb8QTpiA 10 25 BundlingUpSmallTransactions
# ./sendmany.sh monetaryunitd 793AKFakqZPGRyFWPp21dp8b9gRA7YFGnf 5 5000 BundlingUpSmallTransactions
#
# home of this is now on github:
# https://github.com/drakoin/LinuxWallet/blob/master/sendmany.sh
# for explanations see bitcointalk thread 488167:
# https://bitcointalk.org/index.php?topic=488167
#
# how to use:
# wget https://raw.githubusercontent.com/drakoin/LinuxWallet/master/sendmany.sh
# chmod u+x sendmany.sh
# ./sendmany.sh
#
# P.S.: No guarantees whatsoever. Your own risk. 
# If you run it, read the whole script before, so that you understand what it does.
# Start with small packagesize and number, wait for confirmations, check target wallet.
# Then raise the number and or packagesize. Then donate *g*.

echo
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ] || [ -z "$5" ]; then
  echo "Usage: sendmany.sh walletd targetaddress number packagesize message"
  exit -1
fi
echo I will use $1 to send $3 packages of size $4 to $2 with message $5
read -p "Press Ctrl-C if you do NOT want that, or ENTER if you agree..."
echo Good. Let us start.
BALANCEBEFORE=$($1 getbalance)
if [ "$?" != "0" ]; then
        echo I could not get the current balance, probably the walletdaemon is not running.
        echo Exiting now. Sorry, please check situation, and try again.
        exit 1
fi
echo Balance before the action was $BALANCEBEFORE
THISROUNDBEFORE=$BALANCEBEFORE
BALANCEAFTER=$BALANCEBEFORE
for (( i = 1 ; i <= $3 ; i++ ))
do
        TX=$($1 sendtoaddress $2 $4 $5)
        if [ "$?" != "0" ]; then
                :
        else
                BALANCEAFTER=$($1 getbalance)
                echo BEFORE=$THISROUNDBEFORE AFTER=$BALANCEAFTER TX-ID=$TX
                THISROUNDBEFORE=$BALANCEAFTER
        fi
done
echo Ready.
echo In total, including transaction fees,   $(echo $BALANCEBEFORE-$BALANCEAFTER | bc)   were sent.
echo Balance after all that action now is:  $($1 getbalance)
echo .
echo Please consider to tip drakoin for this script at: 
echo in BTC = 1JLKNFxKjkU3YsLs38y4e672iWiXBeFYP3 
echo or C-Notes = CTVHuvvdJj61fC1mzFAQ4V1TrYBb8QTpiA 
echo or MUE = 793AKFakqZPGRyFWPp21dp8b9gRA7YFGnf 
echo Thanks!
echo .