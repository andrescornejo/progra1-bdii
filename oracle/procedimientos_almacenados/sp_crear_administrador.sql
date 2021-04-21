/*
Procedimiento almacenado: sp_crear_administrador

Descripcion: Procedimiento que inserta una fila a la tabla Administrador.
primero se encripta la contrasena

Entradas: 
- FK de persona, number
- Username, varchar2
- Password, varchar2

Roles autorizados:
- Administrador

Autor: Andres Cornejo
*/

create or replace procedure sp_crear_administrador(
    in_fk_usuario   in number,
    out_inserted_id out number
)
--AUTHID CURRENT_USER
AUTHID DEFINER
is
    errcode     number;
    errmsg      varchar2(200);
    does_exist  number;
    usr         varchar2(200);
    l_statement varchar2(2000);
begin
    select case 
                when exists (select 1 
                            from administrador a
                            where a.usuario_fk = in_fk_usuario and is_deleted = 0) 
                then 1 
                else 0 
            end into does_exist 
    from dual;

    -- Si el administrador no existe.
    if does_exist = 0 then
        select u.username into usr from system.USUARIO u where u.usuario_id = in_fk_usuario; 

        -- DAR PERMISOS DE ADMINISTRADOR AL USUARIO
        l_statement := 'grant administrador_sistema to ' || usr;
        dbms_output.put_line(l_statement);
        execute immediate (l_statement);

        -- INSERTAR A LA TABLA DE USUARIOS
        insert into administrador(usuario_fk, is_deleted)
        values(in_fk_usuario, 0)
        returning administrador_id into out_inserted_id;

        commit;
        dbms_output.put_line('Se inserto '|| usr || ' a la tabla ADMINISTRADOR.');


    -- Si el administrador existe.
    else
        RAISE_APPLICATION_ERROR(-20000, 'ERROR - Ya existe esa entrada en la tabla ADMINISTRADOR.');
    end if;
exception
    when others then
    errcode := SQLCODE;
    errmsg := SQLERRM;
    dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
    rollback;
end;
