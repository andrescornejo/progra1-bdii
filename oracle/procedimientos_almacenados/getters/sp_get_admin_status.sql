/*
Procedimiento almacenado: sp_get_admin_status

Descripcion: Retorn si un usuario es admin o no

Entradas: 
nombre de usuario

Roles autorizados:


Autor: Andres Cornejo
*/

create or replace procedure sp_get_admin_status(
    in_username in varchar2,
    out_status out number
)
is
    errcode     number;
    errmsg      varchar2(200);
    does_exist number;
    var_user_id number;
begin

    select u.usuario_id 
    into var_user_id
    from usuario u 
    where u.username = in_username;

    select case 
                when exists (select 1 
                            from administrador ad
                            where ad.usuario_fk = var_user_id and ad.is_deleted = 0) 
                then 1 
                else 0 
            end into does_exist 
    from dual;

    out_status := does_exist;

exception
    when no_data_found then
        dbms_output.put_line('El usuario ingresado no es administrado o no existe.');
        out_status := -1;
        rollback;
    when others then
        errcode := SQLCODE;
        errmsg := SQLERRM;
        dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
        rollback;
end;
