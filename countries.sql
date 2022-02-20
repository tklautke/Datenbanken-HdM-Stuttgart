SELECT 1;

SELECT 1, 2, "Hallo, Welt!", NULL;

SELECT 75 + 107, RANDOM();

SELECT 75 + 107 AS BestPunkRockBandEver, RANDOM() AS EineZufallszahl;

SELECT 2 AS Primzahlen
    UNION ALL SELECT 3
    UNION ALL SELECT 5
    UNION ALL SELECT 7;

SELECT "Das wird nicht angezeigt" AS EinText WHERE 1=0;

SELECT * FROM countries;

SELECT COUNT(*) FROM countries;

SELECT COUNT(*) AS AnzahlRecords, COUNT(Climate) AS AnzahlRecordsMitKlimaAngabe FROM countries;

SELECT * FROM countries
	WHERE Country = 'Portugal';

SELECT Country, GDP FROM countries
	WHERE Country = 'Norway';


------------------------------------------------------------------------------------------------------------------------
-- AUFGABE: Lesen Sie den Namen und die Landfläche (Area) aller Länder der Region "NEAR EAST" (!) heraus.
SELECT Country, Area FROM countries
    WHERE Region = 'NEAR EAST';
------------------------------------------------------------------------------------------------------------------------

SELECT Country FROM countries
	WHERE Country LIKE 'G%';

SELECT COUNT(Country) FROM countries
	WHERE Coastline > 0;


------------------------------------------------------------------------------------------------------------------------
-- BONUS: Ermitteln Sie den prozentualen Anteil der Länder mit Küste, im Verhältnis zur Gesamtzahl der Länder (in einer
-- einzigen Abfrage).
SELECT *, ROUND(HaveCoastlines * 100, 3) / ROUND(NumOfCountries, 3) AS Percentage FROM
    (SELECT COUNT(Country) AS HaveCoastlines FROM countries
        WHERE Coastline > 0),
    (SELECT COUNT(Country) AS NumOfCountries FROM countries);
------------------------------------------------------------------------------------------------------------------------

SELECT Country, Population FROM countries
	ORDER BY Population DESC
	LIMIT 10;

SELECT Country, Population FROM countries
	ORDER BY Population DESC
	LIMIT 10
	OFFSET 10;


------------------------------------------------------------------------------------------------------------------------
-- AUFGABE: Ermitteln Sie die Länder auf Rang #11 - #15 in der Rangliste der größten Länder Westeuropas, nach ihrer
-- Landfläche. Hinweis: Die Region heißt "WESTERN EUROPE".
SELECT Country, Area
    FROM countries
    WHERE Region = "WESTERN EUROPE"
    ORDER BY Area DESC
    LIMIT 5
    OFFSET 10;
------------------------------------------------------------------------------------------------------------------------

SELECT DISTINCT(Region) FROM countries;

SELECT Region, COUNT(Country) FROM countries
    GROUP BY Region;

SELECT Region, AVG(GDP) FROM countries
    GROUP BY Region;

SELECT Region, ROUND(AVG(GDP), 0) AS AvgGDP FROM countries
    GROUP BY Region
    ORDER BY AvgGDP DESC;

SELECT Region, ROUND(AVG(GDP), 0) AS AvgGDP FROM countries
    GROUP BY Region
    ORDER BY AvgGDP ASC
    LIMIT 3;

------------------------------------------------------------------------------------------------------------------------
-- BONUS: Wie oben die kleinsten drei Regionen ermitteln, aber mit absteigender Reihenfolge der Ergebnismenge.
WITH LastThreeRegions AS (
    SELECT Region, ROUND(AVG(GDP), 0) AS AvgGDP FROM countries
        GROUP BY Region
        ORDER BY AvgGDP ASC
        LIMIT 3
)
SELECT * FROM LastThreeRegions
    ORDER BY AvgGDP DESC;
------------------------------------------------------------------------------------------------------------------------

SELECT Region, ROUND(AVG(GDP), 0) AS AvgGDP FROM countries
    GROUP BY Region
    HAVING AvgGDP > 10000
    ORDER BY AvgGDP DESC;

SELECT Region, Count(Country) AS NumCountries FROM countries
    WHERE Netmigration > 0
    GROUP BY Region
    HAVING NumCountries > 5
    ORDER BY NumCountries DESC;

------------------------------------------------------------------------------------------------------------------------
-- AUFGABE: Ermitteln Sie die Summe der Landfläche aller Länder einer Region und sortieren Sie die Ergebnisse in
-- absteigender Reihenfolge.
SELECT Region, SUM(Area) AS TotalArea
    FROM countries
    GROUP BY Region
    ORDER BY TotalArea DESC;
------------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------------
-- AUFGABE: Ermitteln Sie je Region die Summe der Landfläche aller Länder, die eine Küste haben. Sortieren Sie auch hier
-- in absteigender Reihenfolge.
SELECT Region, SUM(Area) AS TotalArea
    FROM countries
    WHERE Coastline > 0
    GROUP BY Region
    ORDER BY TotalArea DESC;
------------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------------
-- AUFGABE: Ermitteln Sie für jede Region das Land mit der größten Landfläche, das keine Küste hat. Den größten Wert
-- können Sie mit Hilfe der Aggregatsfunktion MAX() berechnen. Zeigen Sie nur Regionen an, bei denen das größte Land
-- mindestens 1.000.000 (Quadratkilometer) groß ist.
SELECT Region, MAX(Area) AS GroessteLF
    FROM countries
    WHERE Coastline = 0
    GROUP BY Region
    HAVING GroessteLF > 1000000
    ORDER BY GroessteLF DESC;
------------------------------------------------------------------------------------------------------------------------
