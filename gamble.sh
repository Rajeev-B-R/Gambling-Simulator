#!/bin/bash -x

stake=100
bet=1
maxDays=30

winDays=0
loseDays=0
count=1

declare -A arrayLucky
declare -A arrayUnlucky

dailyBetCalc(){
        stake=100
        wins=0
        loss=0        
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

        if [ $stake -gt $dayStake ]
	then
		arrayLucky[$count]=$wins
		arrayUnlucky[$count]=$loss
		((count++))
		((winDays++))
	else
		arrayLucky[$count]=$wins
            	arrayUnlucky[$count]=$loss
                ((count++))
		((loseDays++))
	fi
}

finalStakeCalc(){
        if [ $winDays -gt $loseDays ]
        then
                winStake=$((winDays*stakePercent))
                echo "Gambler won by $winDays days and winning amount is: $winStake"
        else
                loseStake=$((loseDays*stakePercent))
                echo "Gambler lost by $loseDays days and loosing amount is: $loseStake"
        fi
}

luckyDay(){
lucky=${arrayLucky[0]}
for i in ${arrayLucky[@]}
do
     if [[ $i -gt $lucky ]]
     then
        lucky="$i"
     fi
done

for i in ${arrayLucky[@]}
do
        ((countj++))
        if [[ $i -eq $lucky ]]
        then
                echo "Lucky day: $countj with win of $lucky times"
        fi
done

unlucky=${arrayUnlucky[0]}
for i in ${arrayUnlucky[@]}
do
     if [[ $i -gt $unlucky ]]
     then
        unlucky="$i"
     fi
done

for i in ${arrayUnlucky[@]}
do
	((countk++))
	if [[ $i -eq $unlucky ]]
	then
		echo "Unlucky day: $countk with loss of $unlucky times"
	fi
done
}

nextMonth(){
	if [ $winDays -gt $loseDays ]
	then
		echo "Congratulations! You can play for next month. Enter 0 to continue or 1 to stop"
		read choice
		if [ $choice -eq 0 ]
		then
			for (( i=0;i<30;i++ ))
			do
				dailyBetCalc
			done
			finalStakeCalc
			luckyDay
			nextMonth
		else
			echo "Thanks for playing!"
		fi
	else
		echo "Bad luck! You have lost. You cannot play for next month"
	fi
}

for (( i=0;  i<maxDays; i++ ))
do
    dailyBetCalc
done
finalStakeCalc
luckyDay
nextMonth
