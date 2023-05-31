MAIN_MENU (){
# if message is set
  if [[ $1 ]]
  then

    # -t option to prevent  header
    # -A option to prevent spaces on output
    PSQL="psql --username=freecodecamp --dbname=periodic_table -t -A -c"

  #ELEMENTFOUND=$($PSQL "SELECT * from elements where atomic_number='$1'")
  ELEMENTFOUND=$($PSQL "select atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements join properties using (atomic_number) join types using (type_id) where cast(atomic_number AS TEXT)='$1' or symbol='$1' or name='$1'");

#echo $ELEMENTFOUND


#if is set
if [[ -z $ELEMENTFOUND ]]
then 
  echo "I could not find that element in the database."
  exit
else
  #dataset into variables
  IFS="|" read -r ATOMICNUMBER NAME SYMBOL TYPE ATOMICMASS MELTINGPOINT  BOILINGPOINT <<< "$ELEMENTFOUND"
  #$ATOMICNUMBER $NAME $SYMBOL $TYPE $ATOMICMASS $MELTINGPOINT  $BOILINGPOINT

  echo "The element with atomic number $ATOMICNUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMICMASS amu. $NAME has a melting point of $MELTINGPOINT celsius and a boiling point of $BOILINGPOINT celsius."
  
fi

  else
      #else  no parameter was set
      echo -e "Please provide an element as an argument."
      exit
  fi

}

MAIN_MENU $1
