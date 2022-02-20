/********************************************************\ AUFGABE 1 \********************************************************/ 
-- Vfl Bochum - Vfl Osnabrück 2:1

update  tabelle
    set spiele = 14,
        siege =3,
        toreErzielt = 26,
        toreErhalten = 27
    where verein = 'VfL Bochum';

update tabelle
    set spiele = 14,
        niederlagen = 6,
        toreErzielt = 15,
        toreErhalten = 14
    where verein = 'VfL Osnabrück';


/********************************************************\ AUFGABE 2 \********************************************************/
-- Erzgebirge Aue - St. Pauli 1:1


 UPDATE  tabelle
    set spiele = spiele + 1,
        remis = remis + 1,
        toreErhalten = toreErhalten + 1,
        toreErzielt = toreErzielt + 1
    where verein = 'Erzgebirge Aue' or verein = 'FC St. Pauli';


/********************************************************\ AUFGABE 3 \********************************************************/
-- Hamburger SV - Dynamo Dresden 3:1


 update tabelle
    set spiele = spiele + 1,
        siege = siege + 1,
        toreErzielt = toreErzielt + 3,
        toreErhalten = toreErhalten + 1
    where verein = 'Hamburger SV';


update tabelle
    set spiele = spiele + 1,
        niederlagen = niederlagen+ 1,
        toreErzielt = toreErzielt + 1,
        toreErhalten = toreErhalten + 3
    where verein = 'Dynamo Dresden';


/********************************************************\ AUFGABE 4 \********************************************************/
-- Arminia Bielefeld -  SV Sandhause 4:2
 

 begin transaction;

    update tabelle
        set spiele = spiele + 1,
            siege = siege + 1,
            toreErhalten = toreErhalten + 2,
            toreErzielt = toreErzielt + 4
        where verein = 'Arminia Bielefeld'

    update tabelle
        set spiele = spiele + 1,
            niederlagen = niederlagen + 1,
            toreErzielt = toreErzielt + 2,
            toreErhalten = toreErhalten + 4
        where verein = 'SV Sandhausen';

 commit transaction; -- ACID!!

 begin transaction;

    update tabelle
        set spiele = spiele + 1,
            remis = remis + 1
        where verein = 'SV Wehen Wiesbaden'
        or verein = 'Holstein Kiel';
 commit transaction;

 begin transaction;

    update tabelle
        set spiele = spiele + 1,
            niederlagen = niederlagen + 1,
            toreErhalten = toreErhalten + 5
        where verein = 'VfB Stuttgart';

    update tabelle
        set spiele = spiele + 1,
            siege = siege + 1,
            toreErzielt = toreErzielt + 5
        where verein = 'Karlsruher SC';

    update tabelle
        set spiele = spiele + 1,
            toreErhalten = toreErhalten + 1,
            toreErzielt = toreErzielt + 2,
            siege = siege + 1
        where verein = 'Jahn Regensburg'
        or verein = 'SpVgg Greuther Fürth';

    update tabelle
        set spiele = spiele + 1,
            niederlagen = niederlagen + 1,
            toreErzielt = toreErzielt + 1,
            toreErhalten = toreErhalten + 2
        where verein = '1. FC Heidenheim'
        or verein = '1. FC Nürnberg';

 commit transaction;


/********************************************************\ AUFGABE Check \********************************************************/
-- Konsitenz Check: Die Summe der Spalten toreErzielt und toreErhalten
 

select sum(toreErhalten), sum(toreErzielt) from tabelle;

 begin  transaction;

    select * from tabelle;

    update tabelle
        set spiele = spiele + 1,
            toreErzielt = toreErzielt + 1,
            toreErhalten = toreErhalten + 2,
            niederlagen = niederlagen + 1
        where verein = 'Hannover 96';

    update  tabelle
        set spiele = spiele + 1,
            toreErzielt = toreErzielt + 2,
            toreErhalten = toreErhalten + 1,
            siege = siege + 1
        where verein = 'SV Darmstadt 98';

    select * from tabelle;

 commit transaction;

select sum(toreErhalten), sum(toreErzielt) from tabelle;

select *, siege * 3 + remis as Punkte, toreErzielt - toreErhalten as Tordifferenz from tabelle

    order by Punkte desc,
             Tordifferenz desc;


/********************************************************\ Sonstiges\********************************************************/

BEGIN TRANSACTION;
    SELECT * FROM tabelle;

    UPDATE tabelle
        SET spiele = spiele + 1
        WHERE verein = 'Hamburger SV';

    SELECT * FROM tabelle;

COMMIT TRANSACTION;


