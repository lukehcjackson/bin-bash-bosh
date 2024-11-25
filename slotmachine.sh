#!/usr/bin/env bash
set -euo pipefail

#requires setting $BALANCE in .bashrc

options=(7 ☘ ★ ≡ = - ⥀)

v1=${options[(($RANDOM % ${#options[@]}))]}
v2=${options[(($RANDOM % ${#options[@]}))]}
v3=${options[(($RANDOM % ${#options[@]}))]}

clear

echo "  _________  "
echo " / ....... \\"
echo "|..  \$\$\$  ..|"
echo "|== SLOTS ==| o"
echo "|---|---|---| |"
echo "|   |   |   | |"
echo "|---|---|---| |"
echo "|===========|D-"
echo "|###########|"
echo "|####|‾|####|"
echo "============="

sleep 0.1
clear

echo "  _________  "
echo " / ....... \\"
echo "|..  \$\$\$  ..|"
echo "|== SLOTS ==|"
echo "|---|---|---| O"
echo "|   |   |   | |"
echo "|---|---|---| |"
echo "|===========|D-"
echo "|###########|"
echo "|####|‾|####|"
echo "============="

sleep 0.2
clear

echo "  _________  "
echo " / ....... \\"
echo "|..  \$\$\$  ..|"
echo "|== SLOTS ==|"
echo "|---|---|---|"
echo "|   |   |   | 0"
echo "|---|---|---| |"
echo "|===========|D-"
echo "|###########|"
echo "|####|‾|####|"
echo "============="

sleep 0.5
clear

echo "  _________  "
echo " / ....... \\"
echo "|..  \$\$\$  ..|"
echo "|== SLOTS ==| o"
echo "|---|---|---| |"
echo "| $v1 | $v2 | $v3 | |"
echo "|---|---|---| |"
echo "|===========|D-"
echo "|###########|"
echo "|####|‾|####|"
echo "============="

#environment variable for your wallet.
#each spin costs some money from that wallet
#and also takes a little bit of time, do some funny rendering, draw the handle being pulled and play a sound?
#command / argument to inject cash into the wallet

# work out which slots matched and what they matched on

echo ""
ticketText=""
won=0

function getIndex () {
    local value=$1

    for i in "${!options[@]}"; do
        if [[ "${options[$i]}" == "$value" ]]; then
            echo "$i"
        fi
    done
}

if [[ "$v1" == "$v2" ]] && [[ "$v2" == "$v3" ]]; then
    #three match

    pos=$(getIndex "$v1")
    case $pos in 
        0)
            ticketText="JACKPOT"
            won=9999
            ;;
        1)
            ticketText="BIG WIN"
            won=4000
            ;;
        2)
            ticketText="TRIPLE STAR"
            won=2500
            ;;
        3 | 4 | 5 | 6)
            ticketText="TRIPLE"
            won=900
            ;;
    esac

elif [[ "$v1" == "$v2" ]] || [[ "$v1" == "$v3" ]] || [[ "$v2" == "$v3" ]]; then
    #two match
    if [[ "$v1" == "$v2" ]] || [[ "$v1" == "$v3" ]]; then
        pos=$(getIndex "$v1")
    else #v2 == v3
        pos=$(getIndex "$v2")
    fi

    case $pos in 
        0)
            ticketText="BIG WIN"
            won=1500
            ;;
        1)
            ticketText="LUCKY"
            won=777
            ;;
        2)
            ticketText="DOUBLE STAR"
            won=666
            ;;
        3 | 4 | 5)
            ticketText="DOUBLE BAR"
            won=333
            ;;
        6)
            ticketText="WIN"
            won=111
            ;;
    esac

else
    #no matches
    if [[ $(getIndex "$v1") == 0 ]] || [[ $(getIndex "$v2") == 0 ]] || [[ $(getIndex "$v3") == 0 ]]; then
        ticketText="PAYOUT"
        won=77
    fi

fi

#add win to balance
# BALANCE=$(( $BALANCE + won ))

#display ticket
if [[ -z "$ticketText" ]]; then
    ticketText="NO PAYOUT"
fi

desiredlength=16
numTextSpaces=$(( $desiredlength - ${#ticketText} - 4))
numNumberSpaces=$(( $desiredlength - ${#won} - 9))

textSpaces=""
numSpaces=""

for ((i = 0; i < $numTextSpaces; i++ )); do
    textSpaces="$textSpaces "
done

for ((i = 0; i < $numNumberSpaces; i++ )); do
    numSpaces="$numSpaces "
done

echo "================"
echo "| $ticketText $textSpaces|"
echo "| Won: $won $numSpaces|"
#echo "$BALANCE"
echo "================"

# rcFile="~/.bashrc"

# prop="BALANCE"   # export property to insert
# val="$BALANCE"          # the desired value

# if grep -q "^export $prop=" "$rcFile"; then
#   sed -i "s/^export $prop=.*$/export $prop=$val/" "$rcFile" &&
#   echo "[updated] export $prop=$val"
# else
#   echo -e "export $prop=$val" >> "$rcFile"
#   echo "[inserted] export $prop=$val"
# fi