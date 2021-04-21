/*
Procedimiento almacenado: sp_get_subcategoria_id

Descripcion: Retorna el numero de id de una subcategoria a partir de su nombre.

Entradas: 
nombre de la subcategoria, varchar2

Roles autorizados:
administrador
cliente

Autor: Andres Cornejo
*/

create or replace procedure sp_get_subcategoria_id(
    in_nombre_subcat in varchar2,
    out_selected_id out number
)
is
    errcode     number;
    errmsg      varchar2(200);
begin

select sca.subcategoria_id into out_selected_id 
from subcategoria sca where sca.nombre = in_nombre_subcat;

exception
    when no_data_found then
        dbms_output.put_line('ERROR: No se pudo encontrar una categoria con ese nombre.');
        out_selected_id := -1;
        rollback;
    when others then
        errcode := SQLCODE;
        errmsg := SQLERRM;
        dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
        rollback;
end;
