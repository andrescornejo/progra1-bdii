/*Tablas autorizadas para los administradores*/

grant connect to administrador_sistema;

grant create session to administrador_sistema;

grant create user to administrador_sistema;

grant select, insert ,update 
on system.email -- En este caso system es el schema.
to administrador_sistema;

grant select, insert ,update 
on system.tipo_identificacion
to administrador_sistema;

grant select, insert ,update 
on system.identificacion
to administrador_sistema;

grant select, insert ,update 
on system.persona
to administrador_sistema;

grant select, insert ,update 
on system.direccion
to administrador_sistema;

grant select, insert ,update 
on system.telefono
to administrador_sistema;

grant select, insert ,update 
on system.usuario
to administrador_sistema;

grant select, insert ,update 
on system.administrador
to administrador_sistema;

grant select, insert ,update 
on system.comentario
to administrador_sistema;

grant select, insert ,update 
on system.categoria
to administrador_sistema;

grant select, insert ,update 
on system.subcategoria
to administrador_sistema;

grant select, insert ,update 
on system.item
to administrador_sistema;

grant select, insert ,update 
on system.valores
to administrador_sistema;

grant select, insert ,update 
on system.subasta
to administrador_sistema;

grant select, insert ,update 
on system.puja
to administrador_sistema;

/*Tablas autorizadas para los clientes*/
grant insert, update
on system.telefono
to cliente;

grant insert, update
on system.direccion
to cliente;

grant insert, update
on system.email
to cliente;

grant insert, update
on system.identificacion
to cliente;

grant select 
on system.tipo_identificacion
to cliente;

grant update
on system.usuario
to cliente;

grant insert, update
on system.comentario
to cliente;

grant insert, update
on system.puja
to cliente;

grant insert, update
on system.subasta
to cliente;

grant select 
on system.categoria
to cliente;

grant select 
on system.subcategoria
to cliente;
