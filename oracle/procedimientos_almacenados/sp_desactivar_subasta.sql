/*
Procedimiento almacenado: sp_desactivar_subasta

Descripcion: Desactiva una subasta si ya pasó su plazo de actividad. 
Este SP es para ser usado con un job.

Entradas: 

Roles autorizados:

Autor: Andres Cornejo
*/

create or replace procedure sp_desactivar_subasta
is
    errcode     number;
    errmsg      varchar2(200);
    var_current_time    TIMESTAMP(2);
begin

select Systimestamp(2) into var_current_time from dual;

update subasta
set es_activa = 0
where fecha_fin < var_current_time;

exception
    when others then
    errcode := SQLCODE;
    errmsg := SQLERRM;
    dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
    rollback;
end;
