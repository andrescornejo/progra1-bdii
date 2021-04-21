/*
Vista: view_get_user_data

Descripcion: Hace un join de multiples tablas para ver la informacion de un usuario

Roles autorizados:
administrador

Autor: Andres Cornejo
*/

create or replace view datos_de_usuarios as
select 

   u.username "Usuario",
   p.nombre "Nombre",
   p.apellido "Apellido",
   e.email_address "Correo electronico",
   tid.nombre "Tipo de Identificacion",
   i.descripcion "Identificacion"
    
from usuario u 
inner join persona p on u.persona_fk = p.persona_id
inner join identificacion i on p.identificacion_fk = i.identificacion_id
inner join tipo_identificacion tid on i.tipo_ident_fk = tid.tipo_identificacion_id
inner join email e on p.email_fk = e.email_id
order by u.username
with read only;
