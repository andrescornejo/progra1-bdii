create user andres
    identified by 1234;

grant unlimited tablespace to andres;

grant create session to andres;

grant administrador_sistema to andres;
-- create user mario
--     identified by 1234;

create user pleb
    identified by 1234;

grant unlimited tablespace to pleb;
grant create session to pleb;
grant cliente to pleb;