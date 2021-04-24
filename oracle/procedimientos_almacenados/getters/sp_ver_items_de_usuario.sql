/*
Procedimiento almacenado: sp_ver_items_de_usuario

Descripcion: Ver los items de un usuario

Entradas: 
nombre de usuario

Roles autorizados:
cliente

Autor: Andres Cornejo
*/

CREATE OR REPLACE 
PROCEDURE sp_ver_items_de_usuario(in_username in VARCHAR2, cursor_ OUT SYS_REFCURSOR)
is
    errcode     number;
    errmsg      varchar2(200);
    var_user_id number;
BEGIN
    -- Primero se selecciona el id del usuario.
    select u.usuario_id 
    into var_user_id
    from usuario u
    where u.username = in_username;
    
    OPEN cursor_ FOR
    select 
        i.nombre "nomb",
        i.descripcion "desc", 
        cat.nombre "cat",
        subcat.nombre "subcat"
    from item i
    inner join categoria cat on cat.categoria_id = i.categoria_fk
    inner join subcategoria subcat on subcat.subcategoria_id = i.subcategoria_fk
    where i.usuario_fk = var_user_id and i.is_deleted = 0;

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