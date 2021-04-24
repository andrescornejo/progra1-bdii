/*
Procedimiento almacenado: sp_get_nombres_subcategorias

Descripcion: Retorna el nombre de todas las subcategorías a partir del nombre de una categoria

Entradas: 
nombre de categoria, varchar2

Roles autorizados:
cliente

Autor: Andres Cornejo
*/

create or replace procedure sp_get_nombres_subcategorias(
    in_nombre_cat in VARCHAR2,
    cursor_ OUT SYS_REFCURSOR
    )
is
    errcode     number;
    errmsg      varchar2(200);
    var_cat_id  number;
begin

    select cat.categoria_id 
    into var_cat_id
    from categoria cat
    where cat.nombre = in_nombre_cat;

    OPEN cursor_ FOR
    select 
        subcat.nombre "subcat"
    from subcategoria subcat
    where subcat.categoria_fk = var_cat_id;

exception
    when no_data_found then
        dbms_output.put_line('ERROR: Entrada invalida.');
        rollback;
    when others then
        errcode := SQLCODE;
        errmsg := SQLERRM;
        dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
        rollback;
end;
