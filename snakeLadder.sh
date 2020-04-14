#!/bin/bash 
#constants
declare isSnake=1
declare isLadder=2
declare limit=10 #change this to check with smaller value
declare playerOne=1
declare playerTwo=2

#variables
isWon=0
declare -a positionOfFirst
declare diceOfFirst=0
declare -a positionOfSecond
declare diceOfSecond=0

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
	else
		position=${positionOfSecond[diceOfSecond]}
	fi
	if [ $position -ge $limit ]
	then
		isWon=$winner
		echo player $winner has won
	fi
}

function doOption() {
	comp=$1
	updatePosition=$2
	if [ $currentPlayer -eq 1 ]
	then
		if [ $newPosition -ge $comp ]
		then
			positionOfFirst[diceOfFirst]=$newPosition
		else
			positionOfFirst[diceOfFirst]=$updatePosition
		fi
	else
		if [ $newPosition -ge $comp ]
		then
			positionOfSecond[diceOfSecond]=$newPosition
		else
			positionOfSecond[diceOfSecond]=$updatePosition
		fi
	fi
}

function play() {
	currentPlayer=$1
	dice=$( rollDice )
	if [ $currentPlayer -eq 1 ]
	then
		currentPosition=${positionOfFirst[diceOfFirst]}
		((diceOfFirst++))
	else
		currentPosition=${positionOfSecond[diceOfSecond]}
		((diceOfSecond++))
	fi
	option=$( getOption )
	case $option in
		$isSnake)
			newPosition=$(($currentPosition-$dice))
			doOption 0 0
			;;
		$isLadder)
			newPosition=$(($currentPosition+$dice))
			doOption $limit $newPosition
			;;
		*)
			newPosition=$currentPosition
			doOption $newPosition $newPosition
			;;
	esac
	checkIfWon $currentPlayer
}

function startGame() {
	isWon[$playerOne]=0
	isWon[$playerTwo]=0
	positionOfFirst[0]=0
	positionOfSecond[0]=0
	while [[ isWon -eq 0 ]]
	do
		play $playerOne
		play $playerTwo	
	done
	echo player $playerOne and $playerTwo rolled dice $diceOfFirst times
	for ((l=0;l<=diceOfFirst;l++))
	do
		echo turn $l position of player $playerOne is ${positionOfFirst[l]} position of player $playerTwo is ${positionOfSecond[l]} 
	done
}

echo "Welcome to Snake and Ladder"

startGame