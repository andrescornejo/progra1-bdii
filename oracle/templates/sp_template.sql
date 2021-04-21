/*
Procedimiento almacenado: sp_name

Descripcion: 

Entradas: 

Roles autorizados:

Autor: Andres Cornejo
*/

create or replace procedure sp_name(
    -- in_emailaddr    in varchar2,
    -- out_inserted_id out number
)
is
    errcode     number;
    errmsg      varchar2(200);
begin



exception
    when others then
    errcode := SQLCODE;
    errmsg := SQLERRM;
    dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
    rollback;
end;
