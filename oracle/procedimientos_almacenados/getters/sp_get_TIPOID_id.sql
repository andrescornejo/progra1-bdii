/*
Procedimiento almacenado: sp_get_TIPOID_id

Descripcion: Retorna el numero de id de la tabla tipo identificacion.

Entradas: 
nombre del tipoID, varchar2

Roles autorizados:
administrador
cliente

Autor: Andres Cornejo
*/

create or replace procedure sp_get_TIPOID_id(
    in_nombre_tipo_id in varchar2,
    out_id out number
)
is
    errcode     number;
    errmsg      varchar2(200);
begin
    select tid.TIPO_IDENTIFICACION_ID 
        into out_id
        from TIPO_IDENTIFICACION tid
        where tid.nombre = in_nombre_tipo_id;

exception
    when no_data_found then
        dbms_output.put_line('ERROR: No se pudo encontrar un tipo de identificacion con ese nombre.');
        out_id := -1;
        rollback;
    when others then
        errcode := SQLCODE;
        errmsg := SQLERRM;
        dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
        rollback;
end;
