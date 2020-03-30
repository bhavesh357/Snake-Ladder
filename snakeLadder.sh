#!/bin/bash 
#constants
declare -a positionOfFirst
declare isSnake=1
declare isLadder=2
declare limit=100 #change this to check with smaller value
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

function checkIfWon() {
	winner=$1
	if [ $winner -eq 1 ]
	then
		position=${positionOfFirst[diceOfFirst]}
	fi
	if [ $position -ge $limit ]
	then
		isWon[$winner]=1
		echo player $winner has won
	fi
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
		$isSnake)
			newPosition=$(($currentPosition-$dice))
			if [ $newPosition -ge 0 ]
			then
				positionOfFirst[diceOfFirst]=$newPosition
			else
				positionOfFirst[diceOfFirst]=0
			fi
			;;
		$isLadder)
			newPosition=$(($currentPosition+$dice))
			if [ $newPosition -le $limit ]
			then
				positionOfFirst[diceOfFirst]=$newPosition
			else
				positionOfFirst[diceOfFirst]=$currentPosition
			fi
			;;
		*)
			newPosition=$currentPosition
			positionOfFirst[diceOfFirst]=$newPosition
			;;
	esac
	checkIfWon $currentPlayer
}
function startGame() {
	numberOfPlayers=$1
	for ((i=1;i<=$numberOfPlayers;i++))
	do
		isWon[$i]=0
		if [ $i -eq 1 ]
		then
			positionOfFirst[0]=0
		fi
	done
	while [ ${isWon[1]} -eq 0 ]
	do
		for ((j=1;j<=$numberOfPlayers;j++))
		do
			play $j
		done	
	done
	echo player 1 rolled dice $diceOfFirst times
	for ((l=0;l<=diceOfFirst;l++))
	do
		echo turn $l position ${positionOfFirst[l]}
	done
}

echo "Welcome to Snake and Ladder"
#Echo "Number of players playing"
#read players
players=1
startGame $players