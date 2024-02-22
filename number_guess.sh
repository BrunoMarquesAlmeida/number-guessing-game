#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
RANDOM_NUMBER=$((1 + $RANDOM % 1000))
NUMBER_TRIES=1

PLAY_GAME(){
  read SELECTED_NUMBER
  
  echo $SELECTED_NUMBER $RANDOM_NUMBER
  INT_RE='^[0-9]+$'
  if [[ $SELECTED_NUMBER =~ $INT_RE ]]
  then
    if [[ $SELECTED_NUMBER -eq $RANDOM_NUMBER ]]
    then
      echo -e "\nYou guessed it in $NUMBER_TRIES tries. The secret number was $RANDOM_NUMBER. Nice job!"
    else
      if [[ $SELECTED_NUMBER -gt $RANDOM_NUMBER ]]
      then
      echo -e "\nIt's lower than that, guess again:"
      let NUMBER_TRIES++
      PLAY_GAME
      else
      echo -e "\nIt's higher than that, guess again:"
      let NUMBER_TRIES++
      PLAY_GAME
      fi
    fi
  else
    echo -e "\nThat is not an integer, guess again:"
    PLAY_GAME
  fi    
}

echo -e "\nEnter you username:"
read USERNAME

USER=$($PSQL "SELECT username FROM users WHERE username='$USERNAME'")

if [[ -z $USER ]]
then
  INSERT_USER_RESULT=$($PSQL "INSERT INTO users(username) VALUES ('$USERNAME')")
  USER=$($PSQL "SELECT username FROM users WHERE username='$USERNAME'")

  echo -e "\nWelcome, $USER! It looks like this is your first time here."
else
 echo -e "\nWelcome back, <username>! You have played <games_played> games, and your best game took <best_game> guesses."
fi

echo -e "\nGuess the secret number between 1 and 1000:"
PLAY_GAME

