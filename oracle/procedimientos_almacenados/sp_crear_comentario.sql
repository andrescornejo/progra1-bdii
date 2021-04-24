/*
Procedimiento almacenado: sp_crear_comentario

Descripcion: Inserta una entrada a la tabla comentario

Entradas: 
fk del usuario, number.
comentario, varchar2.
rating, float.

Roles autorizados:
cliente

Autor: Andres Cornejo
*/

create or replace procedure sp_crear_comentario(
    in_user_id in number,
    in_comment in VARCHAR2,
    in_rating  in float,
    out_inserted_id out number
)
is
    errcode     number;
    errmsg      varchar2(200);
begin

    insert into comentario(usuario_fk, comentario, rating, is_deleted)
    values(in_user_id, in_comment, in_rating, 0)
    returning comentario_id into out_inserted_id;
    commit;
    dbms_output.put_line('Se inserto un comentario a la tabla COMENTARIO.');

exception
    when others then
    errcode := SQLCODE;
    errmsg := SQLERRM;
    dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
    rollback;
end;
