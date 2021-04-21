# Proc: registrar nuevo administrador
## entradas:
- nombre
- apellido
- cedula
- tipo de identificacion
- email
- username
- password

## ejecución:
- llamar al SP de crear persona
- llamar al SP de crear usuario
- conseguir el fk de usuario a partir del username
- insertar los datos a la tabla administrador
* * *
# Proc: crear una nueva persona
## entradas:
- nombre
- apellido
- cedula
- email
- tipo de identificacion

## ejecución:
- llamar al SP de crear identificacion
- Conseguir el fk de identificacion utilizando la cedula
- llamar al SP de crear email
- Conseguir el fk de email utilizando el email address.
- Crear un telefono sin datos
- Crear una direccion sin datos
- insertar los datos a la tabla persona
* * *
# Proc: crear un nuevo usuario
## entradas:
- cedula
- username
- password
 
## ejecución
- conseguir el fk de persona a partir de la cedula
- insertar los datos a la tabla usuario
* * *  
# Proc: crear un email nuevo
## entradas:
- email

## ejecución:
- insertar los datos a la tabla email

# Proc: crear una identificación nueva
## entradas:
- identificación
- tipo_identificación

## ejecución:
- Conseguir el id de tipo_identificacion a partir de el tipo de identificación dado.
- insertar los datos a la tabla.
* * *