PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

PRINT_ELEMENT_STATEMENT(){
  if [[ -z $1 ]]
  then
    echo "I could not find that element in the database."
  else
    ELEMENT=$(echo $1 | sed 's/|/ /g') 
    read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE <<< $(echo "$ELEMENT" | awk '{print $1, $2, $3, $4, $5, $6, $7, $8}')
    echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi
}

GET_BY_ATOMIC_NUMBER(){
  ELEMENT=$($PSQL "SELECT * FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$1;")
  PRINT_ELEMENT_STATEMENT $ELEMENT    
}
GET_BY_SYMBOL(){
  ELEMENT=$($PSQL "SELECT * FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol=INITCAP('$1');")
  PRINT_ELEMENT_STATEMENT $ELEMENT    
}
GET_BY_NAME(){
  ELEMENT=$($PSQL "SELECT * FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE name=INITCAP('$1');")
  PRINT_ELEMENT_STATEMENT $ELEMENT    
}

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
  if [[ $1 =~ [0-9]+ ]]
  then
    GET_BY_ATOMIC_NUMBER $1
  elif [[ $1 =~ ^[[:alnum:]]{1,2}$ ]]
  then
    GET_BY_SYMBOL $1
  elif [[ $1 =~ [[:alnum:]]+ ]]
  then
    GET_BY_NAME $1
  fi

fi



