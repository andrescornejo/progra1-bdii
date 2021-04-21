/*
Procedimiento almacenado: sp_crear_identificacion

Descripcion: Procedimiento que inserta una fila a la tabla Persona.

Entradas: 
- FK de identificacion, number
- Fk de email, number
- Nombre, varchar2
- Apellido, varchar2

Roles autorizados:
- Administrador

Autor: Andres Cornejo
*/

create or replace procedure sp_crear_persona(
    in_fk_identif   in number,
    in_fk_email     in number,
    in_nombre       in varchar2,
    in_apellido     in varchar2,
    out_inserted_id out number
)
is
    errcode number;
    errmsg  varchar2(200);
begin
    insert into persona(identificacion_fk, email_fk,
                        nombre, apellido, is_deleted)
    values(in_fk_identif, in_fk_email, in_nombre, in_apellido, 0)
    returning persona_id into out_inserted_id;
    -- dbms_output.put_line(out_inserted_id); --Imprimir el id (para debug)
    commit;
    dbms_output.put_line('Se inserto ' || in_nombre || '-' || in_apellido || ' a la tabla PERSONA.');
exception
    when others then
    errcode := SQLCODE;
    errmsg := SQLERRM;
    dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
    rollback;
end;
