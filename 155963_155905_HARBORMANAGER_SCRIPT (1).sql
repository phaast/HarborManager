  CREATE TABLE "KURSY" 
   (	"NR_KURSU" NUMBER NOT NULL ENABLE, 
	"DATA_ROZPOCZECIA" TIMESTAMP (6) NOT NULL ENABLE, 
	"DATA_ZAKONCZENIA" TIMESTAMP (6) NOT NULL ENABLE, 
	"STATUS_ZAKONCZENIA" NUMBER DEFAULT 0 NOT NULL ENABLE, 
	"NR_SER_STATKU" NUMBER(10,0) NOT NULL ENABLE, 
	"ID_PORTU_DOCELOWEGO" NUMBER NOT NULL ENABLE, 
	"NR_ZALOGI" NUMBER NOT NULL ENABLE, 
	"ID_ZALADUNKU" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "KURSY_POPRAWNE_DATY" CHECK (DATA_ROZPOCZECIA < DATA_ZAKONCZENIA) ENABLE, 
	 CONSTRAINT "KURSY_STATUS_ZAKONCZENIA" CHECK (STATUS_ZAKONCZENIA >=0 and STATUS_ZAKONCZENIA <=1) ENABLE, 
	 CONSTRAINT "PK_KURSY" PRIMARY KEY ("NR_KURSU")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "MV_KURSY" 
   (	"NR_KURSU" NUMBER NOT NULL ENABLE, 
	"NR_SER_STATKU" NUMBER(10,0) NOT NULL ENABLE, 
	"NR_ZALOGI" NUMBER NOT NULL ENABLE, 
	"STATUS_ZAKONCZENIA" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "SYS_C_SNAP$_41PK_KURSY" PRIMARY KEY ("NR_KURSU")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "KONTENERY" 
   (	"NR_KONTENERA" NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"KATEGORIA" VARCHAR2(50) NOT NULL ENABLE, 
	"WAGA_TONY" NUMBER(15,0) NOT NULL ENABLE, 
	"ID_WLASCICIELA" NUMBER NOT NULL ENABLE, 
	"ID_ZALADUNKU" NUMBER, 
	 CONSTRAINT "KON_WAGA" CHECK (WAGA_TONY>=0) ENABLE, 
	 CONSTRAINT "PK_KONTENERY" PRIMARY KEY ("NR_KONTENERA")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "LISTY_ZALADUNKOWE" 
   (	"ID_ZALADUNKU" NUMBER NOT NULL ENABLE, 
	"DATA_STWORZENIA" DATE DEFAULT SYSDATE NOT NULL ENABLE, 
	"NAZWA_ROBOCZA" VARCHAR2(255), 
	"CZY_UZYTA" VARCHAR2(3) DEFAULT 'NIE' NOT NULL ENABLE, 
	 CONSTRAINT "PK_LISTY_ZALADUNKOWE" PRIMARY KEY ("ID_ZALADUNKU")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "MAGAZYN_PALIWA" 
   (	"TYP_PALIWA" VARCHAR2(50) NOT NULL ENABLE, 
	"ILOSC_L" NUMBER(10,2) NOT NULL ENABLE, 
	"BUDZET_ZL" NUMBER(10,2) NOT NULL ENABLE, 
	 CONSTRAINT "MAG_PAL_ILOSC" CHECK (ILOSC_L>=0) ENABLE, 
	 CONSTRAINT "MAG_PAL_BUDZET" CHECK (BUDZET_ZL>=0) ENABLE, 
	 CONSTRAINT "PK_MAGAZYN_PALIWA" PRIMARY KEY ("TYP_PALIWA")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "MLOG$_KURSY" 
   (	"NR_KURSU" NUMBER, 
	"M_ROW$$" VARCHAR2(255), 
	"SNAPTIME$$" DATE, 
	"DMLTYPE$$" VARCHAR2(1), 
	"OLD_NEW$$" VARCHAR2(1), 
	"CHANGE_VECTOR$$" RAW(255), 
	"XID$$" NUMBER
   ) ;

  CREATE TABLE "PASAZEROWIE" 
   (	"ID_PASAZERA" NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"IMIE" VARCHAR2(50) NOT NULL ENABLE, 
	"NAZWISKO" VARCHAR2(50) NOT NULL ENABLE, 
	"PESEL" VARCHAR2(11) NOT NULL ENABLE, 
	"E_MAIL" VARCHAR2(100) NOT NULL ENABLE, 
	"ID_ZALADUNKU" NUMBER, 
	 CONSTRAINT "PESEL_DLUGOSC" CHECK (LENGTH(PESEL)=11) ENABLE, 
	 CONSTRAINT "PK_PASAZEROWIE" PRIMARY KEY ("ID_PASAZERA")
  USING INDEX  ENABLE, 
	 CONSTRAINT "UQ_PESEL_ZALADUNEK" UNIQUE ("PESEL", "ID_ZALADUNKU")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "PORTY_DOCELOWE" 
   (	"ID_PORTU" NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"NAZWA" VARCHAR2(100) NOT NULL ENABLE, 
	"L_DOSTEPNYCH_MIEJSC" NUMBER(2,0) NOT NULL ENABLE, 
	"CZAS_OBSLUGI_NA_TONE_H" NUMBER(10,2) NOT NULL ENABLE, 
	"ODLEGLOSC_KM" NUMBER(10,2) NOT NULL ENABLE, 
	 CONSTRAINT "POR_DOC_L_DOST_MIEJSC" CHECK (L_DOSTEPNYCH_MIEJSC>=0) ENABLE, 
	 CONSTRAINT "POR_DOC_CZAS_OBSLUGI" CHECK (CZAS_OBSLUGI_NA_TONE_H>=0) ENABLE, 
	 CONSTRAINT "POR_DOC_ODLEGLOSC" CHECK (ODLEGLOSC_KM>=0) ENABLE, 
	 CONSTRAINT "PK_PORTY_DOCELOWE" PRIMARY KEY ("ID_PORTU")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "PRACOWNICY" 
   (	"ID_PRAC" NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"IMIE" VARCHAR2(50) NOT NULL ENABLE, 
	"NAZWISKO" VARCHAR2(50) NOT NULL ENABLE, 
	"DATA_ZATRUDNIENIA" DATE DEFAULT SYSDATE NOT NULL ENABLE, 
	"PLACA" NUMBER(10,2) NOT NULL ENABLE, 
	"NR_TEL" NUMBER(15,0) NOT NULL ENABLE, 
	 CONSTRAINT "PRA_PLACA" CHECK (PLACA>=100) ENABLE, 
	 CONSTRAINT "PK_PRACOWNICY" PRIMARY KEY ("ID_PRAC")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "PRACOWNICY_ZALOGI_ROLE" 
   (	"NR_PRZYPISANIA" NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"ID_PRAC" NUMBER, 
	"NR_ZALOGI" NUMBER, 
	"ID_ROLI" NUMBER, 
	 CONSTRAINT "PK_PRACOWNICY_ZALOGI_ROLE" PRIMARY KEY ("NR_PRZYPISANIA")
  USING INDEX  ENABLE, 
	 CONSTRAINT "UQ_PRACOWNICY_ZALOGI_ROLE" UNIQUE ("ID_PRAC", "NR_ZALOGI")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "RAFINERIA" 
   (	"TYP_PALIWA" VARCHAR2(50) NOT NULL ENABLE, 
	"CENA_ZL_L" NUMBER(10,2) NOT NULL ENABLE, 
	 CONSTRAINT "RAF_CENA" CHECK (CENA_ZL_L>=0) ENABLE, 
	 CONSTRAINT "PK_RAFINERIA" PRIMARY KEY ("TYP_PALIWA")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "ROLE_PRACOWNIKOW" 
   (	"ID_ROLI" NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"NAZWA" VARCHAR2(50) NOT NULL ENABLE, 
	 CONSTRAINT "PK_ROLE" PRIMARY KEY ("ID_ROLI")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "STATKI" 
   (	"NUMER_SERYJNY" NUMBER NOT NULL ENABLE, 
	"NAZWA" VARCHAR2(50) NOT NULL ENABLE, 
	"WYPORNOSC_TONA" NUMBER NOT NULL ENABLE, 
	"MAX_L_PASAZEROW" NUMBER NOT NULL ENABLE, 
	"MAX_DYSTANS_KM" NUMBER NOT NULL ENABLE, 
	"SPALANIE_PALIWA_L" NUMBER(10,2) NOT NULL ENABLE, 
	"TYP_PALIWA" VARCHAR2(50) NOT NULL ENABLE, 
	 CONSTRAINT "STA_WYPORNOSC" CHECK (WYPORNOSC_TONA>=0) ENABLE, 
	 CONSTRAINT "STA_MAX_L_PASAZEROW" CHECK (MAX_L_PASAZEROW>=0) ENABLE, 
	 CONSTRAINT "STA_MAX_DYSTANS" CHECK (MAX_DYSTANS_KM>=0) ENABLE, 
	 CONSTRAINT "STA_SPALANIE_PALIWA" CHECK (SPALANIE_PALIWA_L>=0) ENABLE, 
	 CONSTRAINT "PK_STATKI" PRIMARY KEY ("NUMER_SERYJNY")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "WLASCICIELE" 
   (	"ID_WLASCICIELA" NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"NAZWA" VARCHAR2(100) NOT NULL ENABLE, 
	"ADRES" VARCHAR2(100) NOT NULL ENABLE, 
	"NR_TEL" NUMBER(15,0) NOT NULL ENABLE, 
	"E_MAIL" VARCHAR2(100) NOT NULL ENABLE, 
	 CONSTRAINT "PK_WLASCICIELE" PRIMARY KEY ("ID_WLASCICIELA")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "ZAKUPY" 
   (	"NR_FAKTURY" NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"ILOSC_KUPIONEGO_L" NUMBER(10,2) NOT NULL ENABLE, 
	"KOSZT_RAZEM" NUMBER(10,2) NOT NULL ENABLE, 
	"DATA_ZAKUPU" TIMESTAMP (6) DEFAULT SYSTIMESTAMP NOT NULL ENABLE, 
	"TYP_PALIWA_RAF" VARCHAR2(50) NOT NULL ENABLE, 
	"TYP_PALIWA_MAG" VARCHAR2(50) NOT NULL ENABLE, 
	 CONSTRAINT "ZAK_ILOSC" CHECK (ILOSC_KUPIONEGO_L > 0) ENABLE, 
	 CONSTRAINT "ZAK_TE_SAME_PALIWO" CHECK (TYP_PALIWA_RAF = TYP_PALIWA_MAG) ENABLE, 
	 CONSTRAINT "PK_ZAKUPY" PRIMARY KEY ("NR_FAKTURY")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "ZALOGI" 
   (	"NR_ZALOGI" NUMBER NOT NULL ENABLE, 
	"NAZWA" VARCHAR2(100) NOT NULL ENABLE, 
	"DATA_ZALOZENIA" DATE DEFAULT SYSDATE NOT NULL ENABLE, 
	 CONSTRAINT "PK_ZALOGI" PRIMARY KEY ("NR_ZALOGI")
  USING INDEX  ENABLE
   ) ;

   COMMENT ON MATERIALIZED VIEW "MV_KURSY"  IS 'snapshot table for snapshot WKSP_WS155963.MV_KURSY';

  ALTER TABLE "KONTENERY" ADD CONSTRAINT "FK_ID_WLASCICIELA" FOREIGN KEY ("ID_WLASCICIELA")
	  REFERENCES "WLASCICIELE" ("ID_WLASCICIELA") ENABLE;
  ALTER TABLE "KONTENERY" ADD CONSTRAINT "FK_ID_ZALADUNKU_KON" FOREIGN KEY ("ID_ZALADUNKU")
	  REFERENCES "LISTY_ZALADUNKOWE" ("ID_ZALADUNKU") ON DELETE CASCADE ENABLE;

  ALTER TABLE "KURSY" ADD CONSTRAINT "FK_ID_PORTU_DOCELOWEGO" FOREIGN KEY ("ID_PORTU_DOCELOWEGO")
	  REFERENCES "PORTY_DOCELOWE" ("ID_PORTU") ENABLE;
  ALTER TABLE "KURSY" ADD CONSTRAINT "FK_ID_ZALADUNKU_KURS" FOREIGN KEY ("ID_ZALADUNKU")
	  REFERENCES "LISTY_ZALADUNKOWE" ("ID_ZALADUNKU") ENABLE;
  ALTER TABLE "KURSY" ADD CONSTRAINT "FK_NR_SER_STATKU" FOREIGN KEY ("NR_SER_STATKU")
	  REFERENCES "STATKI" ("NUMER_SERYJNY") ENABLE;
  ALTER TABLE "KURSY" ADD CONSTRAINT "FK_NR_ZALOGI_KURS" FOREIGN KEY ("NR_ZALOGI")
	  REFERENCES "ZALOGI" ("NR_ZALOGI") ENABLE;

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_CHECK_PORT_AVAILABILITY" 
BEFORE UPDATE OF DATA_ZAKONCZENIA
ON KURSY
FOR EACH ROW
DECLARE
    vCzyPortMaMiejsce BOOLEAN;
BEGIN
    IF :NEW.DATA_ZAKONCZENIA > SYSTIMESTAMP AND :OLD.STATUS_ZAKONCZENIA=1 THEN
        vCzyPortMaMiejsce := CzyPortMaMiejsce(:NEW.ID_PORTU_DOCELOWEGO); 
        
        IF NOT vCzyPortMaMiejsce THEN
            RAISE_APPLICATION_ERROR(-20001, 'Zmiana daty wymusza wznowienie zlecenia, ale nie ma dostępnego miejsca w porcie docelowym.');
        END IF;
    END IF;
END;
/
ALTER TRIGGER "TRG_CHECK_PORT_AVAILABILITY" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_AFTER_INSERT" 
    AFTER INSERT ON KURSY 
    FOR EACH ROW 
BEGIN 
    OdejmijDostepneMiejscaWPorcie(:NEW.ID_PORTU_DOCELOWEGO); 
    UPDATE LISTY_ZALADUNKOWE SET CZY_UZYTA = 'TAK' WHERE ID_ZALADUNKU = :NEW.ID_ZALADUNKU; 
END TRG_KURSY_AFTER_INSERT; 

/
ALTER TRIGGER "TRG_KURSY_AFTER_INSERT" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_BEFORE_INSERT" 
    BEFORE INSERT ON KURSY  
    FOR EACH ROW  
DECLARE  
    vCzyStatekDoplynie BOOLEAN; 
    vCzyPortMaMiejsce BOOLEAN;  
    vCzyZalogaMaKapitana BOOLEAN;  
    vCzyZalogaIPasazerowieSieZmieszcza BOOLEAN;  
    vCzyCzlonkowieZalogiWolni BOOLEAN;  
    vCzyZalogaWolna BOOLEAN;  
    vCzyStatekWolny BOOLEAN;  
    vCzyWagaSpelniaWypornosc BOOLEAN;  
    vCzyStarczyPaliwa BOOLEAN;  
BEGIN  
    vCzyPortMaMiejsce := CzyPortMaMiejsce(:NEW.ID_PORTU_DOCELOWEGO);  
    IF NOT vCzyPortMaMiejsce THEN  
        RAISE_APPLICATION_ERROR(-20001, 'Port docelowy nie ma dostępnych miejsc.');  
    END IF;  
  
    vCzyZalogaMaKapitana := CzyZalogaMaKapitana(:NEW.NR_ZALOGI);  
    IF NOT vCzyZalogaMaKapitana THEN  
        RAISE_APPLICATION_ERROR(-20002, 'Załoga nie posiada kapitana.');  
    END IF;  
  
    vCzyZalogaIPasazerowieSieZmieszcza := CzyZalogaIPasazerowieSieZmiesci(:NEW.NR_ZALOGI, :NEW.NR_SER_STATKU, :NEW.ID_ZALADUNKU);  
    IF NOT vCzyZalogaIPasazerowieSieZmieszcza THEN  
        RAISE_APPLICATION_ERROR(-20003, 'Załoga i pasażerowie nie zmieszczą się na statku.');  
    END IF;

    vCzyZalogaWolna := CzyZalogaWolna(:NEW.NR_ZALOGI, :NEW.NR_KURSU);  
    IF NOT vCzyZalogaWolna THEN  
        RAISE_APPLICATION_ERROR(-20005, 'Załoga jest zajęta innym kursem.');  
    END IF;   
  
    vCzyCzlonkowieZalogiWolni := CzyCzlonkowieZalogiWolni(:NEW.NR_ZALOGI, :NEW.DATA_ROZPOCZECIA);  
    IF NOT vCzyCzlonkowieZalogiWolni THEN  
        RAISE_APPLICATION_ERROR(-20004, 'Członkowie załogi są zajęci innym kursem.');  
    END IF;   
  
    vCzyStatekWolny := CzyStatekWolny(:NEW.NR_SER_STATKU, :NEW.NR_KURSU);  
    IF NOT vCzyStatekWolny THEN  
        RAISE_APPLICATION_ERROR(-20006, 'Statek jest zajęty innym kursem.');  
    END IF;  
 
    vCzyStatekDoplynie := CzyStatekDoplynie(:NEW.NR_SER_STATKU, :NEW.ID_PORTU_DOCELOWEGO);  
    IF NOT vCzyStarczyPaliwa THEN  
        RAISE_APPLICATION_ERROR(-20009, 'Wybrana jednostka ma zbyt mały zasięg, żeby dopłynąć do wybranego portu docelowego.');  
    END IF;  
  
    vCzyWagaSpelniaWypornosc := czyWagaSpelniaWypornosc(:NEW.ID_ZALADUNKU, :NEW.NR_ZALOGI, :NEW.NR_SER_STATKU);  
    IF NOT vCzyWagaSpelniaWypornosc THEN  
        RAISE_APPLICATION_ERROR(-20007, 'Waga załadunku i załogi przekracza wyporność statku.');  
    END IF;  
  
    vCzyStarczyPaliwa := CzyStarczyPaliwa(:NEW.NR_SER_STATKU, :NEW.ID_PORTU_DOCELOWEGO);  
    IF NOT vCzyStarczyPaliwa THEN  
        RAISE_APPLICATION_ERROR(-20008, 'Nie ma wystarczającej ilości budżetu, aby statek mógł dotrzeć do celu. sprwadź budżet przeznaczony na dane paliwo.');  
    END IF;  
END TRG_KURSY_BEFORE_INSERT;
/
ALTER TRIGGER "TRG_KURSY_BEFORE_INSERT" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_BEFORE_UPDATE_LISTA_STATEK_ZALOGA" 
BEFORE UPDATE OF ID_ZALADUNKU, NR_SER_STATKU, NR_ZALOGI
ON KURSY
FOR EACH ROW
DECLARE
    vCzySpelniaWypornosc BOOLEAN;
    vCzyZalogaIPasazerowieSieZmieszcza BOOLEAN;
    vCzyZalogaMaKapitana BOOLEAN;
    vCzyStatekDoplynie BOOLEAN;
    vCzyStarczyPaliwa BOOLEAN;
    vCzyZalogaWolna BOOLEAN;
    vCzyStatekWolny BOOLEAN;
BEGIN
    vCzyZalogaWolna := CzyZalogaWolna(:NEW.NR_ZALOGI, :NEW.NR_KURSU);  
    IF NOT vCzyZalogaWolna THEN  
        RAISE_APPLICATION_ERROR(-20005, 'Załoga jest zajęta innym kursem. Zalecane odświeżenie formularza.');  
    END IF;  

    vCzyStatekWolny := CzyStatekWolny(:NEW.NR_SER_STATKU, :NEW.NR_KURSU);  
    IF NOT vCzyStatekWolny THEN  
        RAISE_APPLICATION_ERROR(-20006, 'Statek jest zajęty innym kursem. Zalecane odświeżenie formularza.');  
    END IF;  

    vCzyZalogaIPasazerowieSieZmieszcza := czyZalogaIPasazerowieSieZmiesci(:NEW.NR_ZALOGI, :NEW.NR_SER_STATKU, :NEW.ID_ZALADUNKU);
    IF NOT vCzyZalogaIPasazerowieSieZmieszcza THEN
        RAISE_APPLICATION_ERROR(-20003, 'Załoga i pasażerowie nie zmieszczą się na statku.');  
    END IF;

    vCzySpelniaWypornosc := czyWagaSpelniaWypornosc(:NEW.ID_ZALADUNKU, :NEW.NR_ZALOGI, :NEW.NR_SER_STATKU);  
    IF NOT vCzySpelniaWypornosc THEN  
        RAISE_APPLICATION_ERROR(-20007, 'Waga załadunku i przekracza wyporność statku.');  
    END IF;

    vCzyZalogaMaKapitana := CzyZalogaMaKapitana(:NEW.NR_ZALOGI);  
    IF NOT vCzyZalogaMaKapitana THEN  
        RAISE_APPLICATION_ERROR(-20002, 'Załoga nie posiada kapitana.');  
    END IF;  

    vCzyStatekDoplynie := CzyStatekDoplynie(:NEW.NR_SER_STATKU, :NEW.ID_PORTU_DOCELOWEGO);  
    IF NOT vCzyStatekDoplynie THEN  
        RAISE_APPLICATION_ERROR(-20009, 'Wybrana jednostka ma zbyt mały zasięg, żeby dopłynąć do wybranego portu docelowego.');  
    END IF;  

    vCzyStarczyPaliwa := CzyStarczyPaliwa(:NEW.NR_SER_STATKU, :NEW.ID_PORTU_DOCELOWEGO);  
    IF NOT vCzyStarczyPaliwa THEN  
        RAISE_APPLICATION_ERROR(-20008, 'Nie ma wystarczającej ilości budżetu, aby statek mógł dotrzeć do celu. sprwadź budżet przeznaczony na dane paliwo.');  
    END IF;  
END;
/
ALTER TRIGGER "TRG_KURSY_BEFORE_UPDATE_LISTA_STATEK_ZALOGA" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_DELETE" 
AFTER DELETE ON KURSY
FOR EACH ROW
BEGIN
    IF :OLD.STATUS_ZAKONCZENIA = 0 THEN
        ZwolnijMiejsceWPorcie(:OLD.ID_PORTU_DOCELOWEGO);

        UPDATE LISTY_ZALADUNKOWE 
        SET CZY_UZYTA = 'NIE' 
        WHERE ID_ZALADUNKU = :OLD.ID_ZALADUNKU;

        oddajpaliwo(:OLD.NR_SER_STATKU, :OLD.ID_PORTU_DOCELOWEGO, :OLD.DATA_ROZPOCZECIA, :OLD.DATA_ZAKONCZENIA);
    END IF;


END;
/
ALTER TRIGGER "TRG_KURSY_DELETE" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_UPDATE_AFTER_STATEK" 
AFTER UPDATE OF NR_SER_STATKU
ON KURSY
FOR EACH ROW
BEGIN
    oddajpaliwo(:OLD.NR_SER_STATKU, :OLD.ID_PORTU_DOCELOWEGO, :NEW.DATA_ROZPOCZECIA, :NEW.DATA_ZAKONCZENIA);
END;
/
ALTER TRIGGER "TRG_KURSY_UPDATE_AFTER_STATEK" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_UPDATE_LISTA_PRZEWOZOWA" 
AFTER UPDATE OF ID_ZALADUNKU
ON KURSY
FOR EACH ROW
BEGIN
    IF :NEW.ID_ZALADUNKU != :OLD.ID_ZALADUNKU THEN
        UPDATE LISTY_ZALADUNKOWE 
        SET CZY_UZYTA = 'NIE' 
        WHERE ID_ZALADUNKU = :OLD.ID_ZALADUNKU;
        
        UPDATE LISTY_ZALADUNKOWE 
        SET CZY_UZYTA = 'TAK' 
        WHERE ID_ZALADUNKU = :NEW.ID_ZALADUNKU;
    END IF;
END;
/
ALTER TRIGGER "TRG_KURSY_UPDATE_LISTA_PRZEWOZOWA" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_UPDATE_PORT" 
AFTER UPDATE OF ID_PORTU_DOCELOWEGO
ON KURSY
FOR EACH ROW
BEGIN
    IF :NEW.STATUS_ZAKONCZENIA = 0 AND CzyPortMaMiejsce(:NEW.ID_PORTU_DOCELOWEGO) THEN
        ZwolnijMiejsceWPorcie(:OLD.ID_PORTU_DOCELOWEGO);
        OdejmijDostepneMiejscaWPorcie(:NEW.ID_PORTU_DOCELOWEGO);
    END IF;
END;
/
ALTER TRIGGER "TRG_KURSY_UPDATE_PORT" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_UPDATE_PORT_BEFORE" 
BEFORE UPDATE OF ID_PORTU_DOCELOWEGO
ON KURSY
FOR EACH ROW
BEGIN
    IF :NEW.STATUS_ZAKONCZENIA = 0 AND NOT CzyPortMaMiejsce(:NEW.ID_PORTU_DOCELOWEGO) THEN
        RAISE_APPLICATION_ERROR(-20001, 'W wybranym porcie nie ma wolnych miejsc.');
    END IF;
END;
/
ALTER TRIGGER "TRG_KURSY_UPDATE_PORT_BEFORE" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_UPDATE_STATUS_KURSU" 
AFTER UPDATE OF STATUS_ZAKONCZENIA
ON KURSY
FOR EACH ROW
DECLARE
    vPortId NUMBER;
BEGIN
    IF :OLD.STATUS_ZAKONCZENIA = 0 AND :NEW.STATUS_ZAKONCZENIA = 1 THEN
        ZwolnijMiejsceWPorcie(:NEW.ID_PORTU_DOCELOWEGO);

    ELSIF :OLD.STATUS_ZAKONCZENIA = 1 AND :NEW.STATUS_ZAKONCZENIA = 0 THEN
        OdejmijDostepneMiejscaWPorcie(:NEW.ID_PORTU_DOCELOWEGO);
    END IF;
END;
/
ALTER TRIGGER "TRG_UPDATE_STATUS_KURSU" ENABLE;

  CREATE INDEX "I_MLOG$_KURSY" ON "MLOG$_KURSY" ("XID$$") 
  ;

   COMMENT ON TABLE "MLOG$_KURSY"  IS 'snapshot log for master table WKSP_WS155963.KURSY';

   COMMENT ON MATERIALIZED VIEW "MV_KURSY"  IS 'snapshot table for snapshot WKSP_WS155963.MV_KURSY';

  ALTER TABLE "PASAZEROWIE" ADD CONSTRAINT "FK_ID_ZALADUNKU_PAS" FOREIGN KEY ("ID_ZALADUNKU")
	  REFERENCES "LISTY_ZALADUNKOWE" ("ID_ZALADUNKU") ON DELETE CASCADE ENABLE;

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_PASAZEROWIE_BEFORE_INSERT" 
    BEFORE INSERT ON PASAZEROWIE 
    FOR EACH ROW 
DECLARE 
    cnt_pesel NUMBER; 
BEGIN 
    SELECT COUNT(*) INTO cnt_pesel 
    FROM PASAZEROWIE 
    WHERE PESEL = :NEW.PESEL 
      AND (IMIE != :NEW.IMIE OR NAZWISKO != :NEW.NAZWISKO); 
 
    IF cnt_pesel > 0 THEN 
        RAISE_APPLICATION_ERROR(-20001, 'PESEL należy już do innej osoby.'); 
    END IF; 
END; 

/
ALTER TRIGGER "TRG_PASAZEROWIE_BEFORE_INSERT" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_PASAZEROWIE_CHECK_PESEL_VALID" 
BEFORE INSERT OR UPDATE ON PASAZEROWIE
FOR EACH ROW
BEGIN
    IF NOT REGEXP_LIKE(:NEW.PESEL, '^[0-9]{11}$') THEN
        RAISE_APPLICATION_ERROR(-20011, 'PESEL musi składać się z dokładnie 11 cyfr.');
    END IF;
END;
/
ALTER TRIGGER "TRG_PASAZEROWIE_CHECK_PESEL_VALID" ENABLE;

  ALTER TABLE "PRACOWNICY_ZALOGI_ROLE" ADD CONSTRAINT "FK_ID_PRAC" FOREIGN KEY ("ID_PRAC")
	  REFERENCES "PRACOWNICY" ("ID_PRAC") ON DELETE CASCADE ENABLE;
  ALTER TABLE "PRACOWNICY_ZALOGI_ROLE" ADD CONSTRAINT "FK_ID_ROLI" FOREIGN KEY ("ID_ROLI")
	  REFERENCES "ROLE_PRACOWNIKOW" ("ID_ROLI") ON DELETE CASCADE ENABLE;
  ALTER TABLE "PRACOWNICY_ZALOGI_ROLE" ADD CONSTRAINT "FK_NR_ZALOGI" FOREIGN KEY ("NR_ZALOGI")
	  REFERENCES "ZALOGI" ("NR_ZALOGI") ON DELETE CASCADE ENABLE;

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_BLK_ZMIANY_ZALOGI" 
BEFORE DELETE OR UPDATE ON PRACOWNICY_ZALOGI_ROLE
FOR EACH ROW
DECLARE
    vCzyZalogaWolna BOOLEAN;
BEGIN
    vCzyZalogaWolna := CzyZalogaWolna_og(:OLD.NR_ZALOGI);

    IF NOT vCzyZalogaWolna THEN
        RAISE_APPLICATION_ERROR(-20005, 'Nie można edytować ani usuwać załogi, która ma aktywny rejs.');
    END IF;
END TRG_BLK_ZMIANY_ZALOGI;
/
ALTER TRIGGER "TRG_BLK_ZMIANY_ZALOGI" ENABLE;

  ALTER TABLE "STATKI" ADD CONSTRAINT "FK_TYP_PALIWA_MAG" FOREIGN KEY ("TYP_PALIWA")
	  REFERENCES "MAGAZYN_PALIWA" ("TYP_PALIWA") ENABLE;

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_BLK_ZMIANY_STATKU" 
BEFORE DELETE OR UPDATE ON STATKI
FOR EACH ROW
DECLARE
    vCzyStatekWolny BOOLEAN;
BEGIN
    vCzyStatekWolny := CzyStatekWolny_og(:OLD.NUMER_SERYJNY);

    IF NOT vCzyStatekWolny THEN
        RAISE_APPLICATION_ERROR(-20011, 'Nie można edytować ani usuwać jednostki transportowej, który ma aktywny rejs.');
    END IF;
END TRG_BLK_ZMIANY_STATKU;
/
ALTER TRIGGER "TRG_BLK_ZMIANY_STATKU" ENABLE;

  ALTER TABLE "ZAKUPY" ADD CONSTRAINT "FK_TYP_PALIWA_MAG_ZAK" FOREIGN KEY ("TYP_PALIWA_MAG")
	  REFERENCES "MAGAZYN_PALIWA" ("TYP_PALIWA") ENABLE;
  ALTER TABLE "ZAKUPY" ADD CONSTRAINT "FK_TYP_PALIWA_RAF" FOREIGN KEY ("TYP_PALIWA_RAF")
	  REFERENCES "RAFINERIA" ("TYP_PALIWA") ENABLE;

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_ZAKUPY_AFTER_INSERT" 
    AFTER INSERT ON ZAKUPY 
    FOR EACH ROW 
BEGIN 
UPDATE MAGAZYN_PALIWA 
SET 
    BUDZET_ZL = BUDZET_ZL - :NEW.KOSZT_RAZEM, 
    ILOSC_L = ILOSC_L + :NEW.ILOSC_KUPIONEGO_L 
    WHERE TYP_PALIWA = :NEW.TYP_PALIWA_RAF; 
END; 

/
ALTER TRIGGER "TRG_ZAKUPY_AFTER_INSERT" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_ZAKUPY_AFTER_UPDATE" 
after 
update on "ZAKUPY" 
for each row 
declare 
    vRoznicaKoszt number; 
    vRoznicaL number; 
begin 
    vRoznicaKoszt := :OLD.KOSZT_RAZEM - :NEW.KOSZT_RAZEM; 
    vRoznicaL := :OLD.ILOSC_KUPIONEGO_L - :NEW.ILOSC_KUPIONEGO_L; 
    UPDATE MAGAZYN_PALIWA  
SET  
    BUDZET_ZL = BUDZET_ZL + vRoznicaKoszt,  
    ILOSC_L = ILOSC_L - vRoznicaL  
    WHERE TYP_PALIWA = :NEW.TYP_PALIWA_RAF;  
end; 

/
ALTER TRIGGER "TRG_ZAKUPY_AFTER_UPDATE" ENABLE;
create or replace FUNCTION CzyCzlonkowieZalogiWolni( 
    vNrZalogi NUMBER, 
    vDataRozpoczecia TIMESTAMP 
) RETURN BOOLEAN IS 
    lLiczbaKolidujacych NUMBER; 
BEGIN 
    SELECT COUNT(*) INTO lLiczbaKolidujacych 
        FROM PRACOWNICY_ZALOGI_ROLE pzr 
            JOIN KURSY k ON pzr.NR_ZALOGI = k.NR_ZALOGI 
        WHERE pzr.NR_ZALOGI = vNrZalogi AND k.STATUS_ZAKONCZENIA = 0; 
 
    RETURN lLiczbaKolidujacych = 0; 
END CzyCzlonkowieZalogiWolni;
/
create or replace FUNCTION CzyPortMaMiejsce(vIdPortu NUMBER) RETURN BOOLEAN IS 
    lDostepneMiejsca NUMBER; 
BEGIN 
    SELECT L_DOSTEPNYCH_MIEJSC INTO lDostepneMiejsca  
        FROM PORTY_DOCELOWE WHERE ID_PORTU = vIdPortu; 
 
    RETURN lDostepneMiejsca > 0; 
END CzyPortMaMiejsce; 
/
create or replace FUNCTION CzyStarczyPaliwa( 
    vNumerSeryjny IN NUMBER, 
    vIdPortu IN NUMBER 
) RETURN BOOLEAN IS 
    lMaxDystansKm NUMBER; 
    lOdlegloscKm NUMBER; 
    lSpalaniePaliwa NUMBER; 
    lTypPaliwa VARCHAR2(50); 
    lWymaganePaliwo NUMBER; 
    lDostepnePaliwo NUMBER; 
    lCenaZaLitr NUMBER; 
    lIloscDoZakupu NUMBER; 
    lKosztZakupu NUMBER; 
    lBudzet NUMBER; 
BEGIN 
    SELECT MAX_DYSTANS_KM, SPALANIE_PALIWA_L, TYP_PALIWA 
    INTO lMaxDystansKm, lSpalaniePaliwa, lTypPaliwa 
        FROM STATKI WHERE NUMER_SERYJNY = vNumerSeryjny; 
 
    SELECT ODLEGLOSC_KM INTO lOdlegloscKm 
        FROM PORTY_DOCELOWE WHERE ID_PORTU = vIdPortu; 
 
    IF lOdlegloscKm > lMaxDystansKm THEN 
        RETURN FALSE; 
    END IF; 
 
    lWymaganePaliwo := lSpalaniePaliwa * lOdlegloscKm; 
 
    SELECT ILOSC_L, BUDZET_ZL INTO lDostepnePaliwo, lBudzet 
        FROM MAGAZYN_PALIWA WHERE TYP_PALIWA = lTypPaliwa; 
 
    IF lDostepnePaliwo < lWymaganePaliwo THEN 
        lIloscDoZakupu := lWymaganePaliwo - lDostepnePaliwo; 
 
        SELECT CENA_ZL_L INTO lCenaZaLitr 
            FROM RAFINERIA WHERE TYP_PALIWA = lTypPaliwa; 
 
        lKosztZakupu := lIloscDoZakupu * lCenaZaLitr; 
 
        IF lKosztZakupu > lBudzet THEN 
            RETURN FALSE; 
        END IF; 
 
        INSERT INTO ZAKUPY (ILOSC_KUPIONEGO_L, KOSZT_RAZEM, TYP_PALIWA_RAF, TYP_PALIWA_MAG) 
        VALUES (lIloscDoZakupu, lKosztZakupu, lTypPaliwa, lTypPaliwa); 
 
    END IF; 
 
    UPDATE MAGAZYN_PALIWA 
        SET ILOSC_L = ILOSC_L - lWymaganePaliwo 
        WHERE TYP_PALIWA = lTypPaliwa; 
 
    RETURN TRUE; 
END CzyStarczyPaliwa;
/
create or replace function "CZYSTARCZYPALIWASHORTENED"(
    vNumerSeryjny IN NUMBER, 
    vIdPortu IN NUMBER 
) RETURN BOOLEAN IS 
    lOdlegloscKm NUMBER; 
    lSpalaniePaliwa NUMBER; 
    lTypPaliwa VARCHAR2(50); 
    lWymaganePaliwo NUMBER; 
    lDostepnePaliwo NUMBER; 
    lCenaZaLitr NUMBER; 
    lIloscDoZakupu NUMBER; 
    lKosztZakupu NUMBER; 
    lBudzet NUMBER; 
BEGIN 
    SELECT SPALANIE_PALIWA_L, TYP_PALIWA 
    INTO lSpalaniePaliwa, lTypPaliwa 
        FROM STATKI WHERE NUMER_SERYJNY = vNumerSeryjny; 
 
    SELECT ODLEGLOSC_KM INTO lOdlegloscKm 
        FROM PORTY_DOCELOWE WHERE ID_PORTU = vIdPortu; 
 
    lWymaganePaliwo := lSpalaniePaliwa * lOdlegloscKm; 
 
    SELECT ILOSC_L, BUDZET_ZL INTO lDostepnePaliwo, lBudzet 
        FROM MAGAZYN_PALIWA WHERE TYP_PALIWA = lTypPaliwa; 
 
    IF lDostepnePaliwo < lWymaganePaliwo THEN 
        lIloscDoZakupu := lWymaganePaliwo - lDostepnePaliwo; 
 
        SELECT CENA_ZL_L INTO lCenaZaLitr 
            FROM RAFINERIA WHERE TYP_PALIWA = lTypPaliwa; 
 
        lKosztZakupu := lIloscDoZakupu * lCenaZaLitr; 
 
        IF lKosztZakupu > lBudzet THEN 
            RETURN FALSE; 
        END IF; 
    END IF; 
 
    RETURN TRUE; 
END "CZYSTARCZYPALIWASHORTENED";
/
create or replace function "CZYSTATEKDOPLYNIE"(
    vNumerSeryjny IN NUMBER, 
    vIdPortu IN NUMBER 
) RETURN BOOLEAN IS 
    lMaxDystansKm NUMBER; 
    lOdlegloscKm NUMBER; 
BEGIN 
    SELECT MAX_DYSTANS_KM
    INTO lMaxDystansKm
        FROM STATKI WHERE NUMER_SERYJNY = vNumerSeryjny; 
 
    SELECT ODLEGLOSC_KM INTO lOdlegloscKm 
        FROM PORTY_DOCELOWE WHERE ID_PORTU = vIdPortu; 
 
    IF lOdlegloscKm > lMaxDystansKm THEN 
        RETURN FALSE; 
    END IF; 
 
    RETURN TRUE; 
END "CZYSTATEKDOPLYNIE";
/
create or replace FUNCTION CzyStatekWolny(
    vNrSerStatku NUMBER,
    vIdKursu NUMBER
) RETURN BOOLEAN IS
    lLiczbaKolidujacych NUMBER;
BEGIN
    SELECT COUNT(*) INTO lLiczbaKolidujacych
    FROM MV_KURSY
    WHERE NR_SER_STATKU = vNrSerStatku
      AND STATUS_ZAKONCZENIA = 0
      AND NR_KURSU != vIdKursu;

    RETURN lLiczbaKolidujacych = 0;
END CzyStatekWolny;
/
create or replace FUNCTION CZYSTATEKWOLNY_DISPLAY( 
    vNrSerStatku NUMBER, 
    vDataRozpoczecia TIMESTAMP 
) RETURN VARCHAR2 IS 
    lLiczbaKolidujacych NUMBER; 
BEGIN 
    SELECT COUNT(*) INTO lLiczbaKolidujacych 
    FROM KURSY WHERE NR_SER_STATKU = vNrSerStatku 
            AND STATUS_ZAKONCZENIA = 0; 
 
    IF lLiczbaKolidujacych = 0 THEN RETURN 'Wolny';
    ELSE RETURN 'Zajęty';
    END IF; 
END CZYSTATEKWOLNY_DISPLAY;
/
create or replace FUNCTION CzyStatekWolny_og(
    vNrSerStatku NUMBER
) RETURN BOOLEAN IS
    lLiczbaKolidujacych NUMBER;
BEGIN
    SELECT COUNT(*) INTO lLiczbaKolidujacych
        FROM KURSY WHERE NR_SER_STATKU = vNrSerStatku
        AND STATUS_ZAKONCZENIA=0;

    RETURN lLiczbaKolidujacych = 0;
END CzyStatekWolny_og;
/
create or replace FUNCTION czyWagaSpelniaWypornosc( 
    vidZaladunku NUMBER,  
    vNrZalogi NUMBER,  
    vNrSeryjnyStatku NUMBER 
) RETURN BOOLEAN IS 
    lWagaPasazerowIZalogi NUMBER; 
    lWagaTowaru NUMBER; 
    lWypornosc NUMBER; 
BEGIN 
    lWagaPasazerowIZalogi := ((LiczbaZalogiIPasazerow(vNrZalogi, vidZaladunku) * 100) / 1000); 
 
    SELECT SUM(WAGA_TONY) INTO lWagaTowaru  
        FROM KONTENERY WHERE ID_ZALADUNKU = vidZaladunku; 
 
    SELECT  WYPORNOSC_TONA INTO lWypornosc  
        FROM statki WHERE NUMER_SERYJNY = vNrSeryjnyStatku; 
 
    RETURN lWagaPasazerowIZalogi + lWagaTowaru <= lWypornosc; 
END czyWagaSpelniaWypornosc;
/
create or replace FUNCTION CzyZalogaIPasazerowieSieZmiesci( 
    vNrZalogi NUMBER,  
    vStatekId NUMBER,  
    vidZaladunku NUMBER 
) RETURN BOOLEAN IS 
    lLiczbaZalogiIPasazerow NUMBER; 
    lMaxPasazerow NUMBER; 
BEGIN 
    lLiczbaZalogiIPasazerow := LiczbaZalogiIPasazerow(vNrZalogi, vidZaladunku); 
 
    SELECT MAX_L_PASAZEROW INTO lMaxPasazerow 
        FROM STATKI WHERE NUMER_SERYJNY = vStatekId; 
 
    RETURN lLiczbaZalogiIPasazerow <= lMaxPasazerow; 
END CzyZalogaIPasazerowieSieZmiesci;
/
create or replace FUNCTION CzyZalogaMaKapitana(vNrZalogi NUMBER) RETURN BOOLEAN IS 
    lKapitanCount NUMBER; 
BEGIN 
    SELECT COUNT(*) INTO lKapitanCount 
        FROM PRACOWNICY_ZALOGI_ROLE WHERE NR_ZALOGI = vNrZalogi AND ID_ROLI = 
                                (SELECT ID_ROLI FROM ROLE_PRACOWNIKOW WHERE NAZWA = 'Kapitan'); 
 
    RETURN lKapitanCount > 0; 
END CzyZalogaMaKapitana;
/
create or replace FUNCTION CzyZalogaWolna( 
    vNrZalogi NUMBER, 
    vIdKursu NUMBER
) RETURN BOOLEAN IS 
    lLiczbaKolidujacych NUMBER; 
BEGIN 
    SELECT COUNT(*) INTO lLiczbaKolidujacych
    FROM MV_KURSY
    WHERE NR_ZALOGI = vNrZalogi
      AND STATUS_ZAKONCZENIA = 0
      AND NR_KURSU != vIdKursu; 
 
    RETURN lLiczbaKolidujacych = 0; 
END CzyZalogaWolna;
/
create or replace FUNCTION CzyZalogaWolna_og(
    vNrZalogi NUMBER
) RETURN BOOLEAN IS
    lLiczbaKolidujacych NUMBER;
BEGIN
    SELECT COUNT(*) INTO lLiczbaKolidujacych 
        FROM KURSY WHERE NR_ZALOGI = vNrZalogi
        AND STATUS_ZAKONCZENIA=0;

    RETURN lLiczbaKolidujacych = 0;
END CzyZalogaWolna_og;
/
create or replace FUNCTION get_port_details(p_id_portu IN NUMBER) 
RETURN CLOB 
IS
    v_html CLOB;
    v_l_dostepnych_miejsc PORTY_DOCELOWE.L_DOSTEPNYCH_MIEJSC%TYPE;
    v_czas_obslugi_na_tone_h PORTY_DOCELOWE.CZAS_OBSLUGI_NA_TONE_H%TYPE;
    v_odleglosc_km PORTY_DOCELOWE.ODLEGLOSC_KM%TYPE;
BEGIN
    SELECT L_DOSTEPNYCH_MIEJSC, CZAS_OBSLUGI_NA_TONE_H, ODLEGLOSC_KM
    INTO v_l_dostepnych_miejsc, v_czas_obslugi_na_tone_h, v_odleglosc_km
    FROM PORTY_DOCELOWE
    WHERE ID_PORTU = p_id_portu;

    v_html := 
        '<div class="form-details">' ||
        '   <div class="form-detail-box">' ||
        '       <p><strong>Liczba dostępnych miejsc:</strong> ' || v_l_dostepnych_miejsc || '</p>' ||
        '       <p><strong>Prędkość obsługi [T/h]:</strong> ' || v_czas_obslugi_na_tone_h || '</p>' ||
        '       <p><strong>Odległość [km]:</strong> ' || v_odleglosc_km || '</p>' ||
        '   </div>' ||
        '</div>';

    RETURN v_html;
END get_port_details;
/
create or replace FUNCTION LiczbaZalogiIPasazerow( 
    vNrZalogi NUMBER,  
    vidZaladunku NUMBER 
) RETURN NUMBER IS 
    lLiczbaPracownikow NUMBER; 
    lLiczbaPasazerow NUMBER; 
BEGIN 
    SELECT COUNT(*) INTO lLiczbaPracownikow 
        FROM PRACOWNICY_ZALOGI_ROLE WHERE NR_ZALOGI = vNrZalogi; 
 
    SELECT COUNT(*) INTO lLiczbaPasazerow 
        FROM PASAZEROWIE WHERE id_zaladunku = vidZaladunku; 
 
    RETURN lLiczbaPracownikow + lLiczbaPasazerow; 
END LiczbaZalogiIPasazerow;
/
create or replace FUNCTION ObliczCzasZakonczenia( 
    vOdleglosc NUMBER,  
    vCzasZaladunku NUMBER 
) RETURN TIMESTAMP IS 
    lCzasPodrozy NUMBER; 
BEGIN 
    lCzasPodrozy := vOdleglosc * 0.5; 
 
    RETURN SYSTIMESTAMP + NUMTODSINTERVAL(lCzasPodrozy + vCzasZaladunku, 'HOUR'); 
END ObliczCzasZakonczenia; 
/















































































































  CREATE INDEX "I_MLOG$_KURSY" ON "MLOG$_KURSY" ("XID$$") 
  ;

  CREATE UNIQUE INDEX "PK_KONTENERY" ON "KONTENERY" ("NR_KONTENERA") 
  ;

  CREATE UNIQUE INDEX "PK_KURSY" ON "KURSY" ("NR_KURSU") 
  ;

  CREATE UNIQUE INDEX "PK_LISTY_ZALADUNKOWE" ON "LISTY_ZALADUNKOWE" ("ID_ZALADUNKU") 
  ;

  CREATE UNIQUE INDEX "PK_MAGAZYN_PALIWA" ON "MAGAZYN_PALIWA" ("TYP_PALIWA") 
  ;

  CREATE UNIQUE INDEX "PK_PASAZEROWIE" ON "PASAZEROWIE" ("ID_PASAZERA") 
  ;

  CREATE UNIQUE INDEX "PK_PORTY_DOCELOWE" ON "PORTY_DOCELOWE" ("ID_PORTU") 
  ;

  CREATE UNIQUE INDEX "PK_PRACOWNICY" ON "PRACOWNICY" ("ID_PRAC") 
  ;

  CREATE UNIQUE INDEX "PK_PRACOWNICY_ZALOGI_ROLE" ON "PRACOWNICY_ZALOGI_ROLE" ("NR_PRZYPISANIA") 
  ;

  CREATE UNIQUE INDEX "PK_RAFINERIA" ON "RAFINERIA" ("TYP_PALIWA") 
  ;

  CREATE UNIQUE INDEX "PK_ROLE" ON "ROLE_PRACOWNIKOW" ("ID_ROLI") 
  ;

  CREATE UNIQUE INDEX "PK_STATKI" ON "STATKI" ("NUMER_SERYJNY") 
  ;

  CREATE UNIQUE INDEX "PK_WLASCICIELE" ON "WLASCICIELE" ("ID_WLASCICIELA") 
  ;

  CREATE UNIQUE INDEX "PK_ZAKUPY" ON "ZAKUPY" ("NR_FAKTURY") 
  ;

  CREATE UNIQUE INDEX "PK_ZALOGI" ON "ZALOGI" ("NR_ZALOGI") 
  ;

  CREATE UNIQUE INDEX "SYS_C_SNAP$_41PK_KURSY" ON "MV_KURSY" ("NR_KURSU") 
  ;

  CREATE UNIQUE INDEX "UQ_PESEL_ZALADUNEK" ON "PASAZEROWIE" ("PESEL", "ID_ZALADUNKU") 
  ;

  CREATE UNIQUE INDEX "UQ_PRACOWNICY_ZALOGI_ROLE" ON "PRACOWNICY_ZALOGI_ROLE" ("ID_PRAC", "NR_ZALOGI") 
  ;



































create or replace package insum_error_handler_api is


function error_handler 
   (p_error in apex_error.t_error
   ) return apex_error.t_error_result
;    


end insum_error_handler_api;
/






























































































































create or replace procedure oddajpaliwo( 
    vNumerSeryjny IN NUMBER, 
    vIdPortu IN NUMBER,
    vDataZlecenia IN TIMESTAMP,
    vDataZakonczenia IN TIMESTAMP
) IS 
    lOdlegloscKm NUMBER; 
    lSpalaniePaliwa NUMBER; 
    lTypPaliwa VARCHAR2(50); 
    lWymaganePaliwo NUMBER;
    lCzasTrasy NUMBER;                   
    lCzasMiniony NUMBER;               
    lProcentTrasy NUMBER;        
    lPaliwoZuzyte NUMBER;          
    lPaliwoPozostale NUMBER;   
BEGIN 
    SELECT SPALANIE_PALIWA_L, TYP_PALIWA 
        INTO lSpalaniePaliwa, lTypPaliwa 
        FROM STATKI WHERE NUMER_SERYJNY = vNumerSeryjny; 
 
    SELECT ODLEGLOSC_KM INTO lOdlegloscKm 
        FROM PORTY_DOCELOWE WHERE ID_PORTU = vIdPortu; 
 
    lWymaganePaliwo := lSpalaniePaliwa * lOdlegloscKm; 

    lCzasTrasy := 
        EXTRACT(SECOND FROM vDataZakonczenia - vDataZlecenia)
        + EXTRACT(MINUTE FROM vDataZakonczenia - vDataZlecenia) * 60
        + EXTRACT(HOUR FROM vDataZakonczenia - vDataZlecenia) * 3600
        + EXTRACT(DAY FROM vDataZakonczenia - vDataZlecenia) * 86400;

    lCzasMiniony := 
        LEAST(
            EXTRACT(SECOND FROM SYSTIMESTAMP - vDataZlecenia)
            + EXTRACT(MINUTE FROM SYSTIMESTAMP - vDataZlecenia) * 60
            + EXTRACT(HOUR FROM SYSTIMESTAMP - vDataZlecenia) * 3600
            + EXTRACT(DAY FROM SYSTIMESTAMP - vDataZlecenia) * 86400,
            lCzasTrasy
        );
    
    IF lCzasMiniony=lCzasTrasy THEN
        lCzasMiniony:=0;
    END IF;
    
    lProcentTrasy := lCzasMiniony / lCzasTrasy;
    lPaliwoZuzyte := lWymaganePaliwo * lProcentTrasy;
    lPaliwoPozostale := lWymaganePaliwo - lPaliwoZuzyte;
 
    UPDATE MAGAZYN_PALIWA 
        SET ILOSC_L = ILOSC_L + lPaliwoPozostale
        WHERE TYP_PALIWA = lTypPaliwa;  
END oddajpaliwo;
/
create or replace PROCEDURE OdejmijDostepneMiejscaWPorcie( 
    vIdPortu IN NUMBER 
) IS 
BEGIN 
    UPDATE PORTY_DOCELOWE 
        SET L_DOSTEPNYCH_MIEJSC = L_DOSTEPNYCH_MIEJSC - 1 
        WHERE ID_PORTU = vIdPortu; 
 
    IF SQL%ROWCOUNT = 0 THEN 
        RAISE_APPLICATION_ERROR(-20001, 'Nie udało się zaktualizować liczby miejsc w porcie docelowym.'); 
    END IF; 
END OdejmijDostepneMiejscaWPorcie; 
/
create or replace PROCEDURE ZWOLNIJMIEJSCEWPORCIE( 
    vIdPortu IN NUMBER 
) IS 
BEGIN 
    UPDATE PORTY_DOCELOWE 
        SET L_DOSTEPNYCH_MIEJSC = L_DOSTEPNYCH_MIEJSC + 1 
        WHERE ID_PORTU = vIdPortu; 
 
    IF SQL%ROWCOUNT = 0 THEN 
        RAISE_APPLICATION_ERROR(-20001, 'Nie udało się zaktualizować liczby miejsc w porcie docelowym.'); 
    END IF; 
END ZWOLNIJMIEJSCEWPORCIE;
/
























































































   CREATE SEQUENCE  "KURSY_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 31 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;

   CREATE SEQUENCE  "L_ZALADUNKOWA_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 310 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;

   CREATE SEQUENCE  "SEQ_NR_SER_STATKU"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1000 START WITH 12001 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;














































































































create or replace trigger TRG_BLK_ZMIANY_STATKU
BEFORE DELETE OR UPDATE ON STATKI
FOR EACH ROW
DECLARE
    vCzyStatekWolny BOOLEAN;
BEGIN
    vCzyStatekWolny := CzyStatekWolny_og(:OLD.NUMER_SERYJNY);

    IF NOT vCzyStatekWolny THEN
        RAISE_APPLICATION_ERROR(-20011, 'Nie można edytować ani usuwać jednostki transportowej, który ma aktywny rejs.');
    END IF;
END TRG_BLK_ZMIANY_STATKU;
/
create or replace TRIGGER TRG_BLK_ZMIANY_ZALOGI
BEFORE DELETE OR UPDATE ON PRACOWNICY_ZALOGI_ROLE
FOR EACH ROW
DECLARE
    vCzyZalogaWolna BOOLEAN;
BEGIN
    vCzyZalogaWolna := CzyZalogaWolna_og(:OLD.NR_ZALOGI);

    IF NOT vCzyZalogaWolna THEN
        RAISE_APPLICATION_ERROR(-20005, 'Nie można edytować ani usuwać załogi, która ma aktywny rejs.');
    END IF;
END TRG_BLK_ZMIANY_ZALOGI;
/
create or replace TRIGGER trg_check_port_availability
BEFORE UPDATE OF DATA_ZAKONCZENIA
ON KURSY
FOR EACH ROW
DECLARE
    vCzyPortMaMiejsce BOOLEAN;
BEGIN
    IF :NEW.DATA_ZAKONCZENIA > SYSTIMESTAMP AND :OLD.STATUS_ZAKONCZENIA=1 THEN
        vCzyPortMaMiejsce := CzyPortMaMiejsce(:NEW.ID_PORTU_DOCELOWEGO); 
        
        IF NOT vCzyPortMaMiejsce THEN
            RAISE_APPLICATION_ERROR(-20001, 'Zmiana daty wymusza wznowienie zlecenia, ale nie ma dostępnego miejsca w porcie docelowym.');
        END IF;
    END IF;
END;
/
create or replace TRIGGER TRG_KURSY_AFTER_INSERT 
    AFTER INSERT ON KURSY 
    FOR EACH ROW 
BEGIN 
    OdejmijDostepneMiejscaWPorcie(:NEW.ID_PORTU_DOCELOWEGO); 
    UPDATE LISTY_ZALADUNKOWE SET CZY_UZYTA = 'TAK' WHERE ID_ZALADUNKU = :NEW.ID_ZALADUNKU; 
END TRG_KURSY_AFTER_INSERT; 
/
create or replace TRIGGER TRG_KURSY_BEFORE_INSERT  
    BEFORE INSERT ON KURSY  
    FOR EACH ROW  
DECLARE  
    vCzyStatekDoplynie BOOLEAN; 
    vCzyPortMaMiejsce BOOLEAN;  
    vCzyZalogaMaKapitana BOOLEAN;  
    vCzyZalogaIPasazerowieSieZmieszcza BOOLEAN;  
    vCzyCzlonkowieZalogiWolni BOOLEAN;  
    vCzyZalogaWolna BOOLEAN;  
    vCzyStatekWolny BOOLEAN;  
    vCzyWagaSpelniaWypornosc BOOLEAN;  
    vCzyStarczyPaliwa BOOLEAN;  
BEGIN  
    vCzyPortMaMiejsce := CzyPortMaMiejsce(:NEW.ID_PORTU_DOCELOWEGO);  
    IF NOT vCzyPortMaMiejsce THEN  
        RAISE_APPLICATION_ERROR(-20001, 'Port docelowy nie ma dostępnych miejsc.');  
    END IF;  
  
    vCzyZalogaMaKapitana := CzyZalogaMaKapitana(:NEW.NR_ZALOGI);  
    IF NOT vCzyZalogaMaKapitana THEN  
        RAISE_APPLICATION_ERROR(-20002, 'Załoga nie posiada kapitana.');  
    END IF;  
  
    vCzyZalogaIPasazerowieSieZmieszcza := CzyZalogaIPasazerowieSieZmiesci(:NEW.NR_ZALOGI, :NEW.NR_SER_STATKU, :NEW.ID_ZALADUNKU);  
    IF NOT vCzyZalogaIPasazerowieSieZmieszcza THEN  
        RAISE_APPLICATION_ERROR(-20003, 'Załoga i pasażerowie nie zmieszczą się na statku.');  
    END IF;

    vCzyZalogaWolna := CzyZalogaWolna(:NEW.NR_ZALOGI, :NEW.NR_KURSU);  
    IF NOT vCzyZalogaWolna THEN  
        RAISE_APPLICATION_ERROR(-20005, 'Załoga jest zajęta innym kursem.');  
    END IF;   
  
    vCzyCzlonkowieZalogiWolni := CzyCzlonkowieZalogiWolni(:NEW.NR_ZALOGI, :NEW.DATA_ROZPOCZECIA);  
    IF NOT vCzyCzlonkowieZalogiWolni THEN  
        RAISE_APPLICATION_ERROR(-20004, 'Członkowie załogi są zajęci innym kursem.');  
    END IF;   
  
    vCzyStatekWolny := CzyStatekWolny(:NEW.NR_SER_STATKU, :NEW.NR_KURSU);  
    IF NOT vCzyStatekWolny THEN  
        RAISE_APPLICATION_ERROR(-20006, 'Statek jest zajęty innym kursem.');  
    END IF;  
 
    vCzyStatekDoplynie := CzyStatekDoplynie(:NEW.NR_SER_STATKU, :NEW.ID_PORTU_DOCELOWEGO);  
    IF NOT vCzyStarczyPaliwa THEN  
        RAISE_APPLICATION_ERROR(-20009, 'Wybrana jednostka ma zbyt mały zasięg, żeby dopłynąć do wybranego portu docelowego.');  
    END IF;  
  
    vCzyWagaSpelniaWypornosc := czyWagaSpelniaWypornosc(:NEW.ID_ZALADUNKU, :NEW.NR_ZALOGI, :NEW.NR_SER_STATKU);  
    IF NOT vCzyWagaSpelniaWypornosc THEN  
        RAISE_APPLICATION_ERROR(-20007, 'Waga załadunku i załogi przekracza wyporność statku.');  
    END IF;  
  
    vCzyStarczyPaliwa := CzyStarczyPaliwa(:NEW.NR_SER_STATKU, :NEW.ID_PORTU_DOCELOWEGO);  
    IF NOT vCzyStarczyPaliwa THEN  
        RAISE_APPLICATION_ERROR(-20008, 'Nie ma wystarczającej ilości budżetu, aby statek mógł dotrzeć do celu. sprwadź budżet przeznaczony na dane paliwo.');  
    END IF;  
END TRG_KURSY_BEFORE_INSERT;
/
create or replace TRIGGER trg_kursy_before_update_lista_statek_zaloga
BEFORE UPDATE OF ID_ZALADUNKU, NR_SER_STATKU, NR_ZALOGI
ON KURSY
FOR EACH ROW
DECLARE
    vCzySpelniaWypornosc BOOLEAN;
    vCzyZalogaIPasazerowieSieZmieszcza BOOLEAN;
    vCzyZalogaMaKapitana BOOLEAN;
    vCzyStatekDoplynie BOOLEAN;
    vCzyStarczyPaliwa BOOLEAN;
    vCzyZalogaWolna BOOLEAN;
    vCzyStatekWolny BOOLEAN;
BEGIN
    vCzyZalogaWolna := CzyZalogaWolna(:NEW.NR_ZALOGI, :NEW.NR_KURSU);  
    IF NOT vCzyZalogaWolna THEN  
        RAISE_APPLICATION_ERROR(-20005, 'Załoga jest zajęta innym kursem. Zalecane odświeżenie formularza.');  
    END IF;  

    vCzyStatekWolny := CzyStatekWolny(:NEW.NR_SER_STATKU, :NEW.NR_KURSU);  
    IF NOT vCzyStatekWolny THEN  
        RAISE_APPLICATION_ERROR(-20006, 'Statek jest zajęty innym kursem. Zalecane odświeżenie formularza.');  
    END IF;  

    vCzyZalogaIPasazerowieSieZmieszcza := czyZalogaIPasazerowieSieZmiesci(:NEW.NR_ZALOGI, :NEW.NR_SER_STATKU, :NEW.ID_ZALADUNKU);
    IF NOT vCzyZalogaIPasazerowieSieZmieszcza THEN
        RAISE_APPLICATION_ERROR(-20003, 'Załoga i pasażerowie nie zmieszczą się na statku.');  
    END IF;

    vCzySpelniaWypornosc := czyWagaSpelniaWypornosc(:NEW.ID_ZALADUNKU, :NEW.NR_ZALOGI, :NEW.NR_SER_STATKU);  
    IF NOT vCzySpelniaWypornosc THEN  
        RAISE_APPLICATION_ERROR(-20007, 'Waga załadunku i przekracza wyporność statku.');  
    END IF;

    vCzyZalogaMaKapitana := CzyZalogaMaKapitana(:NEW.NR_ZALOGI);  
    IF NOT vCzyZalogaMaKapitana THEN  
        RAISE_APPLICATION_ERROR(-20002, 'Załoga nie posiada kapitana.');  
    END IF;  

    vCzyStatekDoplynie := CzyStatekDoplynie(:NEW.NR_SER_STATKU, :NEW.ID_PORTU_DOCELOWEGO);  
    IF NOT vCzyStatekDoplynie THEN  
        RAISE_APPLICATION_ERROR(-20009, 'Wybrana jednostka ma zbyt mały zasięg, żeby dopłynąć do wybranego portu docelowego.');  
    END IF;  

    vCzyStarczyPaliwa := CzyStarczyPaliwa(:NEW.NR_SER_STATKU, :NEW.ID_PORTU_DOCELOWEGO);  
    IF NOT vCzyStarczyPaliwa THEN  
        RAISE_APPLICATION_ERROR(-20008, 'Nie ma wystarczającej ilości budżetu, aby statek mógł dotrzeć do celu. sprwadź budżet przeznaczony na dane paliwo.');  
    END IF;  
END;
/
create or replace TRIGGER trg_kursy_delete
AFTER DELETE ON KURSY
FOR EACH ROW
BEGIN
    IF :OLD.STATUS_ZAKONCZENIA = 0 THEN
        ZwolnijMiejsceWPorcie(:OLD.ID_PORTU_DOCELOWEGO);

        UPDATE LISTY_ZALADUNKOWE 
        SET CZY_UZYTA = 'NIE' 
        WHERE ID_ZALADUNKU = :OLD.ID_ZALADUNKU;

        oddajpaliwo(:OLD.NR_SER_STATKU, :OLD.ID_PORTU_DOCELOWEGO, :OLD.DATA_ROZPOCZECIA, :OLD.DATA_ZAKONCZENIA);
    END IF;


END;
/
create or replace TRIGGER TRG_KURSY_UPDATE_AFTER_STATEK
AFTER UPDATE OF NR_SER_STATKU
ON KURSY
FOR EACH ROW
BEGIN
    oddajpaliwo(:OLD.NR_SER_STATKU, :OLD.ID_PORTU_DOCELOWEGO, :NEW.DATA_ROZPOCZECIA, :NEW.DATA_ZAKONCZENIA);
END;
/
create or replace TRIGGER trg_kursy_update_lista_przewozowa
AFTER UPDATE OF ID_ZALADUNKU
ON KURSY
FOR EACH ROW
BEGIN
    IF :NEW.ID_ZALADUNKU != :OLD.ID_ZALADUNKU THEN
        UPDATE LISTY_ZALADUNKOWE 
        SET CZY_UZYTA = 'NIE' 
        WHERE ID_ZALADUNKU = :OLD.ID_ZALADUNKU;
        
        UPDATE LISTY_ZALADUNKOWE 
        SET CZY_UZYTA = 'TAK' 
        WHERE ID_ZALADUNKU = :NEW.ID_ZALADUNKU;
    END IF;
END;
/
create or replace TRIGGER trg_kursy_update_port
AFTER UPDATE OF ID_PORTU_DOCELOWEGO
ON KURSY
FOR EACH ROW
BEGIN
    IF :NEW.STATUS_ZAKONCZENIA = 0 AND CzyPortMaMiejsce(:NEW.ID_PORTU_DOCELOWEGO) THEN
        ZwolnijMiejsceWPorcie(:OLD.ID_PORTU_DOCELOWEGO);
        OdejmijDostepneMiejscaWPorcie(:NEW.ID_PORTU_DOCELOWEGO);
    END IF;
END;
/
create or replace TRIGGER trg_kursy_update_port_before
BEFORE UPDATE OF ID_PORTU_DOCELOWEGO
ON KURSY
FOR EACH ROW
BEGIN
    IF :NEW.STATUS_ZAKONCZENIA = 0 AND NOT CzyPortMaMiejsce(:NEW.ID_PORTU_DOCELOWEGO) THEN
        RAISE_APPLICATION_ERROR(-20001, 'W wybranym porcie nie ma wolnych miejsc.');
    END IF;
END;
/
create or replace TRIGGER TRG_PASAZEROWIE_BEFORE_INSERT 
    BEFORE INSERT ON PASAZEROWIE 
    FOR EACH ROW 
DECLARE 
    cnt_pesel NUMBER; 
BEGIN 
    SELECT COUNT(*) INTO cnt_pesel 
    FROM PASAZEROWIE 
    WHERE PESEL = :NEW.PESEL 
      AND (IMIE != :NEW.IMIE OR NAZWISKO != :NEW.NAZWISKO); 
 
    IF cnt_pesel > 0 THEN 
        RAISE_APPLICATION_ERROR(-20001, 'PESEL należy już do innej osoby.'); 
    END IF; 
END; 
/
create or replace TRIGGER TRG_PASAZEROWIE_CHECK_PESEL_VALID
BEFORE INSERT OR UPDATE ON PASAZEROWIE
FOR EACH ROW
BEGIN
    IF NOT REGEXP_LIKE(:NEW.PESEL, '^[0-9]{11}$') THEN
        RAISE_APPLICATION_ERROR(-20011, 'PESEL musi składać się z dokładnie 11 cyfr.');
    END IF;
END;
/
create or replace TRIGGER trg_update_status_kursu
AFTER UPDATE OF STATUS_ZAKONCZENIA
ON KURSY
FOR EACH ROW
DECLARE
    vPortId NUMBER;
BEGIN
    IF :OLD.STATUS_ZAKONCZENIA = 0 AND :NEW.STATUS_ZAKONCZENIA = 1 THEN
        ZwolnijMiejsceWPorcie(:NEW.ID_PORTU_DOCELOWEGO);

    ELSIF :OLD.STATUS_ZAKONCZENIA = 1 AND :NEW.STATUS_ZAKONCZENIA = 0 THEN
        OdejmijDostepneMiejscaWPorcie(:NEW.ID_PORTU_DOCELOWEGO);
    END IF;
END;
/
create or replace TRIGGER TRG_ZAKUPY_AFTER_INSERT 
    AFTER INSERT ON ZAKUPY 
    FOR EACH ROW 
BEGIN 
UPDATE MAGAZYN_PALIWA 
SET 
    BUDZET_ZL = BUDZET_ZL - :NEW.KOSZT_RAZEM, 
    ILOSC_L = ILOSC_L + :NEW.ILOSC_KUPIONEGO_L 
    WHERE TYP_PALIWA = :NEW.TYP_PALIWA_RAF; 
END; 
/
create or replace trigger "TRG_ZAKUPY_AFTER_UPDATE" 
after 
update on "ZAKUPY" 
for each row 
declare 
    vRoznicaKoszt number; 
    vRoznicaL number; 
begin 
    vRoznicaKoszt := :OLD.KOSZT_RAZEM - :NEW.KOSZT_RAZEM; 
    vRoznicaL := :OLD.ILOSC_KUPIONEGO_L - :NEW.ILOSC_KUPIONEGO_L; 
    UPDATE MAGAZYN_PALIWA  
SET  
    BUDZET_ZL = BUDZET_ZL + vRoznicaKoszt,  
    ILOSC_L = ILOSC_L - vRoznicaL  
    WHERE TYP_PALIWA = :NEW.TYP_PALIWA_RAF;  
end; 
/


  CREATE OR REPLACE FORCE EDITIONABLE VIEW "BUDZETY_NA_PALIWO" ("TYP_PALIWA", "BUDZET_ZL") AS 
  select typ_paliwa, budzet_zl from magazyn_paliwa;

   COMMENT ON MATERIALIZED VIEW "MV_KURSY"  IS 'snapshot table for snapshot WKSP_WS155963.MV_KURSY';

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_CHECK_PORT_AVAILABILITY" 
BEFORE UPDATE OF DATA_ZAKONCZENIA
ON KURSY
FOR EACH ROW
DECLARE
    vCzyPortMaMiejsce BOOLEAN;
BEGIN
    IF :NEW.DATA_ZAKONCZENIA > SYSTIMESTAMP AND :OLD.STATUS_ZAKONCZENIA=1 THEN
        vCzyPortMaMiejsce := CzyPortMaMiejsce(:NEW.ID_PORTU_DOCELOWEGO); 
        
        IF NOT vCzyPortMaMiejsce THEN
            RAISE_APPLICATION_ERROR(-20001, 'Zmiana daty wymusza wznowienie zlecenia, ale nie ma dostępnego miejsca w porcie docelowym.');
        END IF;
    END IF;
END;
/
ALTER TRIGGER "TRG_CHECK_PORT_AVAILABILITY" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_AFTER_INSERT" 
    AFTER INSERT ON KURSY 
    FOR EACH ROW 
BEGIN 
    OdejmijDostepneMiejscaWPorcie(:NEW.ID_PORTU_DOCELOWEGO); 
    UPDATE LISTY_ZALADUNKOWE SET CZY_UZYTA = 'TAK' WHERE ID_ZALADUNKU = :NEW.ID_ZALADUNKU; 
END TRG_KURSY_AFTER_INSERT; 

/
ALTER TRIGGER "TRG_KURSY_AFTER_INSERT" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_BEFORE_INSERT" 
    BEFORE INSERT ON KURSY  
    FOR EACH ROW  
DECLARE  
    vCzyStatekDoplynie BOOLEAN; 
    vCzyPortMaMiejsce BOOLEAN;  
    vCzyZalogaMaKapitana BOOLEAN;  
    vCzyZalogaIPasazerowieSieZmieszcza BOOLEAN;  
    vCzyCzlonkowieZalogiWolni BOOLEAN;  
    vCzyZalogaWolna BOOLEAN;  
    vCzyStatekWolny BOOLEAN;  
    vCzyWagaSpelniaWypornosc BOOLEAN;  
    vCzyStarczyPaliwa BOOLEAN;  
BEGIN  
    vCzyPortMaMiejsce := CzyPortMaMiejsce(:NEW.ID_PORTU_DOCELOWEGO);  
    IF NOT vCzyPortMaMiejsce THEN  
        RAISE_APPLICATION_ERROR(-20001, 'Port docelowy nie ma dostępnych miejsc.');  
    END IF;  
  
    vCzyZalogaMaKapitana := CzyZalogaMaKapitana(:NEW.NR_ZALOGI);  
    IF NOT vCzyZalogaMaKapitana THEN  
        RAISE_APPLICATION_ERROR(-20002, 'Załoga nie posiada kapitana.');  
    END IF;  
  
    vCzyZalogaIPasazerowieSieZmieszcza := CzyZalogaIPasazerowieSieZmiesci(:NEW.NR_ZALOGI, :NEW.NR_SER_STATKU, :NEW.ID_ZALADUNKU);  
    IF NOT vCzyZalogaIPasazerowieSieZmieszcza THEN  
        RAISE_APPLICATION_ERROR(-20003, 'Załoga i pasażerowie nie zmieszczą się na statku.');  
    END IF;

    vCzyZalogaWolna := CzyZalogaWolna(:NEW.NR_ZALOGI, :NEW.NR_KURSU);  
    IF NOT vCzyZalogaWolna THEN  
        RAISE_APPLICATION_ERROR(-20005, 'Załoga jest zajęta innym kursem.');  
    END IF;   
  
    vCzyCzlonkowieZalogiWolni := CzyCzlonkowieZalogiWolni(:NEW.NR_ZALOGI, :NEW.DATA_ROZPOCZECIA);  
    IF NOT vCzyCzlonkowieZalogiWolni THEN  
        RAISE_APPLICATION_ERROR(-20004, 'Członkowie załogi są zajęci innym kursem.');  
    END IF;   
  
    vCzyStatekWolny := CzyStatekWolny(:NEW.NR_SER_STATKU, :NEW.NR_KURSU);  
    IF NOT vCzyStatekWolny THEN  
        RAISE_APPLICATION_ERROR(-20006, 'Statek jest zajęty innym kursem.');  
    END IF;  
 
    vCzyStatekDoplynie := CzyStatekDoplynie(:NEW.NR_SER_STATKU, :NEW.ID_PORTU_DOCELOWEGO);  
    IF NOT vCzyStarczyPaliwa THEN  
        RAISE_APPLICATION_ERROR(-20009, 'Wybrana jednostka ma zbyt mały zasięg, żeby dopłynąć do wybranego portu docelowego.');  
    END IF;  
  
    vCzyWagaSpelniaWypornosc := czyWagaSpelniaWypornosc(:NEW.ID_ZALADUNKU, :NEW.NR_ZALOGI, :NEW.NR_SER_STATKU);  
    IF NOT vCzyWagaSpelniaWypornosc THEN  
        RAISE_APPLICATION_ERROR(-20007, 'Waga załadunku i załogi przekracza wyporność statku.');  
    END IF;  
  
    vCzyStarczyPaliwa := CzyStarczyPaliwa(:NEW.NR_SER_STATKU, :NEW.ID_PORTU_DOCELOWEGO);  
    IF NOT vCzyStarczyPaliwa THEN  
        RAISE_APPLICATION_ERROR(-20008, 'Nie ma wystarczającej ilości budżetu, aby statek mógł dotrzeć do celu. sprwadź budżet przeznaczony na dane paliwo.');  
    END IF;  
END TRG_KURSY_BEFORE_INSERT;
/
ALTER TRIGGER "TRG_KURSY_BEFORE_INSERT" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_BEFORE_UPDATE_LISTA_STATEK_ZALOGA" 
BEFORE UPDATE OF ID_ZALADUNKU, NR_SER_STATKU, NR_ZALOGI
ON KURSY
FOR EACH ROW
DECLARE
    vCzySpelniaWypornosc BOOLEAN;
    vCzyZalogaIPasazerowieSieZmieszcza BOOLEAN;
    vCzyZalogaMaKapitana BOOLEAN;
    vCzyStatekDoplynie BOOLEAN;
    vCzyStarczyPaliwa BOOLEAN;
    vCzyZalogaWolna BOOLEAN;
    vCzyStatekWolny BOOLEAN;
BEGIN
    vCzyZalogaWolna := CzyZalogaWolna(:NEW.NR_ZALOGI, :NEW.NR_KURSU);  
    IF NOT vCzyZalogaWolna THEN  
        RAISE_APPLICATION_ERROR(-20005, 'Załoga jest zajęta innym kursem. Zalecane odświeżenie formularza.');  
    END IF;  

    vCzyStatekWolny := CzyStatekWolny(:NEW.NR_SER_STATKU, :NEW.NR_KURSU);  
    IF NOT vCzyStatekWolny THEN  
        RAISE_APPLICATION_ERROR(-20006, 'Statek jest zajęty innym kursem. Zalecane odświeżenie formularza.');  
    END IF;  

    vCzyZalogaIPasazerowieSieZmieszcza := czyZalogaIPasazerowieSieZmiesci(:NEW.NR_ZALOGI, :NEW.NR_SER_STATKU, :NEW.ID_ZALADUNKU);
    IF NOT vCzyZalogaIPasazerowieSieZmieszcza THEN
        RAISE_APPLICATION_ERROR(-20003, 'Załoga i pasażerowie nie zmieszczą się na statku.');  
    END IF;

    vCzySpelniaWypornosc := czyWagaSpelniaWypornosc(:NEW.ID_ZALADUNKU, :NEW.NR_ZALOGI, :NEW.NR_SER_STATKU);  
    IF NOT vCzySpelniaWypornosc THEN  
        RAISE_APPLICATION_ERROR(-20007, 'Waga załadunku i przekracza wyporność statku.');  
    END IF;

    vCzyZalogaMaKapitana := CzyZalogaMaKapitana(:NEW.NR_ZALOGI);  
    IF NOT vCzyZalogaMaKapitana THEN  
        RAISE_APPLICATION_ERROR(-20002, 'Załoga nie posiada kapitana.');  
    END IF;  

    vCzyStatekDoplynie := CzyStatekDoplynie(:NEW.NR_SER_STATKU, :NEW.ID_PORTU_DOCELOWEGO);  
    IF NOT vCzyStatekDoplynie THEN  
        RAISE_APPLICATION_ERROR(-20009, 'Wybrana jednostka ma zbyt mały zasięg, żeby dopłynąć do wybranego portu docelowego.');  
    END IF;  

    vCzyStarczyPaliwa := CzyStarczyPaliwa(:NEW.NR_SER_STATKU, :NEW.ID_PORTU_DOCELOWEGO);  
    IF NOT vCzyStarczyPaliwa THEN  
        RAISE_APPLICATION_ERROR(-20008, 'Nie ma wystarczającej ilości budżetu, aby statek mógł dotrzeć do celu. sprwadź budżet przeznaczony na dane paliwo.');  
    END IF;  
END;
/
ALTER TRIGGER "TRG_KURSY_BEFORE_UPDATE_LISTA_STATEK_ZALOGA" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_DELETE" 
AFTER DELETE ON KURSY
FOR EACH ROW
BEGIN
    IF :OLD.STATUS_ZAKONCZENIA = 0 THEN
        ZwolnijMiejsceWPorcie(:OLD.ID_PORTU_DOCELOWEGO);

        UPDATE LISTY_ZALADUNKOWE 
        SET CZY_UZYTA = 'NIE' 
        WHERE ID_ZALADUNKU = :OLD.ID_ZALADUNKU;

        oddajpaliwo(:OLD.NR_SER_STATKU, :OLD.ID_PORTU_DOCELOWEGO, :OLD.DATA_ROZPOCZECIA, :OLD.DATA_ZAKONCZENIA);
    END IF;


END;
/
ALTER TRIGGER "TRG_KURSY_DELETE" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_UPDATE_AFTER_STATEK" 
AFTER UPDATE OF NR_SER_STATKU
ON KURSY
FOR EACH ROW
BEGIN
    oddajpaliwo(:OLD.NR_SER_STATKU, :OLD.ID_PORTU_DOCELOWEGO, :NEW.DATA_ROZPOCZECIA, :NEW.DATA_ZAKONCZENIA);
END;
/
ALTER TRIGGER "TRG_KURSY_UPDATE_AFTER_STATEK" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_UPDATE_LISTA_PRZEWOZOWA" 
AFTER UPDATE OF ID_ZALADUNKU
ON KURSY
FOR EACH ROW
BEGIN
    IF :NEW.ID_ZALADUNKU != :OLD.ID_ZALADUNKU THEN
        UPDATE LISTY_ZALADUNKOWE 
        SET CZY_UZYTA = 'NIE' 
        WHERE ID_ZALADUNKU = :OLD.ID_ZALADUNKU;
        
        UPDATE LISTY_ZALADUNKOWE 
        SET CZY_UZYTA = 'TAK' 
        WHERE ID_ZALADUNKU = :NEW.ID_ZALADUNKU;
    END IF;
END;
/
ALTER TRIGGER "TRG_KURSY_UPDATE_LISTA_PRZEWOZOWA" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_UPDATE_PORT" 
AFTER UPDATE OF ID_PORTU_DOCELOWEGO
ON KURSY
FOR EACH ROW
BEGIN
    IF :NEW.STATUS_ZAKONCZENIA = 0 AND CzyPortMaMiejsce(:NEW.ID_PORTU_DOCELOWEGO) THEN
        ZwolnijMiejsceWPorcie(:OLD.ID_PORTU_DOCELOWEGO);
        OdejmijDostepneMiejscaWPorcie(:NEW.ID_PORTU_DOCELOWEGO);
    END IF;
END;
/
ALTER TRIGGER "TRG_KURSY_UPDATE_PORT" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_UPDATE_PORT_BEFORE" 
BEFORE UPDATE OF ID_PORTU_DOCELOWEGO
ON KURSY
FOR EACH ROW
BEGIN
    IF :NEW.STATUS_ZAKONCZENIA = 0 AND NOT CzyPortMaMiejsce(:NEW.ID_PORTU_DOCELOWEGO) THEN
        RAISE_APPLICATION_ERROR(-20001, 'W wybranym porcie nie ma wolnych miejsc.');
    END IF;
END;
/
ALTER TRIGGER "TRG_KURSY_UPDATE_PORT_BEFORE" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_UPDATE_STATUS_KURSU" 
AFTER UPDATE OF STATUS_ZAKONCZENIA
ON KURSY
FOR EACH ROW
DECLARE
    vPortId NUMBER;
BEGIN
    IF :OLD.STATUS_ZAKONCZENIA = 0 AND :NEW.STATUS_ZAKONCZENIA = 1 THEN
        ZwolnijMiejsceWPorcie(:NEW.ID_PORTU_DOCELOWEGO);

    ELSIF :OLD.STATUS_ZAKONCZENIA = 1 AND :NEW.STATUS_ZAKONCZENIA = 0 THEN
        OdejmijDostepneMiejscaWPorcie(:NEW.ID_PORTU_DOCELOWEGO);
    END IF;
END;
/
ALTER TRIGGER "TRG_UPDATE_STATUS_KURSU" ENABLE;

   COMMENT ON TABLE "MLOG$_KURSY"  IS 'snapshot log for master table WKSP_WS155963.KURSY';

   COMMENT ON MATERIALIZED VIEW "MV_KURSY"  IS 'snapshot table for snapshot WKSP_WS155963.MV_KURSY';

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_PASAZEROWIE_BEFORE_INSERT" 
    BEFORE INSERT ON PASAZEROWIE 
    FOR EACH ROW 
DECLARE 
    cnt_pesel NUMBER; 
BEGIN 
    SELECT COUNT(*) INTO cnt_pesel 
    FROM PASAZEROWIE 
    WHERE PESEL = :NEW.PESEL 
      AND (IMIE != :NEW.IMIE OR NAZWISKO != :NEW.NAZWISKO); 
 
    IF cnt_pesel > 0 THEN 
        RAISE_APPLICATION_ERROR(-20001, 'PESEL należy już do innej osoby.'); 
    END IF; 
END; 

/
ALTER TRIGGER "TRG_PASAZEROWIE_BEFORE_INSERT" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_PASAZEROWIE_CHECK_PESEL_VALID" 
BEFORE INSERT OR UPDATE ON PASAZEROWIE
FOR EACH ROW
BEGIN
    IF NOT REGEXP_LIKE(:NEW.PESEL, '^[0-9]{11}$') THEN
        RAISE_APPLICATION_ERROR(-20011, 'PESEL musi składać się z dokładnie 11 cyfr.');
    END IF;
END;
/
ALTER TRIGGER "TRG_PASAZEROWIE_CHECK_PESEL_VALID" ENABLE;

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_BLK_ZMIANY_ZALOGI" 
BEFORE DELETE OR UPDATE ON PRACOWNICY_ZALOGI_ROLE
FOR EACH ROW
DECLARE
    vCzyZalogaWolna BOOLEAN;
BEGIN
    vCzyZalogaWolna := CzyZalogaWolna_og(:OLD.NR_ZALOGI);

    IF NOT vCzyZalogaWolna THEN
        RAISE_APPLICATION_ERROR(-20005, 'Nie można edytować ani usuwać załogi, która ma aktywny rejs.');
    END IF;
END TRG_BLK_ZMIANY_ZALOGI;
/
ALTER TRIGGER "TRG_BLK_ZMIANY_ZALOGI" ENABLE;

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_BLK_ZMIANY_STATKU" 
BEFORE DELETE OR UPDATE ON STATKI
FOR EACH ROW
DECLARE
    vCzyStatekWolny BOOLEAN;
BEGIN
    vCzyStatekWolny := CzyStatekWolny_og(:OLD.NUMER_SERYJNY);

    IF NOT vCzyStatekWolny THEN
        RAISE_APPLICATION_ERROR(-20011, 'Nie można edytować ani usuwać jednostki transportowej, który ma aktywny rejs.');
    END IF;
END TRG_BLK_ZMIANY_STATKU;
/
ALTER TRIGGER "TRG_BLK_ZMIANY_STATKU" ENABLE;

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_ZAKUPY_AFTER_INSERT" 
    AFTER INSERT ON ZAKUPY 
    FOR EACH ROW 
BEGIN 
UPDATE MAGAZYN_PALIWA 
SET 
    BUDZET_ZL = BUDZET_ZL - :NEW.KOSZT_RAZEM, 
    ILOSC_L = ILOSC_L + :NEW.ILOSC_KUPIONEGO_L 
    WHERE TYP_PALIWA = :NEW.TYP_PALIWA_RAF; 
END; 

/
ALTER TRIGGER "TRG_ZAKUPY_AFTER_INSERT" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_ZAKUPY_AFTER_UPDATE" 
after 
update on "ZAKUPY" 
for each row 
declare 
    vRoznicaKoszt number; 
    vRoznicaL number; 
begin 
    vRoznicaKoszt := :OLD.KOSZT_RAZEM - :NEW.KOSZT_RAZEM; 
    vRoznicaL := :OLD.ILOSC_KUPIONEGO_L - :NEW.ILOSC_KUPIONEGO_L; 
    UPDATE MAGAZYN_PALIWA  
SET  
    BUDZET_ZL = BUDZET_ZL + vRoznicaKoszt,  
    ILOSC_L = ILOSC_L - vRoznicaL  
    WHERE TYP_PALIWA = :NEW.TYP_PALIWA_RAF;  
end; 

/
ALTER TRIGGER "TRG_ZAKUPY_AFTER_UPDATE" ENABLE;
































































































































  CREATE MATERIALIZED VIEW ""."MV_KURSY" ("NR_KURSU", "NR_SER_STATKU", "NR_ZALOGI", "STATUS_ZAKONCZENIA")
  SEGMENT CREATION IMMEDIATE
  ORGANIZATION HEAP PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_67630000068653694" 
  BUILD IMMEDIATE
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_67630000068653694" 
  REFRESH FAST ON COMMIT
  WITH PRIMARY KEY USING DEFAULT LOCAL ROLLBACK SEGMENT
  USING ENFORCED CONSTRAINTS DISABLE ON QUERY COMPUTATION DISABLE QUERY REWRITE
  AS SELECT NR_KURSU, NR_SER_STATKU, NR_ZALOGI, STATUS_ZAKONCZENIA
FROM KURSY;

  CREATE UNIQUE INDEX "SYS_C_SNAP$_41PK_KURSY" ON "MV_KURSY" ("NR_KURSU") 
  ;

   COMMENT ON MATERIALIZED VIEW "MV_KURSY"  IS 'snapshot table for snapshot WKSP_WS155963.MV_KURSY';

  CREATE UNIQUE INDEX "PK_KONTENERY" ON "KONTENERY" ("NR_KONTENERA") 
  ;

  CREATE UNIQUE INDEX "PK_KURSY" ON "KURSY" ("NR_KURSU") 
  ;

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_CHECK_PORT_AVAILABILITY" 
BEFORE UPDATE OF DATA_ZAKONCZENIA
ON KURSY
FOR EACH ROW
DECLARE
    vCzyPortMaMiejsce BOOLEAN;
BEGIN
    IF :NEW.DATA_ZAKONCZENIA > SYSTIMESTAMP AND :OLD.STATUS_ZAKONCZENIA=1 THEN
        vCzyPortMaMiejsce := CzyPortMaMiejsce(:NEW.ID_PORTU_DOCELOWEGO); 
        
        IF NOT vCzyPortMaMiejsce THEN
            RAISE_APPLICATION_ERROR(-20001, 'Zmiana daty wymusza wznowienie zlecenia, ale nie ma dostępnego miejsca w porcie docelowym.');
        END IF;
    END IF;
END;
/
ALTER TRIGGER "TRG_CHECK_PORT_AVAILABILITY" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_AFTER_INSERT" 
    AFTER INSERT ON KURSY 
    FOR EACH ROW 
BEGIN 
    OdejmijDostepneMiejscaWPorcie(:NEW.ID_PORTU_DOCELOWEGO); 
    UPDATE LISTY_ZALADUNKOWE SET CZY_UZYTA = 'TAK' WHERE ID_ZALADUNKU = :NEW.ID_ZALADUNKU; 
END TRG_KURSY_AFTER_INSERT; 

/
ALTER TRIGGER "TRG_KURSY_AFTER_INSERT" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_BEFORE_INSERT" 
    BEFORE INSERT ON KURSY  
    FOR EACH ROW  
DECLARE  
    vCzyStatekDoplynie BOOLEAN; 
    vCzyPortMaMiejsce BOOLEAN;  
    vCzyZalogaMaKapitana BOOLEAN;  
    vCzyZalogaIPasazerowieSieZmieszcza BOOLEAN;  
    vCzyCzlonkowieZalogiWolni BOOLEAN;  
    vCzyZalogaWolna BOOLEAN;  
    vCzyStatekWolny BOOLEAN;  
    vCzyWagaSpelniaWypornosc BOOLEAN;  
    vCzyStarczyPaliwa BOOLEAN;  
BEGIN  
    vCzyPortMaMiejsce := CzyPortMaMiejsce(:NEW.ID_PORTU_DOCELOWEGO);  
    IF NOT vCzyPortMaMiejsce THEN  
        RAISE_APPLICATION_ERROR(-20001, 'Port docelowy nie ma dostępnych miejsc.');  
    END IF;  
  
    vCzyZalogaMaKapitana := CzyZalogaMaKapitana(:NEW.NR_ZALOGI);  
    IF NOT vCzyZalogaMaKapitana THEN  
        RAISE_APPLICATION_ERROR(-20002, 'Załoga nie posiada kapitana.');  
    END IF;  
  
    vCzyZalogaIPasazerowieSieZmieszcza := CzyZalogaIPasazerowieSieZmiesci(:NEW.NR_ZALOGI, :NEW.NR_SER_STATKU, :NEW.ID_ZALADUNKU);  
    IF NOT vCzyZalogaIPasazerowieSieZmieszcza THEN  
        RAISE_APPLICATION_ERROR(-20003, 'Załoga i pasażerowie nie zmieszczą się na statku.');  
    END IF;

    vCzyZalogaWolna := CzyZalogaWolna(:NEW.NR_ZALOGI, :NEW.NR_KURSU);  
    IF NOT vCzyZalogaWolna THEN  
        RAISE_APPLICATION_ERROR(-20005, 'Załoga jest zajęta innym kursem.');  
    END IF;   
  
    vCzyCzlonkowieZalogiWolni := CzyCzlonkowieZalogiWolni(:NEW.NR_ZALOGI, :NEW.DATA_ROZPOCZECIA);  
    IF NOT vCzyCzlonkowieZalogiWolni THEN  
        RAISE_APPLICATION_ERROR(-20004, 'Członkowie załogi są zajęci innym kursem.');  
    END IF;   
  
    vCzyStatekWolny := CzyStatekWolny(:NEW.NR_SER_STATKU, :NEW.NR_KURSU);  
    IF NOT vCzyStatekWolny THEN  
        RAISE_APPLICATION_ERROR(-20006, 'Statek jest zajęty innym kursem.');  
    END IF;  
 
    vCzyStatekDoplynie := CzyStatekDoplynie(:NEW.NR_SER_STATKU, :NEW.ID_PORTU_DOCELOWEGO);  
    IF NOT vCzyStarczyPaliwa THEN  
        RAISE_APPLICATION_ERROR(-20009, 'Wybrana jednostka ma zbyt mały zasięg, żeby dopłynąć do wybranego portu docelowego.');  
    END IF;  
  
    vCzyWagaSpelniaWypornosc := czyWagaSpelniaWypornosc(:NEW.ID_ZALADUNKU, :NEW.NR_ZALOGI, :NEW.NR_SER_STATKU);  
    IF NOT vCzyWagaSpelniaWypornosc THEN  
        RAISE_APPLICATION_ERROR(-20007, 'Waga załadunku i załogi przekracza wyporność statku.');  
    END IF;  
  
    vCzyStarczyPaliwa := CzyStarczyPaliwa(:NEW.NR_SER_STATKU, :NEW.ID_PORTU_DOCELOWEGO);  
    IF NOT vCzyStarczyPaliwa THEN  
        RAISE_APPLICATION_ERROR(-20008, 'Nie ma wystarczającej ilości budżetu, aby statek mógł dotrzeć do celu. sprwadź budżet przeznaczony na dane paliwo.');  
    END IF;  
END TRG_KURSY_BEFORE_INSERT;
/
ALTER TRIGGER "TRG_KURSY_BEFORE_INSERT" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_BEFORE_UPDATE_LISTA_STATEK_ZALOGA" 
BEFORE UPDATE OF ID_ZALADUNKU, NR_SER_STATKU, NR_ZALOGI
ON KURSY
FOR EACH ROW
DECLARE
    vCzySpelniaWypornosc BOOLEAN;
    vCzyZalogaIPasazerowieSieZmieszcza BOOLEAN;
    vCzyZalogaMaKapitana BOOLEAN;
    vCzyStatekDoplynie BOOLEAN;
    vCzyStarczyPaliwa BOOLEAN;
    vCzyZalogaWolna BOOLEAN;
    vCzyStatekWolny BOOLEAN;
BEGIN
    vCzyZalogaWolna := CzyZalogaWolna(:NEW.NR_ZALOGI, :NEW.NR_KURSU);  
    IF NOT vCzyZalogaWolna THEN  
        RAISE_APPLICATION_ERROR(-20005, 'Załoga jest zajęta innym kursem. Zalecane odświeżenie formularza.');  
    END IF;  

    vCzyStatekWolny := CzyStatekWolny(:NEW.NR_SER_STATKU, :NEW.NR_KURSU);  
    IF NOT vCzyStatekWolny THEN  
        RAISE_APPLICATION_ERROR(-20006, 'Statek jest zajęty innym kursem. Zalecane odświeżenie formularza.');  
    END IF;  

    vCzyZalogaIPasazerowieSieZmieszcza := czyZalogaIPasazerowieSieZmiesci(:NEW.NR_ZALOGI, :NEW.NR_SER_STATKU, :NEW.ID_ZALADUNKU);
    IF NOT vCzyZalogaIPasazerowieSieZmieszcza THEN
        RAISE_APPLICATION_ERROR(-20003, 'Załoga i pasażerowie nie zmieszczą się na statku.');  
    END IF;

    vCzySpelniaWypornosc := czyWagaSpelniaWypornosc(:NEW.ID_ZALADUNKU, :NEW.NR_ZALOGI, :NEW.NR_SER_STATKU);  
    IF NOT vCzySpelniaWypornosc THEN  
        RAISE_APPLICATION_ERROR(-20007, 'Waga załadunku i przekracza wyporność statku.');  
    END IF;

    vCzyZalogaMaKapitana := CzyZalogaMaKapitana(:NEW.NR_ZALOGI);  
    IF NOT vCzyZalogaMaKapitana THEN  
        RAISE_APPLICATION_ERROR(-20002, 'Załoga nie posiada kapitana.');  
    END IF;  

    vCzyStatekDoplynie := CzyStatekDoplynie(:NEW.NR_SER_STATKU, :NEW.ID_PORTU_DOCELOWEGO);  
    IF NOT vCzyStatekDoplynie THEN  
        RAISE_APPLICATION_ERROR(-20009, 'Wybrana jednostka ma zbyt mały zasięg, żeby dopłynąć do wybranego portu docelowego.');  
    END IF;  

    vCzyStarczyPaliwa := CzyStarczyPaliwa(:NEW.NR_SER_STATKU, :NEW.ID_PORTU_DOCELOWEGO);  
    IF NOT vCzyStarczyPaliwa THEN  
        RAISE_APPLICATION_ERROR(-20008, 'Nie ma wystarczającej ilości budżetu, aby statek mógł dotrzeć do celu. sprwadź budżet przeznaczony na dane paliwo.');  
    END IF;  
END;
/
ALTER TRIGGER "TRG_KURSY_BEFORE_UPDATE_LISTA_STATEK_ZALOGA" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_DELETE" 
AFTER DELETE ON KURSY
FOR EACH ROW
BEGIN
    IF :OLD.STATUS_ZAKONCZENIA = 0 THEN
        ZwolnijMiejsceWPorcie(:OLD.ID_PORTU_DOCELOWEGO);

        UPDATE LISTY_ZALADUNKOWE 
        SET CZY_UZYTA = 'NIE' 
        WHERE ID_ZALADUNKU = :OLD.ID_ZALADUNKU;

        oddajpaliwo(:OLD.NR_SER_STATKU, :OLD.ID_PORTU_DOCELOWEGO, :OLD.DATA_ROZPOCZECIA, :OLD.DATA_ZAKONCZENIA);
    END IF;


END;
/
ALTER TRIGGER "TRG_KURSY_DELETE" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_UPDATE_AFTER_STATEK" 
AFTER UPDATE OF NR_SER_STATKU
ON KURSY
FOR EACH ROW
BEGIN
    oddajpaliwo(:OLD.NR_SER_STATKU, :OLD.ID_PORTU_DOCELOWEGO, :NEW.DATA_ROZPOCZECIA, :NEW.DATA_ZAKONCZENIA);
END;
/
ALTER TRIGGER "TRG_KURSY_UPDATE_AFTER_STATEK" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_UPDATE_LISTA_PRZEWOZOWA" 
AFTER UPDATE OF ID_ZALADUNKU
ON KURSY
FOR EACH ROW
BEGIN
    IF :NEW.ID_ZALADUNKU != :OLD.ID_ZALADUNKU THEN
        UPDATE LISTY_ZALADUNKOWE 
        SET CZY_UZYTA = 'NIE' 
        WHERE ID_ZALADUNKU = :OLD.ID_ZALADUNKU;
        
        UPDATE LISTY_ZALADUNKOWE 
        SET CZY_UZYTA = 'TAK' 
        WHERE ID_ZALADUNKU = :NEW.ID_ZALADUNKU;
    END IF;
END;
/
ALTER TRIGGER "TRG_KURSY_UPDATE_LISTA_PRZEWOZOWA" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_UPDATE_PORT" 
AFTER UPDATE OF ID_PORTU_DOCELOWEGO
ON KURSY
FOR EACH ROW
BEGIN
    IF :NEW.STATUS_ZAKONCZENIA = 0 AND CzyPortMaMiejsce(:NEW.ID_PORTU_DOCELOWEGO) THEN
        ZwolnijMiejsceWPorcie(:OLD.ID_PORTU_DOCELOWEGO);
        OdejmijDostepneMiejscaWPorcie(:NEW.ID_PORTU_DOCELOWEGO);
    END IF;
END;
/
ALTER TRIGGER "TRG_KURSY_UPDATE_PORT" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_KURSY_UPDATE_PORT_BEFORE" 
BEFORE UPDATE OF ID_PORTU_DOCELOWEGO
ON KURSY
FOR EACH ROW
BEGIN
    IF :NEW.STATUS_ZAKONCZENIA = 0 AND NOT CzyPortMaMiejsce(:NEW.ID_PORTU_DOCELOWEGO) THEN
        RAISE_APPLICATION_ERROR(-20001, 'W wybranym porcie nie ma wolnych miejsc.');
    END IF;
END;
/
ALTER TRIGGER "TRG_KURSY_UPDATE_PORT_BEFORE" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_UPDATE_STATUS_KURSU" 
AFTER UPDATE OF STATUS_ZAKONCZENIA
ON KURSY
FOR EACH ROW
DECLARE
    vPortId NUMBER;
BEGIN
    IF :OLD.STATUS_ZAKONCZENIA = 0 AND :NEW.STATUS_ZAKONCZENIA = 1 THEN
        ZwolnijMiejsceWPorcie(:NEW.ID_PORTU_DOCELOWEGO);

    ELSIF :OLD.STATUS_ZAKONCZENIA = 1 AND :NEW.STATUS_ZAKONCZENIA = 0 THEN
        OdejmijDostepneMiejscaWPorcie(:NEW.ID_PORTU_DOCELOWEGO);
    END IF;
END;
/
ALTER TRIGGER "TRG_UPDATE_STATUS_KURSU" ENABLE;

  CREATE UNIQUE INDEX "PK_LISTY_ZALADUNKOWE" ON "LISTY_ZALADUNKOWE" ("ID_ZALADUNKU") 
  ;

  CREATE UNIQUE INDEX "PK_MAGAZYN_PALIWA" ON "MAGAZYN_PALIWA" ("TYP_PALIWA") 
  ;

  CREATE INDEX "I_MLOG$_KURSY" ON "MLOG$_KURSY" ("XID$$") 
  ;

   COMMENT ON TABLE "MLOG$_KURSY"  IS 'snapshot log for master table WKSP_WS155963.KURSY';

  CREATE UNIQUE INDEX "SYS_C_SNAP$_41PK_KURSY" ON "MV_KURSY" ("NR_KURSU") 
  ;

   COMMENT ON MATERIALIZED VIEW "MV_KURSY"  IS 'snapshot table for snapshot WKSP_WS155963.MV_KURSY';

  CREATE UNIQUE INDEX "PK_PASAZEROWIE" ON "PASAZEROWIE" ("ID_PASAZERA") 
  ;
  CREATE UNIQUE INDEX "UQ_PESEL_ZALADUNEK" ON "PASAZEROWIE" ("PESEL", "ID_ZALADUNKU") 
  ;

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_PASAZEROWIE_BEFORE_INSERT" 
    BEFORE INSERT ON PASAZEROWIE 
    FOR EACH ROW 
DECLARE 
    cnt_pesel NUMBER; 
BEGIN 
    SELECT COUNT(*) INTO cnt_pesel 
    FROM PASAZEROWIE 
    WHERE PESEL = :NEW.PESEL 
      AND (IMIE != :NEW.IMIE OR NAZWISKO != :NEW.NAZWISKO); 
 
    IF cnt_pesel > 0 THEN 
        RAISE_APPLICATION_ERROR(-20001, 'PESEL należy już do innej osoby.'); 
    END IF; 
END; 

/
ALTER TRIGGER "TRG_PASAZEROWIE_BEFORE_INSERT" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_PASAZEROWIE_CHECK_PESEL_VALID" 
BEFORE INSERT OR UPDATE ON PASAZEROWIE
FOR EACH ROW
BEGIN
    IF NOT REGEXP_LIKE(:NEW.PESEL, '^[0-9]{11}$') THEN
        RAISE_APPLICATION_ERROR(-20011, 'PESEL musi składać się z dokładnie 11 cyfr.');
    END IF;
END;
/
ALTER TRIGGER "TRG_PASAZEROWIE_CHECK_PESEL_VALID" ENABLE;

  CREATE UNIQUE INDEX "PK_PORTY_DOCELOWE" ON "PORTY_DOCELOWE" ("ID_PORTU") 
  ;

  CREATE UNIQUE INDEX "PK_PRACOWNICY" ON "PRACOWNICY" ("ID_PRAC") 
  ;

  CREATE UNIQUE INDEX "PK_PRACOWNICY_ZALOGI_ROLE" ON "PRACOWNICY_ZALOGI_ROLE" ("NR_PRZYPISANIA") 
  ;
  CREATE UNIQUE INDEX "UQ_PRACOWNICY_ZALOGI_ROLE" ON "PRACOWNICY_ZALOGI_ROLE" ("ID_PRAC", "NR_ZALOGI") 
  ;

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_BLK_ZMIANY_ZALOGI" 
BEFORE DELETE OR UPDATE ON PRACOWNICY_ZALOGI_ROLE
FOR EACH ROW
DECLARE
    vCzyZalogaWolna BOOLEAN;
BEGIN
    vCzyZalogaWolna := CzyZalogaWolna_og(:OLD.NR_ZALOGI);

    IF NOT vCzyZalogaWolna THEN
        RAISE_APPLICATION_ERROR(-20005, 'Nie można edytować ani usuwać załogi, która ma aktywny rejs.');
    END IF;
END TRG_BLK_ZMIANY_ZALOGI;
/
ALTER TRIGGER "TRG_BLK_ZMIANY_ZALOGI" ENABLE;

  CREATE UNIQUE INDEX "PK_RAFINERIA" ON "RAFINERIA" ("TYP_PALIWA") 
  ;

  CREATE UNIQUE INDEX "PK_ROLE" ON "ROLE_PRACOWNIKOW" ("ID_ROLI") 
  ;

  CREATE UNIQUE INDEX "PK_STATKI" ON "STATKI" ("NUMER_SERYJNY") 
  ;

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_BLK_ZMIANY_STATKU" 
BEFORE DELETE OR UPDATE ON STATKI
FOR EACH ROW
DECLARE
    vCzyStatekWolny BOOLEAN;
BEGIN
    vCzyStatekWolny := CzyStatekWolny_og(:OLD.NUMER_SERYJNY);

    IF NOT vCzyStatekWolny THEN
        RAISE_APPLICATION_ERROR(-20011, 'Nie można edytować ani usuwać jednostki transportowej, który ma aktywny rejs.');
    END IF;
END TRG_BLK_ZMIANY_STATKU;
/
ALTER TRIGGER "TRG_BLK_ZMIANY_STATKU" ENABLE;

  CREATE UNIQUE INDEX "PK_WLASCICIELE" ON "WLASCICIELE" ("ID_WLASCICIELA") 
  ;

  CREATE UNIQUE INDEX "PK_ZAKUPY" ON "ZAKUPY" ("NR_FAKTURY") 
  ;

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_ZAKUPY_AFTER_INSERT" 
    AFTER INSERT ON ZAKUPY 
    FOR EACH ROW 
BEGIN 
UPDATE MAGAZYN_PALIWA 
SET 
    BUDZET_ZL = BUDZET_ZL - :NEW.KOSZT_RAZEM, 
    ILOSC_L = ILOSC_L + :NEW.ILOSC_KUPIONEGO_L 
    WHERE TYP_PALIWA = :NEW.TYP_PALIWA_RAF; 
END; 

/
ALTER TRIGGER "TRG_ZAKUPY_AFTER_INSERT" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_ZAKUPY_AFTER_UPDATE" 
after 
update on "ZAKUPY" 
for each row 
declare 
    vRoznicaKoszt number; 
    vRoznicaL number; 
begin 
    vRoznicaKoszt := :OLD.KOSZT_RAZEM - :NEW.KOSZT_RAZEM; 
    vRoznicaL := :OLD.ILOSC_KUPIONEGO_L - :NEW.ILOSC_KUPIONEGO_L; 
    UPDATE MAGAZYN_PALIWA  
SET  
    BUDZET_ZL = BUDZET_ZL + vRoznicaKoszt,  
    ILOSC_L = ILOSC_L - vRoznicaL  
    WHERE TYP_PALIWA = :NEW.TYP_PALIWA_RAF;  
end; 

/
ALTER TRIGGER "TRG_ZAKUPY_AFTER_UPDATE" ENABLE;

  CREATE UNIQUE INDEX "PK_ZALOGI" ON "ZALOGI" ("NR_ZALOGI") 
  ;



































create or replace package body insum_error_handler_api is

gc_developer_todo_message constant varchar2(100) := 'DEVELOPER TODO: Provide better message in APEX Shared Components Text Messages for ';

/* Create a message using apex_lang. This message can be managed using Shared Components -> Text Messages in APEX 
   Autonomous Transaction to not commit any other transactions that may happen in page
*/
function create_and_return_text_message 
   (p_constraint_name varchar2
   ) return varchar2 is
    PRAGMA AUTONOMOUS_TRANSACTION;  
    l_message varchar2(4000) :=  gc_developer_todo_message || p_constraint_name ;
begin
   apex_lang.create_message
      (p_application_id  => v('APP_ID'), /* This could be a common text library application */
       p_name            => p_constraint_name,
       p_language        => nvl(apex_util.get_preference('FSP_LANGUAGE_PREFERENCE'), 'en'),
       p_message_text    => l_message 
       );
       commit;
       return l_message;
end create_and_return_text_message;

function error_handler 
   (p_error in apex_error.t_error
   ) return apex_error.t_error_result is
    l_result          apex_error.t_error_result;
    l_reference_id    number;
    l_constraint_name varchar2(255);
begin
    l_result := apex_error.init_error_result (
                    p_error => p_error );

    -- If it's an internal error raised by APEX, like an invalid statement or
    -- code which can't be executed, the error text might contain security sensitive
    -- information. To avoid this security problem we can rewrite the error to
    -- a generic error message and log the original error message for further
    -- investigation by the help desk.
    if p_error.is_internal_error then
        -- mask all errors that are not common runtime errors (Access Denied
        -- errors raised by application / page authorization and all errors
        -- regarding session and session state)
        if not p_error.is_common_runtime_error then
            -- log error for example with an autonomous transaction and return
            -- l_reference_id as reference#
            -- l_reference_id := log_error (
            --                       p_error => p_error );
            --

            -- Change the message to the generic error message which doesn't expose
            -- any sensitive information.
            l_result.message         := 'An unexpected internal application error has occurred. '||
                                        'Please get in contact with XXX and provide '||
                                        'reference# '||to_char(l_reference_id, '999G999G999G990')||
                                        ' for further investigation.';
            l_result.additional_info := null;
        end if;
    else
        -- Always show the error as inline error
        -- Note: If you have created manual tabular forms (using the package
        --       apex_item/htmldb_item in the SQL statement) you should still
        --       use "On error page" on that pages to avoid loosing entered data
        l_result.display_location := case
                                       when l_result.display_location = apex_error.c_on_error_page then apex_error.c_inline_in_notification
                                       else l_result.display_location
                                     end;

        --
        -- Note: If you want to have friendlier ORA error messages, you can also define
        --       a text message with the name pattern APEX.ERROR.ORA-number
        --       There is no need to implement custom code for that.
        --

        -- If it's a constraint violation like
        --
        --   -) ORA-00001: unique constraint violated
        --   -) ORA-02091: transaction rolled back (-> can hide a deferred constraint)
        --   -) ORA-02290: check constraint violated
        --   -) ORA-02291: integrity constraint violated - parent key not found
        --   -) ORA-02292: integrity constraint violated - child record found
        --
        -- we try to get a friendly error message from our constraint lookup configuration.
        -- If we don't find the constraint in our lookup table we fallback to
        -- the original ORA error message.
        if p_error.ora_sqlcode in (-1, -2091, -2290, -2291, -2292) then
            l_constraint_name := apex_error.extract_constraint_name (
                                     p_error => p_error );
            /*
            begin
                select message
                  into l_result.message
                  from constraint_lookup
                 where constraint_name = l_constraint_name;
            exception when no_data_found then null; -- not every constraint has to be in our lookup table
            end;
            */

            -- Instant Tip - Error handler function 
            -- Hat tip to Roel https://roelhartman.blogspot.com/2021/02/stop-using-validations-for-checking.html
            -- Random Thoughts: I need to 'develop' some patience...fast... - Demetri Martin

            l_result.message := apex_lang.message(l_constraint_name); /* This could be from a common text library application */
                        
            if l_result.message = l_constraint_name then
               l_result.message := create_and_return_text_message (p_constraint_name => l_constraint_name);
            end if;   

            -- Random Thoughts: Every pizza is a personal pizza if you try hard and believe in yourself.. - Demetri Martin
            -- Instant Tip - Error handler function End      
        end if;

        -- If an ORA error has been raised, for example a raise_application_error(-20xxx, '...')
        -- in a table trigger or in a PL/SQL package called by a process and we
        -- haven't found the error in our lookup table, then we just want to see
        -- the actual error text and not the full error stack with all the ORA error numbers.
        if p_error.ora_sqlcode is not null and l_result.message = p_error.message then
            l_result.message := apex_error.get_first_ora_error_text (
                                    p_error => p_error );
        end if;

        -- If no associated page item/tabular form column has been set, we can use
        -- apex_error.auto_set_associated_item to automatically guess the affected
        -- error field by examine the ORA error for constraint names or column names.
        if l_result.page_item_name is null and l_result.column_alias is null then
            apex_error.auto_set_associated_item (
                p_error        => p_error,
                p_error_result => l_result );
        end if;
    end if;

    return l_result;
end error_handler;

end insum_error_handler_api;
/























































































































































































































