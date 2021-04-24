BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'job_desactivar_subasta',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'SYSTEM.SP_DESACTIVAR_SUBASTA',
   start_date         =>  timestamp '2021-04-21 05:15:00',
   repeat_interval    =>  'FREQ=MINUTELY;INTERVAL=5;', 
   enabled            =>  TRUE,  
   comments           =>  'xD');
END;
/