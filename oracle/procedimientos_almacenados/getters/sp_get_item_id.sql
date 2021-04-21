/*
Procedimiento almacenado: sp_get_item_id

Descripcion: Retorna el id de un item a partir del nombre. 

Entradas: 
nombre del item, varchar2

Roles autorizados:
cliente
administrador

Autor: Andres Cornejo
*/

create or replace procedure sp_get_item_id(
    in_item_nombre in varchar2,
    out_selected_id out number
)
is
    errcode     number;
    errmsg      varchar2(200);
begin

select i.item_id into out_selected_id 
from item i where i.nombre = in_item_nombre;

exception
    when no_data_found then
        dbms_output.put_line('ERROR: No se pudo encontrar un item con ese nombre.');
        out_selected_id := -1;
        rollback;
    when others then
        errcode := SQLCODE;
        errmsg := SQLERRM;
        dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
        rollback;
end;
