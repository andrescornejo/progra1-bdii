/*
Procedimiento almacenado: sp_nuevo_cliente

Descripcion: Procedimiento crea un nuevo administrador a nivel del sistema.
Esto implica crear una persona con sus dependencias, un usuario, y un administrador.

Entradas: 
nombre de la persona, varchar2
apellido de la persona, varchar2
numero de identificacion, varchar2
tipo de identificacion, varchar2
email de la persona, varchar2
nombre de usuario, varchar2
contrasena del usuario, varchar2

Roles autorizados:
- Administrador

Autor: Andres Cornejo
*/

create or replace procedure sp_nuevo_cliente(
    in_nombre       in varchar2,
    in_apellido     in varchar2,
    in_identif      in varchar2,
    in_tipo_identif in varchar2, 
    in_email        in varchar2,
    in_username     in varchar2,
    in_passwd       in varchar2
)
--AUTHID CURRENT_USER
AUTHID DEFINER
is
    errcode                 number;
    errmsg                  varchar2(200);
    var_dir_id              number;
    var_email_id            number;
    var_identif_id          number;
    var_tipo_identif_id     number;
    var_persona_id          number;
    var_telefono_id         number;
    var_usuario_id          number;

begin

    -- Nota: Hay que validar que todos los ids retornados por los SPs sean validos, 
    --       para evitar registros fragmentados.

    SP_GET_TIPOID_ID(IN_NOMBRE_TIPO_ID  => in_tipo_identif /*IN VARCHAR2*/,
                     OUT_ID  => var_tipo_identif_id /*OUT NUMBER*/);
    
    if var_tipo_identif_id = -1 then
        RAISE_APPLICATION_ERROR(-20000, 'ERROR: Nombre de tipo de identificacion invalido.');
    end if;

    SP_CREAR_EMAIL(IN_EMAILADDR  => in_email /*IN VARCHAR2*/,
                   OUT_INSERTED_ID  => var_email_id /*OUT NUMBER*/);
    
    if var_email_id = -1 then
        RAISE_APPLICATION_ERROR(-20000, 'ERROR: Email ingresado es invalido.');
    end if;

    SP_CREAR_IDENTIFICACION(IN_NUMERO_IDENTIF  => in_identif /*IN VARCHAR2*/,
                            IN_ID_TIPO_IDENTIF  => var_tipo_identif_id /*IN NUMBER*/,
                            OUT_INSERTED_ID  => var_identif_id /*OUT NUMBER*/);

    if var_identif_id = -1 then
        RAISE_APPLICATION_ERROR(-20000, 'ERROR: Numero de identificacion ingresado es invalido.');
    end if;
    
    SP_CREAR_PERSONA(IN_FK_IDENTIF  => var_identif_id /*IN NUMBER*/,
                     IN_FK_EMAIL  => var_email_id /*IN NUMBER*/,
                     IN_NOMBRE  => in_nombre /*IN VARCHAR2*/,
                     IN_APELLIDO  => in_apellido /*IN VARCHAR2*/,
                     OUT_INSERTED_ID  => var_persona_id /*OUT NUMBER*/);

    if var_persona_id = -1 then
        RAISE_APPLICATION_ERROR(-20000, 'ERROR: Nombre o apellido ingresado es invalido.');
    end if;

    SP_CREAR_TELEFONO(IN_FK_PERSONA  => var_persona_id /*IN NUMBER*/,
                      OUT_INSERTED_ID  => var_telefono_id /*OUT NUMBER*/);

    if var_telefono_id = -1 then
        RAISE_APPLICATION_ERROR(-20000, 'ERROR: Se ha producido un error al intentar crear un telefono.');
    end if;
    
    SP_CREAR_DIRECCION(IN_FK_PERSONA  => var_persona_id /*IN NUMBER*/,
                       OUT_INSERTED_ID  => var_dir_id /*OUT NUMBER*/);

    if var_dir_id = -1 then
        RAISE_APPLICATION_ERROR(-20000, 'ERROR: Se ha producido un error al intentar crear una direccion.');
    end if;
    
    SP_CREAR_USUARIO(IN_FK_PERSONA  => var_persona_id /*IN NUMBER*/,
                     IN_USERNAME  => in_username /*IN VARCHAR2*/,
                     IN_PASSWD  => in_passwd /*IN VARCHAR2*/,
                     OUT_INSERTED_ID  => var_usuario_id /*OUT NUMBER*/);

    if var_usuario_id = -1 then
        RAISE_APPLICATION_ERROR(-20000, 'ERROR: Nombre de usuario o contrasena ingresado invalido.');
    end if;

    commit;
exception
    when others then
    errcode := SQLCODE;
    errmsg := SQLERRM;
    dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
end;
