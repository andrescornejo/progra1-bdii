/*
Procedimiento almacenado: sp_ver_pujas_de_subasta

Descripcion: Ver los items de un usuario

Entradas: 
nombre de usuario

Roles autorizados:
cliente

Autor: Andres Cornejo
*/

CREATE OR REPLACE 
PROCEDURE sp_ver_pujas_de_subasta(
    in_subasta_nombre in VARCHAR2, 
    cursor_ OUT SYS_REFCURSOR
    )
is
    errcode     number;
    errmsg      varchar2(200);
    var_subasta_id number;
BEGIN
    -- Primero se selecciona el id del usuario.
    select sub.subasta_id
    into var_subasta_id
    from subasta sub
    where sub.nombre = in_subasta_nombre;
    
    OPEN cursor_ FOR
    select 
        sub.nombre "nomb_sub",
        p.monto "monto",
        TO_CHAR(p.fecha_y_tiempo, 'DD-MM-YYYY "a las" HH24:MI') "fecha",
        u.username "user"

    from puja p
    inner join subasta sub on sub.subasta_id = p.subasta_fk
    inner join usuario u on u.usuario_id = usuario_comprador_fk
    where p.subasta_fk = var_subasta_id and p.is_deleted = 0
    order by p.fecha_y_tiempo asc;

exception
    when no_data_found then
        dbms_output.put_line('ERROR: Valores ingresado invalidos.');
        rollback;
    when others then
        errcode := SQLCODE;
        errmsg := SQLERRM;
        dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
        rollback;
END;