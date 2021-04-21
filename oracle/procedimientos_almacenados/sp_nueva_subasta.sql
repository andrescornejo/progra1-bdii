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
begin
    select case 
                when exists (select 1 
                            from subasta s
                            where s.nombre = in_nombre_subasta and is_deleted = 0) 
                then 1 
                else 0 
            end into does_exist 
    from dual;

    if does_exist = 0 then

    

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
