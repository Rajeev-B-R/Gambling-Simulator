#!/bin/bash -x

stake=100
bet=1
result=$(( RANDOM%2 ))

if [ $result -eq 1 ]
then
	stake=$((stake+bet))
else
	stake=$((stake-bet))
fi 
