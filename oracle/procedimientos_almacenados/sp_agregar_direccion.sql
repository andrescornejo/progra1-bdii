/*
Procedimiento almacenado: sp_agregar_direccion

Descripcion: Procedimiento que inserta una fila a la tabla Direccion.
Esta entrada a la tabla direccion inserta los datos sin especificar,
para que el usuario cliente inserte la informacion correcta luego.

Entradas: 
- FK de persona, number

Roles autorizados:
- Administrador

Autor: Andres Cornejo
*/

create or replace procedure sp_agregar_direccion(
    in_username in VARCHAR2,
    in_pais         in VARCHAR2,
    in_provincia    in VARCHAR2,
    in_canton       in VARCHAR2,
    in_distrito     in Varchar2,
    out_inserted_id out number 
)
is
    errcode     number;
    errmsg      varchar2(200);
    not_spec    varchar2(20) := 'No especificado';
    var_person_id NUMBER;
    var_user_id number;
begin

    select u.usuario_id 
    into var_user_id
    from usuario u
    where u.username = in_username;

    select u.persona_fk
    into var_person_id
    from usuario u
    where u.usuario_id = var_user_id;

    insert into direccion(persona_fk, descripcion, distrito,
                            canton, provincia, pais, is_deleted)
    values(var_person_id, not_spec, in_distrito, 
            in_canton, in_provincia, in_pais, 0)
    returning direccion_id into out_inserted_id; 
    commit;
    dbms_output.put_line('Se inserto una direccion a la tabla Direccion.');

exception
    when others then
    errcode := SQLCODE;
    errmsg := SQLERRM;
    dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
    rollback;
end;
