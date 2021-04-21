/*
Procedimiento almacenado: sp_get_valores_id

Descripcion: Retorna el numero de id de la fila que contiene los valores para calcular
             los incrementos de precio por puja en cada subasta.

Entradas: 
no tiene

Roles autorizados:
administrador
cliente

Autor: Andres Cornejo
*/

create or replace procedure sp_get_valores_id(
    out_selected_id out number
)
is
    errcode     number;
    errmsg      varchar2(200);
begin

        select v.valores_id into out_selected_id
        from VALORES v where rownum = 1;

exception
    when no_data_found then
        dbms_output.put_line('ERROR: La tabla VALORES esta en un estado invalido.');
        out_selected_id := -1;
        rollback;
    when others then
        errcode := SQLCODE;
        errmsg := SQLERRM;
        dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
        rollback;
end;
