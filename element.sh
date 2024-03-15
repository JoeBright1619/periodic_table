PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
else
if [[ $1 =~ [0-9] ]]
then
atomicNumber=$($PSQL "select atomic_number from elements where atomic_number=$1")
else
atomicNumber=$($PSQL "select atomic_number from elements where symbol='$1' or name='$1'")
fi
if [[ ! -z $atomicNumber ]]
then
name=$($PSQL "select name from elements where atomic_number=$atomicNumber")
symbol=$($PSQL "select symbol from elements where atomic_number=$atomicNumber")
type=$($PSQL "select type from properties full join types on properties.type_id=types.type_id where atomic_number=$atomicNumber")
mass=$($PSQL "select atomic_mass from properties where atomic_number=$atomicNumber")
melting_point=$($PSQL "select melting_point_celsius from properties where atomic_number=$atomicNumber")
boiling_point=$($PSQL "select boiling_point_celsius from properties where atomic_number=$atomicNumber")
echo "The element with atomic number $atomicNumber is $name ($symbol). It's a $type, with a mass of $mass amu. $name has a melting point of $melting_point celsius and a boiling point of $boiling_point celsius."
else
echo "I could not find that element in the database."

fi
fi