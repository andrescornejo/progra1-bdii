create or replace trigger trg_actualizar_subasta_pujas
    after INSERT
    on puja
    for each row
BEGIN
    update subasta
    set valor_actual = :new.monto
    where :new.subasta_fk = subasta_id;

END trg_actualizar_subasta_pujas;