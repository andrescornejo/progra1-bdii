/*
Procedimiento almacenado: sp_crear_email

Descripcion: Procedimiento que inserta una fila a la tabla email.

Entradas: 
- correo electronico, varchar2

Roles autorizados:
- Administrador

Autor: Andres Cornejo
*/

create or replace procedure sp_crear_email(
    in_emailaddr    in varchar2,
    out_inserted_id out number
)
is
    errcode     number;
    errmsg      varchar2(200);
    does_exist  number;
begin
    /* Como cada usuario solo puede tener un email, hay que hacer una verificacion, 
     * para ver si el registro ya existe.
     */
    select case 
                when exists (select 1 
                            from email
                            where email.email_address = in_emailaddr and is_deleted = 0) 
                then 1 
                else 0 
            end into does_exist 
    from dual;

    if does_exist = 0 then
        insert into email(email_address, is_deleted)
        values(in_emailaddr, 0)
        returning email_id into out_inserted_id;
        -- dbms_output.put_line(out_inserted_id); --Imprimir el id (para debug)
        commit;
        dbms_output.put_line('Se inserto ' || in_emailaddr || ' a la tabla Email.');
    else
        RAISE_APPLICATION_ERROR(-20000, 'ERROR - Ya existe esa entrada en la tabla EMAIL.');
    end if;

exception
    when others then
    errcode := SQLCODE;
    errmsg := SQLERRM;
    dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
    rollback;
end;
