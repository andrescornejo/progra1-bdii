/*
Procedimiento almacenado: sp_crear_direccion

Descripcion: Procedimiento que inserta una fila a la tabla Direccion.
Esta entrada a la tabla direccion inserta los datos sin especificar,
para que el usuario cliente inserte la informacion correcta luego.

Entradas: 
- FK de persona, number

Roles autorizados:
- Administrador

Autor: Andres Cornejo
*/

create or replace procedure sp_crear_direccion(
    in_fk_persona   in  number,
    out_inserted_id out number 
)
is
    errcode     number;
    errmsg      varchar2(200);
    not_spec    varchar2(20) := 'No especificado';
begin
    /* Insertar a la tabla direccion una nueva direccion,
     * con los campos informativos sin especificar.
     * Como un usuario puede tener varias direcciones, no es necesario
     * verificar si ya existen entradas similares o iguales.
     */
    insert into direccion(persona_fk, descripcion, distrito,
                            canton, provincia, pais, is_deleted)
    values(in_fk_persona, not_spec, not_spec, not_spec, not_spec, not_spec, 0)
    returning direccion_id into out_inserted_id; 
    commit;
    dbms_output.put_line('Se inserto una direccion vacia a la tabla Direccion.');

exception
    when others then
    errcode := SQLCODE;
    errmsg := SQLERRM;
    dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
    rollback;
end;
