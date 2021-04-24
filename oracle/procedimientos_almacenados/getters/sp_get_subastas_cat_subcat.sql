/*
Procedimiento almacenado: sp_get_subastas_cat_subcat

Descripcion: Retorna retorna las subastas activas a partir de la categoria y subcategoria

Entradas: 
nombre categoria, varchar2
nombre subcategoria, varchar2

Roles autorizados:
cliente

Autor: Andres Cornejo
*/

create or replace procedure sp_get_subastas_cat_subcat(
    in_cat_name in varchar2,
    in_subcat_name in varchar2,
    cursor_ OUT SYS_REFCURSOR
    )
is
    errcode     number;
    errmsg      varchar2(200);
    var_cat_id  number;
    var_subcat_id number;
begin

    select cat.categoria_id
    into var_cat_id
    from categoria cat
    where cat.nombre = in_cat_name;

    select scat.subcategoria_id
    into var_subcat_id
    from subcategoria scat
    where scat.nombre = in_subcat_name;

    OPEN cursor_ FOR
    select 
        sub.nombre "nomb",
        i.nombre "item",
        sub.descripcion "desc",
        u.username "vend",
        TO_CHAR(sub.fecha_inicio, 'DD-MM-YYYY "a las" HH24:MI') "finit",
        TO_CHAR(sub.fecha_fin, 'DD-MM-YYYY "a las" HH24:MI') "ffin",
        sub.valor_inicial "vinit",
        sub.valor_actual "vact"

    from subasta sub
    inner join usuario u on u.usuario_id = sub.usuario_vendedor_fk 
    inner join item i on i.item_id = sub.item_fk
    where i.categoria_fk = var_cat_id and i.subcategoria_fk = var_subcat_id and sub.es_activa = 1
    order by sub.fecha_fin asc;

exception
    when no_data_found then
        dbms_output.put_line('ERROR: Los nombres ingresados son invalidos.');
        rollback;
    when others then
        errcode := SQLCODE;
        errmsg := SQLERRM;
        dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
        rollback;
end;
