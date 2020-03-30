#!/bin/bash 
#constants
declare isSnake=1
declare isLadder=2
declare limit=100 #change this to check with smaller value
declare playerOne=1
declare playerTwo=2

#variables
declare -a isWon
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
	else
		currentPosition=${positionOfSecond[diceOfSecond]}
		((diceOfSecond++))
	fi
	option=$( getOption )
	case $option in
		$isSnake)
			newPosition=$(($currentPosition-$dice))
			if [ $currentPlayer -eq 1 ]
			then
				if [ $newPosition -ge 0 ]
				then
					positionOfFirst[diceOfFirst]=$newPosition
				else
					positionOfFirst[diceOfFirst]=0
				fi
			else
				if [ $newPosition -ge 0 ]
				then
					positionOfSecond[diceOfSecond]=$newPosition
				else
					positionOfSecond[diceOfSecond]=0
				fi
			fi
			;;
		$isLadder)
			newPosition=$(($currentPosition+$dice))
			if [ $currentPlayer -eq 1 ]
			then
				if [ $newPosition -le $limit ]
				then
					positionOfFirst[diceOfFirst]=$newPosition
				else
					positionOfFirst[diceOfFirst]=$currentPosition
				fi
			else
				if [ $newPosition -le $limit ]
				then
					positionOfSecond[diceOfSecond]=$newPosition
				else
					positionOfSecond[diceOfSecond]=$currentPosition
				fi
			fi
			;;
		*)
			newPosition=$currentPosition
			if [ $currentPlayer -eq 1 ]
			then	
				positionOfFirst[diceOfFirst]=$newPosition
			else	
				positionOfSecond[diceOfSecond]=$newPosition
			fi
			;;
	esac
	checkIfWon $currentPlayer
}

function startGame() {
	isWon[$playerOne]=0
	isWon[$playerTwo]=0
	positionOfFirst[0]=0
	positionOfSecond[0]=0
	while [[ ${isWon[$playerOne]} -eq 0 && ${isWon[$playerTwo]} -eq 0 ]]
	do
		play $playerOne
		play $playerTwo	
	done
	echo player $playerOne and $playerTwo rolled dice $diceOfFirst times
	for ((l=0;l<=diceOfFirst;l++))
	do
		echo turn $l position $playerOne ${positionOfFirst[l]} position $playerTwo ${positionOfSecond[l]} 
	done
}

echo "Welcome to Snake and Ladder"
#Echo "Number of players playing"
#read players
players=2
startGame $players