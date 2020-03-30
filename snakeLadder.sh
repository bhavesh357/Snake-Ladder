#!/bin bash -x
#constants
declare -a positionOfFirst
#variables
declare -a isWon
declare diceOfFirst=0
function startGame() {
	for ((i=1;i<=$1;i++))
	do
		isWon[i]=0
		if [ $i -eq 1 ]
		then
			positionOfFirst[0]=0
		fi
	done
}

echo "Welcome to Snake and Ladder"
#Echo "Number of players playing"
#read players
players=1
startGame $players
