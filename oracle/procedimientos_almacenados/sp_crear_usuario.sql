/*
Procedimiento almacenado: sp_crear_usuario

Descripcion: Procedimiento que inserta una fila a la tabla Usuario.
primero se encripta la contrasena

Entradas: 
- FK de persona, number
- Username, varchar2
- Password, varchar2

Roles autorizados:
- Administrador

Autor: Andres Cornejo
*/

create or replace procedure sp_crear_usuario(
    in_fk_persona   in number,
    in_username     in varchar2,
    in_passwd       in varchar2,
    out_inserted_id out number
)
--AUTHID CURRENT_USER
AUTHID DEFINER
is
    errcode     number;
    errmsg      varchar2(200);
    does_exist  number;
    l_psswd     varchar2(100);
    l_key       nvarchar2(32):= dbms_random.string('X', 32); -- generar llave aleatoria de al menos 32 bytes.
    l_mod       NUMBER
          :=   DBMS_CRYPTO.ENCRYPT_AES256
             + DBMS_CRYPTO.CHAIN_CBC
             + DBMS_CRYPTO.PAD_PKCS5;
    l_enc       RAW (2000);
    l_statement varchar2(2000);
begin

    /* Como cada usuario solo puede tener un nombre de usuario unico,
     * hay que hacer una verificacion, para ver si el usuario ya existe.
     */
    select case 
                when exists (select 1 
                            from usuario u
                            where u.username = in_username and is_deleted = 0) 
                then 1 
                else 0 
            end into does_exist 
    from dual;

    -- Si no existe el usuario
    if does_exist = 0 then
        l_psswd :=
            DBMS_CRYPTO.encrypt (UTL_I18N.string_to_raw (in_passwd, 'AL32UTF8'),
                                    l_mod,
                                    UTL_I18N.string_to_raw (l_key, 'AL32UTF8')); -- Encriptado de la contrasena
        l_statement := 'create user ' || in_username || ' identified by ' || in_passwd || ' default tablespace system';
        dbms_output.put_line(l_statement);
        execute immediate (l_statement);

        -- DAR PERMISOS AL USUARIO CREADO
        l_statement := 'grant connect,
                                create session,
                                unlimited tablespace,
                                cliente
                        to ' || in_username;
        dbms_output.put_line(l_statement);
        execute immediate (l_statement);

        -- INSERTAR A LA TABLA DE USUARIOS
        insert into usuario(persona_fk, username, passwd, dkey, is_deleted)
        values(in_fk_persona, in_username, l_psswd, l_key, 0)
        returning usuario_id into out_inserted_id;
        -- dbms_output.put_line(out_inserted_id); --Imprimir el id (para debug)
        commit;
        dbms_output.put_line('Se inserto el usuario ' || in_username || ' a la tabla USUARIO.');

    -- Si el usuario existe
    else
        RAISE_APPLICATION_ERROR(-20000, 'ERROR - Ya existe esa entrada en la tabla USUARIO.');
    end if;
exception
    when others then
    l_statement := 'drop user ' || in_username;
    dbms_output.put_line(l_statement);
    execute immediate (l_statement);

    errcode := SQLCODE;
    errmsg := SQLERRM;
    dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
    rollback;
end;
