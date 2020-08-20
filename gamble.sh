#!/bin/bash -x

stake=100
bet=1
max=$(( $stake + $(( ($stake*50)/100)) ));
min=$((  $stake - $(( ($stake*50)/100)) ));

while [ $stake -gt $min ] && [ $stake -lt $max ]
do
	result=$(( RANDOM%2 ))
	if [ $result -eq 1 ]
	then
		stake=$((stake + bet))
	else
		stake=$((stake - bet))
	fi
done

echo "That's all for today. Resigning..."
