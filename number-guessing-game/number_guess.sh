#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo -e "\n ~~~ Number Guessing Game ~~~"

echo "Enter your username:"
read USERNAME

USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
echo $USER_ID
if [[ -z $USER_ID ]]
then
  INSERT_USER_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")

  if [[ $INSERT_USER_RESULT == 'INSERT 0 1' ]]
  then

    USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
    echo "Welcome, $USERNAME! It looks like this is your first time here."
  fi
else
  GAMES_INFO=$($PSQL "SELECT COUNT(*),MIN(number_of_guesses) FROM games WHERE user_id=$USER_ID")
  GAMES_INFO=$(echo "$GAMES_INFO" | sed 's/|/ /')
  
  read GAMES_PLAYED BEST_GAME <<< $(echo "$GAMES_INFO" | awk '{print $1, $2}')

  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))
echo $SECRET_NUMBER
GUESS=0
NUMBER_OF_GUESSES=0

while [[ ! $SECRET_NUMBER == $GUESS ]]
do
  echo Guess the secret number between 1 and 1000:
  read GUESS
  
  if [[ ! $GUESS =~ [0-9]+ ]]
  then
    echo That is not an integer, guess again:
  else
    NUMBER_OF_GUESSES=$((NUMBER_OF_GUESSES+1))
    if [[ ! $SECRET_NUMBER == $GUESS ]]
    then
      if [[ $GUESS < $SECRET_NUMBER ]]
      then
        echo "It's higher than that, guess again:"
      else
        echo "It's lower than that, guess again:"
      fi
    fi
  fi

done

INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(number_of_guesses,user_id) VALUES($NUMBER_OF_GUESSES,$USER_ID)")
echo -e "\nYou guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
