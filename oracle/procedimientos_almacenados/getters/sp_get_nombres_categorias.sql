/*
Procedimiento almacenado: sp_get_nombres_categorias

Descripcion: Retorna el nombre de todas las categorías

Entradas: 

Roles autorizados:
cliente

Autor: Andres Cornejo
*/

create or replace procedure sp_get_nombres_categorias(cursor_ OUT SYS_REFCURSOR)
is
    errcode     number;
    errmsg      varchar2(200);
begin

    OPEN cursor_ FOR
    select 
        cat.nombre "cat"
    from categoria cat;

exception
    when no_data_found then
        dbms_output.put_line('ERROR: No se pudo encontrar un item con ese nombre.');
        rollback;
    when others then
        errcode := SQLCODE;
        errmsg := SQLERRM;
        dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
        rollback;
end;
