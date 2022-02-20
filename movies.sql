
/********************************************************\ AUFGABE 1 \********************************************************/ 
-- A2: Alle Filmtitel und Erscheinungsjahr anzeigen 
SELECT title, year FROM movies; 


/********************************************************\ AUFGABE 2 \********************************************************/ 
-- A3: Die ersten 100 Filme in alphabetischer Reihenfolge 
SELECT title FROM movies 
    ORDER BY title ASC LIMIT 100; 


/********************************************************\ AUFGABE 3 \********************************************************/ 
-- A4: Die Filmtitel und die Bewertung auf den Plätzen
-- 21 bis 30 in der Rangliste nach Bewertung 
SELECT title, rating FROM movies 
    ORDER BY rating DESC LIMIT 10 OFFSET 20; 


/********************************************************\ AUFGABE 4 \********************************************************/ 
-- A5: Ausgabe aller unterschiedlichen Genres (ohne -- doppelte Einträge) in alphabetischer Reihenfolge 
SELECT DISTINCT genre FROM movies 
    ORDER BY genre ASC; 


/********************************************************\ AUFGABE 5 \********************************************************/ 
-- A6: Gesamtzahl der Filme je Genre, alphabetisch -- sortiert 
SELECT genre, COUNT(*) AS NumMovies FROM movies 
    GROUP BY genre 
    ORDER BY genre ASC; 


/********************************************************\ AUFGABE 6 \********************************************************/ 
-- A7: Alle Regisseure mit einer Durchschnittsbewertung -- von über 7.5 für ihre Action-Filme, sortiert nach der 
-- Durchschnittsbewertung (beste zu erst) 
SELECT director, AVG(rating) AS AvgRating FROM movies 
    WHERE genre = "Action" 
    GROUP BY director 
    HAVING AvgRating >= 7.5 
    ORDER BY AvgRating DESC; 


/********************************************************\ AUFGABE 7 - BONUS - \********************************************************/ 
-- A8: Ermitteln Sie alle Jahre, in denen es zu einem -- bestimmten Genre 25 oder mehr Filme gab, jedoch ohne 
-- Vin Diesel Filme zu berücksichtigen (seine Filme sind -- einfach zu schlecht!). Geben Sie auch das Genre und die 
-- Anzahl der Filme aus und sortieren Sie die Liste -- absteigend nach der Anzahl der Filme. 
SELECT year, genre, COUNT(*) AS NumMovies FROM movies 
    WHERE actors NOT LIKE "%Vin Diesel%" 
    GROUP BY year, genre 
    HAVING NumMovies >= 25 
    ORDER BY NumMovies DESC; 
