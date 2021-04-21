/*
Procedimiento almacenado: sp_crear_telefono

Descripcion: Procedimiento que inserta una fila a la tabla Direccion.
Esta entrada a la tabla direccion inserta los datos sin especificar,
para que el usuario cliente inserte la informacion correcta luego.

Entradas: 
- FK de persona, number

Roles autorizados:
- Administrador

Autor: Andres Cornejo
*/

create or replace procedure sp_crear_telefono(
    in_fk_persona   in number,
    out_inserted_id out number
)
is
    errcode     number;
    errmsg      varchar2(200);
    not_spec    varchar2(20);
begin
    /* Insertar a la tabla telefono una nueva entrada,
     * con los campos informativos sin especificar.
     * Como un usuario puede tener varios telefonos, no es necesario
     * verificar si ya existen entradas similares o iguales.
     */
    not_spec := 'No especificado';
    insert into telefono(persona_fk, num_telefono, descripcion, is_deleted) 
    values(in_fk_persona, not_spec, not_spec, 0)
    returning telefono_id into out_inserted_id; 
    commit;
    dbms_output.put_line('Se inserto una entrada vacia a la tabla Telefono.');
exception
    when others then
    errcode := SQLCODE;
    errmsg := SQLERRM;
    dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
    rollback;
end;
