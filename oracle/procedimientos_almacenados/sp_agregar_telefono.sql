/*
Procedimiento almacenado: sp_agregar_telefono

Descripcion: Procedimiento que inserta una fila a la tabla Direccion.
Esta entrada a la tabla direccion inserta los datos sin especificar,
para que el usuario cliente inserte la informacion correcta luego.

Entradas: 
- FK de persona, number

Roles autorizados:
- Administrador

Autor: Andres Cornejo
*/

create or replace procedure sp_agregar_telefono(
    in_username in NVARCHAR2,
    in_numero_tel   in NVARCHAR2,
    out_inserted_id out number
)
is
    errcode     number;
    errmsg      varchar2(200);
    not_spec    varchar2(20);
    var_user_id number;
begin

    select u.usuario_id 
    into var_user_id
    from usuario u
    where u.username = in_username;

    not_spec := 'No especificado';
    insert into telefono(persona_fk, num_telefono, descripcion, is_deleted) 
    values(var_user_id, in_numero_tel, not_spec, 0)
    returning telefono_id into out_inserted_id; 
    commit;
    dbms_output.put_line('Se inserto a la tabla Telefono.');
exception
    when others then
    errcode := SQLCODE;
    errmsg := SQLERRM;
    dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
    rollback;
end;
