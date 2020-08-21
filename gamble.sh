#!/bin/bash -x

stake=100
bet=1
maxDays=30
wins=0
loss=0
winDays=0
loseDays=0
stakePercent=$((((stake*50))/100))
dayStake=$stake

dailyBetCalc(){
	stake=100
	dayStake=$stake
	stakePercent=$((((stake*50))/100))
	while [ $stake -gt $((dayStake-stakePercent)) ] && [ $stake -lt $((dayStake+stakePercent)) ]
	do
		result=$((RANDOM%2))
		if [ $result -eq 1 ]
		then
			stake=$((stake + bet))
			(( wins++ ))
		else
			stake=$((stake - bet))
			(( loss++ ))
		fi
	done
	
	if [ $wins -gt $loss ]
	then
		(( winDays++ ))
	else
		(( loseDays++ ))
	fi
}

finalStakeCalc(){
	if [ $winDays -gt $loseDays ]
	then
		winStake=$((winDays*stakePercent))
		echo "Gambler won by $winDays days and winning amount is: $winStake"
	else
		loseStake=$((loseDays*stakePercent))
		echo "Gambler won by $loseDays days and loosing amount is: $loseStake"
	fi
}

for (( i=0;  i<maxDays; i++ ))
do
dailyBetCalc
done
finalStakeCalc
