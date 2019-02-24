DROP TABLE ausleihen;
DROP TABLE registrierungen;
DROP TABLE dvdkopien;
DROP TABLE filme;
DROP TABLE angestellte;
DROP TABLE filialen;
DROP TABLE mitglieder;

CREATE TABLE mitglieder (
  mnr VARCHAR2(4) NOT NULL,
  name VARCHAR2(15) NOT NULL,
  wohnort VARCHAR2(10) NOT NULL,
  gdatum DATE NOT NULL,
  CONSTRAINT mg_pk PRIMARY KEY(mnr)
);

CREATE TABLE filialen (
  fnr VARCHAR2(3) NOT NULL,
  ort VARCHAR2(10) NOT NULL,
  plz VARCHAR2(4) NOT NULL,
  CONSTRAINT fl_pk PRIMARY KEY(fnr)
);

CREATE TABLE angestellte (
  anr VARCHAR2(4) NOT NULL,
  name VARCHAR2(10) NOT NULL,
  salaer NUMBER(6,2) NOT NULL,
  CONSTRAINT an_pk PRIMARY KEY(anr)
);

CREATE TABLE filme (
  katalognr NUMBER(4) NOT NULL,
  titel VARCHAR2(30) NOT NULL,
  mindestalter NUMBER(2) NOT NULL,
  gebuehr NUMBER(4,2) NOT NULL,
  CONSTRAINT fm_pk PRIMARY KEY(katalognr)
);

CREATE TABLE dvdkopien (
  dvdnr NUMBER(6) NOT NULL,
  katalognr NUMBER(4) NOT NULL,
  fnr VARCHAR2(3) NOT NULL,
  CONSTRAINT dk_pk PRIMARY KEY(dvdnr),
  CONSTRAINT dk_fm_fk FOREIGN KEY(katalognr)
    REFERENCES filme,
  CONSTRAINT dk_fl_fk FOREIGN KEY(fnr)
    REFERENCES filialen
);

CREATE TABLE registrierungen (
  mnr VARCHAR2(4) NOT NULL,
  fnr VARCHAR2(3) NOT NULL,
  anr VARCHAR2(4) NULL,
  datum DATE NOT NULL,
  CONSTRAINT rg_pk PRIMARY KEY(mnr, fnr),
  CONSTRAINT rg_mg_fk FOREIGN KEY(mnr)
    REFERENCES mitglieder,
  CONSTRAINT rg_fl_fk FOREIGN KEY(fnr)
    REFERENCES filialen,
  CONSTRAINT rg_an_fk FOREIGN KEY(anr)
    REFERENCES angestellte
);

CREATE TABLE ausleihen (
  mnr VARCHAR2(4) NOT NULL,
  dvdnr NUMBER(6) NOT NULL,
  datum DATE NOT NULL,
  rueckgabe DATE NULL,
  CONSTRAINT al_pk PRIMARY KEY(dvdnr,datum),
  CONSTRAINT al_mg_fk FOREIGN KEY(mnr)
    REFERENCES mitglieder,
  CONSTRAINT al_dk_fk FOREIGN KEY(dvdnr)
    REFERENCES dvdkopien
);

INSERT INTO mitglieder (mnr,name,wohnort,gdatum) VALUES ('M001','A. Huber','Basel',TO_DATE('15.05.1978','dd.mm.yyyy'));
INSERT INTO mitglieder (mnr,name,wohnort,gdatum) VALUES ('M004','S. Baumann','Bern',TO_DATE('21.03.1982','dd.mm.yyyy'));
INSERT INTO mitglieder (mnr,name,wohnort,gdatum) VALUES ('M005','U. Schoch','Basel',TO_DATE('01.09.1975','dd.mm.yyyy'));
INSERT INTO mitglieder (mnr,name,wohnort,gdatum) VALUES ('M002','E. Müller','Bern',TO_DATE('30.07.1985','dd.mm.yyyy'));
INSERT INTO mitglieder (mnr,name,wohnort,gdatum) VALUES ('M003','K. Buser','Riehen',TO_DATE('13.04.1972','dd.mm.yyyy'));
INSERT INTO mitglieder (mnr,name,wohnort,gdatum) VALUES ('M006','E. Müller','Reinach BL',TO_DATE('28.10.1980','dd.mm.yyyy'));
COMMIT;
INSERT INTO filialen (fnr,ort,plz) VALUES ('F1','Basel','4056');
INSERT INTO filialen (fnr,ort,plz) VALUES ('F3','Bern','3014');
INSERT INTO filialen (fnr,ort,plz) VALUES ('F2','Zürich','8050');
INSERT INTO filialen (fnr,ort,plz) VALUES ('F4','Basel','4002');
COMMIT;
INSERT INTO angestellte (anr,name,salaer) VALUES ('A01','Doris',4100);
INSERT INTO angestellte (anr,name,salaer) VALUES ('A02','Urs',3700);
INSERT INTO angestellte (anr,name,salaer) VALUES ('A03','Rolf',4100);
INSERT INTO angestellte (anr,name,salaer) VALUES ('A04','Eva',3900);
INSERT INTO angestellte (anr,name,salaer) VALUES ('A05','Urs',3900);
COMMIT;
INSERT INTO filme (katalognr,titel,mindestalter,gebuehr) VALUES (2028,'Casablanca',9,8.50);
INSERT INTO filme (katalognr,titel,mindestalter,gebuehr) VALUES (1245,'Ocean''s Eleven',12,9.50);
INSERT INTO filme (katalognr,titel,mindestalter,gebuehr) VALUES (2239,'A Space Odyssee',12,7.50);
INSERT INTO filme (katalognr,titel,mindestalter,gebuehr) VALUES (1062,'Pulp Fiction',16,8.50);
INSERT INTO filme (katalognr,titel,mindestalter,gebuehr) VALUES (2588,'The Pelican Brief',12,8.50);
INSERT INTO filme (katalognr,titel,mindestalter,gebuehr) VALUES (1672,'Erin Brockovich',9,8.90);
INSERT INTO filme (katalognr,titel,mindestalter,gebuehr) VALUES (2468,'Ratatouille',6,7.50);
COMMIT;
INSERT INTO dvdkopien (dvdnr,katalognr,fnr) VALUES (199004,2028,'F1');
INSERT INTO dvdkopien (dvdnr,katalognr,fnr) VALUES (468123,2028,'F2');
INSERT INTO dvdkopien (dvdnr,katalognr,fnr) VALUES (269260,1245,'F1');
INSERT INTO dvdkopien (dvdnr,katalognr,fnr) VALUES (183669,1245,'F3');
INSERT INTO dvdkopien (dvdnr,katalognr,fnr) VALUES (329270,1245,'F4');
INSERT INTO dvdkopien (dvdnr,katalognr,fnr) VALUES (178643,2239,'F2');
INSERT INTO dvdkopien (dvdnr,katalognr,fnr) VALUES (389653,2239,'F4');
INSERT INTO dvdkopien (dvdnr,katalognr,fnr) VALUES (158234,1062,'F3');
INSERT INTO dvdkopien (dvdnr,katalognr,fnr) VALUES (139558,2468,'F2');
INSERT INTO dvdkopien (dvdnr,katalognr,fnr) VALUES (469118,2468,'F2');
INSERT INTO dvdkopien (dvdnr,katalognr,fnr) VALUES (310094,2468,'F2');
COMMIT;
INSERT INTO registrierungen (mnr,fnr,anr,datum) VALUES ('M001','F1','A01',TO_DATE('07.11.2013','dd.mm.yyyy'));
INSERT INTO registrierungen (mnr,fnr,anr,datum) VALUES ('M004','F1','A01',TO_DATE('29.06.2013','dd.mm.yyyy'));
INSERT INTO registrierungen (mnr,fnr,anr,datum) VALUES ('M005','F1','A01',TO_DATE('04.07.2013','dd.mm.yyyy'));
INSERT INTO registrierungen (mnr,fnr,anr,datum) VALUES ('M002','F3','A02',TO_DATE('17.05.2013','dd.mm.yyyy'));
INSERT INTO registrierungen (mnr,fnr,anr,datum) VALUES ('M004','F3','A01',TO_DATE('29.06.2013','dd.mm.yyyy'));
INSERT INTO registrierungen (mnr,fnr,anr,datum) VALUES ('M005','F3','A02',TO_DATE('01.12.2013','dd.mm.yyyy'));
INSERT INTO registrierungen (mnr,fnr,anr,datum) VALUES ('M003','F1','A03',TO_DATE('07.11.2013','dd.mm.yyyy'));
INSERT INTO registrierungen (mnr,fnr,anr,datum) VALUES ('M001','F2','A04',TO_DATE('12.10.2013','dd.mm.yyyy'));
INSERT INTO registrierungen (mnr,fnr,anr,datum) VALUES ('M006','F4','A05',TO_DATE('16.05.2013','dd.mm.yyyy'));
COMMIT;
INSERT INTO ausleihen (mnr,dvdnr,datum,rueckgabe) VALUES ('M002',158234,TO_DATE('19.07.2013','dd.mm.yyyy'),TO_DATE('21.07.2013','dd.mm.yyyy'));
INSERT INTO ausleihen (mnr,dvdnr,datum,rueckgabe) VALUES ('M004',158234,TO_DATE('02.08.2013','dd.mm.yyyy'),TO_DATE('04.08.2013','dd.mm.yyyy'));
INSERT INTO ausleihen (mnr,dvdnr,datum,rueckgabe) VALUES ('M003',269260,TO_DATE('05.01.2014','dd.mm.yyyy'),NULL);
INSERT INTO ausleihen (mnr,dvdnr,datum,rueckgabe) VALUES ('M003',199004,TO_DATE('05.01.2014','dd.mm.yyyy'),NULL);
INSERT INTO ausleihen (mnr,dvdnr,datum,rueckgabe) VALUES ('M001',310094,TO_DATE('22.11.2013','dd.mm.yyyy'),TO_DATE('27.11.2013','dd.mm.yyyy'));
INSERT INTO ausleihen (mnr,dvdnr,datum,rueckgabe) VALUES ('M001',468123,TO_DATE('19.01.2014','dd.mm.yyyy'),NULL);
INSERT INTO ausleihen (mnr,dvdnr,datum,rueckgabe) VALUES ('M002',183669,TO_DATE('30.11.2013','dd.mm.yyyy'),TO_DATE('01.12.2013','dd.mm.yyyy'));
INSERT INTO ausleihen (mnr,dvdnr,datum,rueckgabe) VALUES ('M004',183669,TO_DATE('27.12.2013','dd.mm.yyyy'),TO_DATE('03.01.2014','dd.mm.yyyy'));
INSERT INTO ausleihen (mnr,dvdnr,datum,rueckgabe) VALUES ('M005',183669,TO_DATE('15.01.2014','dd.mm.yyyy'),NULL);
COMMIT;