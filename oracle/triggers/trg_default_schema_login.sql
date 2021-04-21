CREATE OR REPLACE TRIGGER LOGON_TRG 
  AFTER LOGON ON SCHEMA
BEGIN
     EXECUTE IMMEDIATE 'ALTER SESSION SET CURRENT_SCHEMA = system';
EXCEPTION 
  when others 
    then null; -- prevent a login failure due to an exception
END;