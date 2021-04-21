-- Para poder encriptar en el schema system.
-- para esto se tiene que hacer login en sqlplus como:
     --sys as sysdba
grant execute on sys.dbms_crypto to SYSTEM;

-- Para lograr crear usarios se le da todos los privilegios a system
-- ya que sp_crear_usuario necesita definer rights.

grant all privileges to system;

SELECT * FROM session_privs
ORDER BY privilege;

-- Poner el formato de fechas al estandar.
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';