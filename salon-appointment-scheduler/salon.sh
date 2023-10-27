#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

MAIN_MENU(){
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  SERVICES=$($PSQL "SELECT service_id,name FROM services")
  echo "$SERVICES" | while read SERVICE_ID BAR NAME
  do
    echo "$SERVICE_ID) $NAME"
  done

  echo "What kind of service do you want?"
  read SERVICE_ID_SELECTED

  SERVICE_SELECTED=$($PSQL "SELECT service_id,name FROM services WHERE service_id='$SERVICE_ID_SELECTED'")

  if [[ -z $SERVICE_SELECTED ]]
  then
    MAIN_MENU 'Please enter a valid service'
  else
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE

    FIND_CUSTOMER_RESULT=$($PSQL "SELECT name,phone FROM customers WHERE phone='$CUSTOMER_PHONE'")
    if [[ -z $FIND_CUSTOMER_RESULT ]]
    then
      echo -e "\nWhat's your name"
      read CUSTOMER_NAME

      INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name,phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
    else
      CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
      CUSTOMER_NAME=$(echo "$CUSTOMER_NAME" | sed 's/ //g')
    fi

    echo -e "\nIn what time do you want the service."
    read SERVICE_TIME

    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
    SERVICE_NAME=$(echo $SERVICE_NAME | sed 's/^ | $*//g')
    INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(service_id,customer_id,time) VALUES($SERVICE_ID_SELECTED,$CUSTOMER_ID,'$SERVICE_TIME')")

    if [[ $INSERT_APPOINTMENT_RESULT == 'INSERT 0 1' ]]
    then
      echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
    fi
  fi
}


MAIN_MENU

