#! /bin/bash

#queries for database because codeally looses progress

 # -t option to prevent  header
    PSQL="psql --username=freecodecamp --dbname=periodic_table -t -c"

   # $($PSQL "SELECT service_id, name from services")

$($PSQL "alter table properties rename column weight to atomic_mass")
$($PSQL "alter table properties rename column melting_point to melting_point_celsius")
$($PSQL "alter table properties rename column boiling_point to boiling_point_celsius")

$($PSQL "alter table properties alter column melting_point_celsius SET not Null")
$($PSQL "alter table properties alter column boiling_point_celsius SET not Null")

$($PSQL "alter table elements alter column symbol SET NOT NULL")
$($PSQL "alter table elements alter column name SET NOT NULL")


$($PSQL "ALTER TABLE elements ADD UNIQUE (symbol)")
$($PSQL "ALTER TABLE elements ADD UNIQUE (name)")

#$($PSQL "alter table properties add FOREIGN KEY ")
$($PSQL "alter table properties add constraint fk_atomicNumber foreign key(atomic_number) references elements(atomic_number)")


$($PSQL "create table types(type_id SERIAL primary key, type VARCHAR(30) NOT NULL)")
$($PSQL "insert into types (type) values ('metal'),('metalloid'),('nonmetal')")



#//erstellen aber noch nicht NOT NULL setzen (weil nicht möglich)
$($PSQL "ALTER TABLE properties ADD COLUMN type_id INT REFERENCES types(type_id)")


#//update der type id werte für type id. 
$($PSQL "update properties set type_id = (select type_id from types where type = properties.type)")


#//not null Bedingung einfügen
$($PSQL "alter table properties alter column type_id SET NOT NULL")

#//erstes zeichen Großbuchstabe
$($PSQL "update elements set symbol=upper(substring(symbol from 1 for 1))|| substring (symbol from 2)")


# //remove trailing zeros
$($PSQL "alter table properties alter column atomic_mass TYPE DECIMAL;")
$($PSQL "update properties set atomic_mass=atomic_mass::REAL")


#//remove type column
$($PSQL "alter table properties drop column type")

#//add Elements
$($PSQL "insert into elements(atomic_number, symbol, name) values (9,'F','Fluorine'),(10,'Ne', 'Neon')")
$($PSQL "insert into properties(atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) values (9,18.998,-220,-188.1,3),(10,20.18,-248.6,-246.1,3)")

echo "Achtung noch element mit 1000 entfernen"
$($PSQL "delete from properties where atomic_number =1000;")
$($PSQL "delete from elements where atomic_number =1000;")
