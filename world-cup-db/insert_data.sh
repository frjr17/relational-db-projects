#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
# Truncating tables and Deleting them for testing purposes.
echo $($PSQL "TRUNCATE TABLE games, teams")
echo $($PSQL "DROP TABLE games")
echo $($PSQL "DROP TABLE teams")


# Connecting worldcup db
echo $($PSQL "\c worldcup")

# Creating teams and games tables
echo $($PSQL "CREATE TABLE teams()")
echo $($PSQL "CREATE TABLE games()")


# Adding teams columns
echo $($PSQL "ALTER TABLE teams ADD COLUMN team_id SERIAL PRIMARY KEY NOT NULL")
echo $($PSQL "ALTER TABLE teams ADD COLUMN name VARCHAR(60) UNIQUE NOT NULL")

# Adding games column
echo $($PSQL "ALTER TABLE games ADD COLUMN game_id SERIAL PRIMARY KEY NOT NULL")
echo $($PSQL "ALTER TABLE games ADD COLUMN year INT NOT NULL")
echo $($PSQL "ALTER TABLE games ADD COLUMN round VARCHAR(60) NOT NULL")
echo $($PSQL "ALTER TABLE games ADD COLUMN winner_id INT NOT NULL")
echo $($PSQL "ALTER TABLE games ADD COLUMN opponent_id INT NOT NULL")
echo $($PSQL "ALTER TABLE games ADD COLUMN winner_goals INT NOT NULL")
echo $($PSQL "ALTER TABLE games ADD COLUMN opponent_goals INT NOT NULL")

# Adding foreign keys to games column
echo $($PSQL "ALTER TABLE games ADD FOREIGN KEY (winner_id) REFERENCES teams(team_id)")
echo $($PSQL "ALTER TABLE games ADD FOREIGN KEY (opponent_id) REFERENCES teams(team_id)")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  # Verifying if WINNER is in teams db already
  DB_WINNER=$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")

  if [[ -z $DB_WINNER ]] && [[ $WINNER != 'winner' ]]
  then
    # Adding each team to teams column
    echo $($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
  fi

  # Verifying if OPPONENT is in teams db already
  DB_OPPONENT=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")

  if [[ -z $DB_OPPONENT ]] && [[ $OPPONENT != 'opponent' ]]
  then
    # Adding each team to teams column
    echo $($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
  fi

  # Finding winner_id and opponent_id
  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

  # Adding games
  if [[ $WINNER != 'winner' ]]
  then
    echo $($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$WINNER_GOALS,$OPPONENT_GOALS)")
  fi
done

