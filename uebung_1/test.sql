insert into ausleihen values ('M001', 158234, sysdate-30,null);
update ausleihen set rueckgabe = sysdate where mnr = 'M001' and dvdnr = 158234;
delete from ausleihen where mnr = 'M001' and dvdnr = 158234;
commit;

select count(*) from ausleihen_log; --  3 rows
