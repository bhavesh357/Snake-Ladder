#!/bin/bash -x
#constants
declare -a positionOfFirst
#variables
declare -a isWon
declare diceOfFirst=0
function rollDice(){
	echo $(($(($RANDOM%6))+1))
}
function play() {
	dice=$( rollDice )
	if [ $1 -eq 1 ]
	then
		((diceOfFirst++))
	fi
}
function startGame() {
	for ((i=1;i<=$1;i++))
	do
		isWon[i]=0
		if [ $i -eq 1 ]
		then
			positionOfFirst[0]=0
		fi
	done

	while [ ${isWon[1]} -eq 0 ]
	do
		for ((j=1;j<=$1;j++))
		do
			play $j
		done	
	done
}

echo "Welcome to Snake and Ladder"
#Echo "Number of players playing"
#read players
players=1
startGame $players
