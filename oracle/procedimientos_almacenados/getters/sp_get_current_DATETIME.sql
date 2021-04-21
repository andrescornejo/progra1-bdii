/*
Procedimiento almacenado: sp_get_current_DATETIME 
Descripcion: 

Entradas: 

Roles autorizados:

Autor: Andres Cornejo
*/

create or replace procedure sp_get_current_DATETIME(
    -- in_emailaddr    in varchar2,
    out_date out varchar2;
)
is
    errcode     number;
    errmsg      varchar2(200);
begin

    SELECT TO_CHAR
    (SYSDATE, 'YYYY-MM-DD HH24:MI:SS') "TODAY"
    into out_date
    FROM DUAL; 

exception
    when others then
    errcode := SQLCODE;
    errmsg := SQLERRM;
    dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
    rollback;
end;
