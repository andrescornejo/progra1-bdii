/*
Procedimiento almacenado: sp_editar_telefono

Descripcion: Procedimiento que inserta una fila a la tabla Direccion.
Esta entrada a la tabla direccion inserta los datos sin especificar,
para que el usuario cliente inserte la informacion correcta luego.

Entradas: 
- FK de persona, number

Roles autorizados:
- Administrador

Autor: Andres Cornejo
*/

create or replace procedure sp_editar_telefono(
    in_username in NVARCHAR2,
    in_numero_tel   in NVARCHAR2
)
is
    errcode     number;
    errmsg      varchar2(200);
    not_spec    varchar2(20);
    var_user_id number;
begin
    not_spec := 'No especificado';

    select u.usuario_id 
    into var_user_id
    from usuario u
    where u.username = in_username;

    update telefono
    set num_telefono = in_numero_tel
    where persona_fk = var_user_id and num_telefono = not_spec;

    commit;
    dbms_output.put_line('Se actualizo la tabla Telefono.');
exception
    when others then
    errcode := SQLCODE;
    errmsg := SQLERRM;
    dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
    rollback;
end;
