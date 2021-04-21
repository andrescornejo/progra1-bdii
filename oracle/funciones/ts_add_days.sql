--Funcion para agregarle dias a un timestamp.
CREATE OR REPLACE FUNCTION ts_add_days(
  datetime TIMESTAMP WITH TIME ZONE,
  days INT
) RETURN TIMESTAMP WITH TIME ZONE DETERMINISTIC
AS
  p_tz   CONSTANT VARCHAR2(30) := EXTRACT( TIMEZONE_REGION FROM datetime );
  p_utc  CONSTANT TIMESTAMP    := datetime AT TIME ZONE 'UTC';
  p_date CONSTANT DATE         := TRUNC( p_utc );
BEGIN
  RETURN CAST( ADD_DAYS( p_date, days) AS TIMESTAMP WITH TIME ZONE ) AT TIME ZONE p_tz + ( p_utc - p_date );
  --FIXME: add_days no es un funcion nativa de oracle, a diferencia de add_months
END;
/
SHOW ERRORS;


/*
Inspirado por:
https://stackoverflow.com/questions/35775451/oracle-add-days-months-to-a-timestamp-with-time-zone-field
*/