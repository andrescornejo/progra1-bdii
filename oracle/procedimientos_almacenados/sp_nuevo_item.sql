/*
Procedimiento almacenado: sp_nuevo_item

Descripcion: Procedimiento almacenado para agregar un item a la base de datos.

Entradas: 
fk de usuario, number
fk de categoria, number
fk de subcategoria, number
nombre del producto, varchar2
descripcion del productos, varchar2

Roles autorizados:
cliente

Autor: Andres Cornejo
*/

create or replace procedure sp_nuevo_item(
    in_usuario          in varchar2,
    in_categoria        in varchar2,
    in_subcategoria     in varchar2,
    in_nombre_item      in varchar2,
    in_descripcion         in varchar2
    --out_inserted_id out number
)
is
    errcode             number;
    errmsg              varchar2(200);
    does_exist          number;
    var_usuario_id      number;
    var_categoria_id    number;
    var_subcategoria_id number;
begin
    -- Primero verificar si no existe un item con el mismo nombre.
    select case 
                when exists (select 1 
                            from item i
                            where i.nombre = in_nombre_item and is_deleted = 0) 
                then 1 
                else 0 
            end into does_exist 
    from dual;

    if does_exist = 0 then
        -- Conseguir el id del usuario.
        SP_GET_USER_ID(IN_USERNAME  => in_usuario /*IN VARCHAR2*/,
                    OUT_SELECTED_ID  => var_usuario_id /*OUT NUMBER*/);

        if var_usuario_id = -1 then
            RAISE_APPLICATION_ERROR(-20000, 'ERROR: No existe un usuario con ese nombre.');
        end if;

        -- Conseguir el id de la categoria.
        SP_GET_CATEGORIA_ID(IN_NOMBRE_CAT  => in_categoria /*IN VARCHAR2*/,
                            OUT_SELECTED_ID  => var_categoria_id /*OUT NUMBER*/);

        if var_categoria_id = -1 then
            RAISE_APPLICATION_ERROR(-20000, 'ERROR: No existe una categoria con ese nombre.');
        end if;

        -- Conseguir el id de la subcategoria.
        SP_GET_SUBCATEGORIA_ID(IN_NOMBRE_SUBCAT  => in_subcategoria /*IN VARCHAR2*/,
                               OUT_SELECTED_ID  => var_subcategoria_id /*OUT NUMBER*/);

        if var_subcategoria_id = -1 then
            RAISE_APPLICATION_ERROR(-20000, 'ERROR: No existe una subcategoria con ese nombre.');
        end if;

        -- Insertar a la tabla item.
        insert into item(usuario_fk, categoria_fk, subcategoria_fk,
                            nombre, descripcion, is_deleted)
        values(var_usuario_id, var_categoria_id, var_subcategoria_id,
                in_nombre_item, in_descripcion, 0);
    else
        RAISE_APPLICATION_ERROR(-20000, 'ERROR: Ya existe un producto con el mismo nombre.');
    end if;

    commit;

exception
    when others then
        errcode := SQLCODE;
        errmsg := SQLERRM;
        dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
        rollback;
end;
