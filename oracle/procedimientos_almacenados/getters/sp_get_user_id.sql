/*
Procedimiento almacenado: sp_get_user_id

Descripcion: Retorna el numero de id de un usuario a partir de su nombre de usuario.

Entradas: 
nombre de usuario, varchar2

Roles autorizados:
administrador
cliente

Autor: Andres Cornejo
*/

create or replace procedure sp_get_user_id(
    in_username in varchar2,
    out_selected_id out number
)
is
    errcode     number;
    errmsg      varchar2(200);
begin

select u.usuario_id into out_selected_id 
from usuario u where u.username = in_username;

exception
    when no_data_found then
        dbms_output.put_line('ERROR: No se pudo encontrar un usuario con ese nombre.');
        out_selected_id := -1;
        rollback;
    when others then
        errcode := SQLCODE;
        errmsg := SQLERRM;
        dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
        rollback;
end;
