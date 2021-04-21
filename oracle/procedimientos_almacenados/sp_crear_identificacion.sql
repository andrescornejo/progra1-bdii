/*
Procedimiento almacenado: sp_crear_identificacion

Descripcion: Procedimiento que inserta una fila a la tabla Identificacion.

Entradas: 
- numero de identificacion, varchar2
- FK de el tipo de identificacion, number

Roles autorizados:
- Administrador

Autor: Andres Cornejo
*/

create or replace procedure sp_crear_identificacion(
    in_numero_identif   in varchar2,
    in_id_tipo_identif  in number,
    out_inserted_id     out number
)
is
    errcode     number;
    errmsg      varchar2(200);
    does_exist  number;
begin
    /* Como cada usuario solo puede tener una identificacion, hay que hacer una verificacion, 
     * para ver si el registro ya existe.
     */
    select case 
                when exists (select 1 
                            from identificacion i
                            where i.descripcion = in_numero_identif and is_deleted = 0) 
                then 1 
                else 0 
            end into does_exist 
    from dual;

    if does_exist = 0 then
        insert into identificacion(tipo_ident_fk, descripcion, is_deleted)
        values(in_id_tipo_identif, in_numero_identif, 0)
        returning identificacion_id into out_inserted_id; 
        -- dbms_output.put_line(out_inserted_id); --Imprimir el id (para debug)
        commit;
        dbms_output.put_line('Se inserto la identificacion ' || in_numero_identif || ' a la tabla IDENTIFICACION.');
    else
        RAISE_APPLICATION_ERROR(-20000, 'ERROR - Ya existe esa entrada en la tabla IDENTIFICACION.');
    end if;
exception
    when others then
    errcode := SQLCODE;
    errmsg := SQLERRM;
    dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
    rollback;
end;
