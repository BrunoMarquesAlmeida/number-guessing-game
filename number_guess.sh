#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

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

echo $USERNAME $RANDOM $USER $INSERT_USER_RESULT