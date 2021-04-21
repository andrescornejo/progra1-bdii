/*
Procedimiento almacenado: sp_decrypt_pw

Descripcion: Procedimiento que decripta un texto a partir de una llave y el texto cifrado

Entradas: 
- texto cifrado, varchar2
- llave de cifrado, varchar2

Roles autorizados:
- Administrador

Autor: Andres Cornejo
*/

create or replace procedure sp_decrypt_pw(
    in_text         in varchar2,
    in_key          in varchar2,
    out_decrypted   out varchar2
)
is
    errcode number;
    errmsg  varchar2(200);
    l_mod NUMBER
          :=   DBMS_CRYPTO.ENCRYPT_AES256
             + DBMS_CRYPTO.CHAIN_CBC
             + DBMS_CRYPTO.PAD_PKCS5;
    l_dec RAW (2000);
begin

    l_dec :=
      DBMS_CRYPTO.decrypt (in_text,
                           l_mod,
                           UTL_I18N.STRING_TO_RAW (in_key, 'AL32UTF8'));
    DBMS_OUTPUT.put_line ('Decrypted=' || UTL_I18N.raw_to_char (l_dec));

    out_decrypted := UTL_I18N.raw_to_char (l_dec);
    commit;

exception
    when others then
    errcode := SQLCODE;
    errmsg := SQLERRM;
    dbms_output.put_line(TO_CHAR(errcode) || '-' || errmsg);
end;
