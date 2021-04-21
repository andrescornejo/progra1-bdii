/*
Procedimiento almacenado: sp_nueva_subasta

Descripcion: Inserta una nueva subasta a la base de datos.

Entradas: 
nombre del item, varchar2
nombre del usuario vendedor, varchar2
nombre de la subasta, varchar2
descripcion de la subasta, varchar2
cantidad de días para la subasta, number
valor inicial de la subasta, number 
detalles del envio, varchar2 

Roles autorizados:

Autor: Andres Cornejo
*/

create or replace procedure sp_nueva_subasta(
    in_nombre_item in varchar2,
    in_nombre_usuario in varchar2,
    in_nombre_subasta in varchar2,
    in_desc_subasta in varchar2,
    in_cant_dias in number,
    in_valor_inicial in number,
    in_detalles_envio in varchar2
    -- out_inserted_id out number
)
is
    errcode     number;
    errmsg      varchar2(200);
    does_exist  number;
    var_user_id number;
    var_item_id number;
    var_cmt_vend_id number;
    var_valores_id  number;
    var_days varchar2(2000) := TO_CHAR(in_cant_dias);
begin
    -- Primero verificar que no exista una tabla con el mismo nombre.
    select case 
                when exists (select 1 
                            from subasta s
                            where s.nombre = in_nombre_subasta and is_deleted = 0) 
                then 1 
                else 0 
            end into does_exist 
    from dual;

    if does_exist = 0 then

        -- Conseguir el id del usuario.
        SP_GET_USER_ID(IN_USERNAME  => in_nombre_usuario /*IN VARCHAR2*/,
                       OUT_SELECTED_ID  => var_user_id /*OUT NUMBER*/);

        if var_user_id = -1 then
            RAISE_APPLICATION_ERROR(-20000, 'ERROR: Usuario ingresado es invalido.');
        end if;

        -- Conseguir el id del item a ser subastado.
        SP_GET_ITEM_ID(IN_ITEM_NOMBRE  => in_nombre_item /*IN VARCHAR2*/,
                       OUT_SELECTED_ID  => var_item_id /*OUT NUMBER*/);

        if var_item_id = -1 then
            RAISE_APPLICATION_ERROR(-20000, 'ERROR: Item ingresado es invalido.');
        end if;

        -- Crear el comentario del vendedor.
        SP_CREAR_COMENTARIO(IN_USER_ID  => var_user_id /*IN NUMBER*/,
                            IN_COMMENT  => '-' /*IN VARCHAR2*/,
                            IN_RATING  => 0 /*IN FLOAT(126)*/,
                            OUT_INSERTED_ID  => var_cmt_vend_id /*OUT NUMBER*/);

        -- Conseguir el id de la tabla valores.
        SP_GET_VALORES_ID(OUT_SELECTED_ID  => var_valores_id /*OUT NUMBER*/);

        if var_valores_id = -1 then
            RAISE_APPLICATION_ERROR(-20000, 'ERROR: La tabla valores es incorrecta.');
        end if;

        insert into subasta(item_fk, comentario_vendedor_fk, usuario_vendedor_fk,
                            valores_fk, nombre, descripcion, fecha_inicio, fecha_fin,
                            valor_inicial, valor_actual, detalles_de_envio, 
                            es_activa, is_deleted)
        values(
            var_item_id,
            var_cmt_vend_id,
            var_user_id,
            var_valores_id,
            in_nombre_subasta,
            in_desc_subasta,
            (select Systimestamp(2) from dual), 
            (select Systimestamp(2) + NUMTODSINTERVAL(var_days, 'day') from dual),
            in_valor_inicial, -- Valor inicial
            in_valor_inicial, -- Valor actual
            in_detalles_envio,
            1,
            0
            );
        
        commit;

    else
        RAISE_APPLICATION_ERROR(-20000, 'ERROR: Ya existe una subasta con el mismo nombre.');
    end if;


exception
    when others then
    errcode := SQLCODE;
    errmsg := SQLERRM;
    dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
    rollback;
end;
