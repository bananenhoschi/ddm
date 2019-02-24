CREATE OR REPLACE TRIGGER trg_ausleihen_log AFTER
    INSERT OR DELETE OR UPDATE ON ausleihen
    FOR EACH ROW
DECLARE
    action VARCHAR2(3);
BEGIN
    IF inserting THEN
        action := 'INS';
    ELSIF updating THEN
        action := 'UPD';
    ELSIF deleting THEN
        action := 'DEL';
    END IF;

    INSERT INTO ausleihen_log (
        modificatoin_user,
        modification_date,
        action,
        mnr,
        dvdnr,
        datum_old,
        datum_new,
        rueckgabe_old,
        rueckgabe_new
    ) VALUES (
        User,
        SYSDATE,
        action,
        :old.mnr,
        :old.dvdnr,
        :old.datum,
        :new.datum,
        :old.rueckgabe,
        :new.rueckgabe
    );

END;
/
