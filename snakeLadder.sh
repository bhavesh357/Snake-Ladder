#!/bin/bash -x
#constants
declare -a positionOfFirst

#variables
declare -a isWon
declare diceOfFirst=0

#functions
function rollDice(){
	echo $(($(($RANDOM%6))+1))
}

function getOption() {
	echo $(($RANDOM%3))	
}

function play() {
	currentPlayer=$1
	dice=$( rollDice )
	if [ $currentPlayer -eq 1 ]
	then
		currentPosition=${positionOfFirst[diceOfFirst]}
		((diceOfFirst++))
	fi
	option=$( getOption )
	case $option in
		isSnake)
			newPosition=$(($currentPosition-$dice))
			positionOfFirst[diceOfFirst]=$newPosition
			;;
		isLadder)
			newPosition=$(($currentPosition+$dice))
			positionOfFirst[diceOfFirst]=$newPosition
			;;
		*)
			newPosition=$currentPosition
			positionOfFirst[diceOfFirst]=$newPosition
			;;
	esac
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