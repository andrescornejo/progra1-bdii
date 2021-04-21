/*
Procedimiento almacenado: sp_nueva_puja

Descripcion: Inserta una nueva puja a una subasta.

Entradas: 
nombre de subasta, varchar2.
nombre de usuario comprador, varchar2.
monto, number.

Roles autorizados:
cliente

Autor: Andres Cornejo
*/

create or replace procedure sp_nueva_puja(
    in_subasta_nombre in varchar2,
    in_username         in varchar2,
    in_monto   in number
    -- out_inserted_id out number
)
is
    errcode     number;
    errmsg      varchar2(200);
    var_subasta_id number;
    var_es_activa number;
    var_usuario_id number;
    var_valor_minimo number(10,4);
begin
    -- Conseguir el id de la subasta.
    SP_GET_SUBASTA_ID(IN_NOMBRE_SUBASTA  => in_subasta_nombre /*IN VARCHAR2*/,
                      OUT_SELECTED_ID  => var_subasta_id /*OUT NUMBER*/);

    if var_subasta_id = -1 then
        RAISE_APPLICATION_ERROR(-20000, 'ERROR: Subasta no encontrada.');
    end if;

    -- Verificar si la puja sigue activa.
    select s.es_activa
    into var_es_activa
    from subasta s
    where s.subasta_id = var_subasta_id;

    if var_es_activa != 1 then 
        RAISE_APPLICATION_ERROR(-20000, 'ERROR: Esa subasta ya no esta activa.');
    end if;

    -- Conseguir el id del usuario
    SP_GET_USER_ID(IN_USERNAME  => in_username /*IN VARCHAR2*/,
                   OUT_SELECTED_ID  => var_usuario_id /*OUT NUMBER*/);

    if var_usuario_id = -1 then
        RAISE_APPLICATION_ERROR(-20000, 'ERROR: Nombre de usuario invalido.');
    end if;

    -- Conseguir el monto minimo para que la puja pueda ser realizada.
    SP_GET_VALOR_MINIMO(IN_SUBASTA_ID  => var_subasta_id /*IN NUMBER*/,
                        OUT_VALOR_MIN  => var_valor_minimo /*OUT NUMBER*/);
    -- Verificar si el monto ingresado es suficiente para hacer la puja.
    if var_valor_minimo > in_monto then
        RAISE_APPLICATION_ERROR(-20000, 'ERROR: El monto ingresado no es suficiente para crear una puja.');
    end if;

    insert into puja(subasta_fk, usuario_comprador_fk, monto,
                    fecha_y_tiempo, es_ganador, es_exitosa, is_deleted)
    values(
        var_subasta_id,
        var_usuario_id,
        in_monto,
        (select Systimestamp(2) from dual), 
        0,
        0,
        0
    );

    commit;

exception
    when others then
    errcode := SQLCODE;
    errmsg := SQLERRM;
    dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
    rollback;
end;
