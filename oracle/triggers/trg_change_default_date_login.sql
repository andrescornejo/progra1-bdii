CREATE OR REPLACE TRIGGER CHANGE_DATE_FORMAT
AFTER LOGON ON DATABASE
CALL DBMS_SESSION.SET_NLS('NLS_DATE_FORMAT','"YYYY-MM-DD HH24:MI:SS"')
/