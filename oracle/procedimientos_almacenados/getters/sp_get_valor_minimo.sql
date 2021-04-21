/*
Procedimiento almacenado: sp_get_valor_minimo

Descripcion: Retorna el valor minimo para poder hacer una puja.

Entradas: 
no tiene

Roles autorizados:
administrador
cliente

Autor: Andres Cornejo
*/

create or replace procedure sp_get_valor_minimo(
    in_subasta_id   number,
    out_valor_min out number
)
is
    errcode     number;
    errmsg      varchar2(200);
    var_valor_actual number(10,4);
    var_tmp_valor number(10,4);
    var_inc_min number(10,4);
    var_porc_mejora float;
begin

    -- Seleccionar el porcentaje del mejora.
    select v.porcentaje_mejora
    into var_porc_mejora
    from valores v
    where rownum = 1;

    -- Seleccionar el incremento minimo.
    select v.incremento_minimo
    into var_inc_min
    from valores v
    where rownum = 1;

    -- Seleccionar la puja maxima de la subasta.
    select s.valor_actual 
    into var_valor_actual 
    from subasta s
    where s.subasta_id = in_subasta_id;

    var_tmp_valor := var_valor_actual  * var_porc_mejora;
    dbms_output.put_line('Valor minimo: '||var_tmp_valor);

    if var_tmp_valor > var_inc_min then
        out_valor_min := var_tmp_valor + var_valor_actual;
    else
        out_valor_min := var_inc_min + var_valor_actual;
    end if;

exception
    when no_data_found then
        dbms_output.put_line('ERROR: Valores ingresado invalidos.');
        out_valor_min := -1;
        rollback;
    when others then
        errcode := SQLCODE;
        errmsg := SQLERRM;
        dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
        rollback;
end;
