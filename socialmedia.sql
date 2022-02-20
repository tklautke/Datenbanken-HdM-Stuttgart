/********************************************************\ AUFGABE 1 \********************************************************/ 
--  Alle Nachrichten und Benutzername des Autors
SELECT content, displayname FROM user
    INNER JOIN post ON user.id = post.authorId;


/********************************************************\ AUFGABE 2 \********************************************************/ 
-- Anzeigename, e-Mailadresse und Zeitpunkt der Registrierung
SELECT displayname, user.email, registeredWhen FROM user
    INNER JOIN email ON user.email = email.email
    ORDER BY registeredWhen DESC;


/********************************************************\ AUFGABE 3 \********************************************************/ 
-- Alle Benutzer und die Anzahl ihrer Nachrichten
SELECT displayname, count(post.id) AS anzahlNachrichten FROM user
    LEFT OUTER JOIN post ON user.id = post.authorId
    GROUP BY user.displayname
    ORDER BY anzahlNachrichten DESC;


/********************************************************\ AUFGABE 4 \********************************************************/ 
-- Alle Posts, die eines der Worte "cool" und "music" enthalten, mit Angabe des Anzeigenamens und des
-- Registrierungszeitpunkts des Autors
SELECT content, displayname, registeredWhen FROM post
    INNER JOIN user ON post.authorId = user.id
    INNER JOIN email ON user.email = email.email
    WHERE content LIKE "%music%" OR content LIKE "%cool%";


/********************************************************\ AUFGABE 6 \********************************************************/ 
-- Alle Posts mit der E-Mailadresse des Autors und der Anzahl der Likes
SELECT content, email, COUNT(*) AS anzahlLikes FROM post
    INNER JOIN user ON post.authorId = user.id
    LEFT OUTER JOIN likes ON post.id = likes.postId
    GROUP BY content, email
    ORDER BY anzahlLikes DESC;


/********************************************************\ AUFGABE 7 \********************************************************/ 
-- Teil 1: Alle Posts von Mark
SELECT content FROM post
    INNER JOIN user ON post.authorId = user.id
    WHERE user.displayname = "Mark";

-- Teil 2: Alle Posts, die von Mark geliked wurden
SELECT content FROM post
    INNER JOIN likes ON post.id = likes.postId
    INNER JOIN user ON likes.userId = user.id
    WHERE user.displayname = "Mark";

-- Und jetzt beide Teile kombiniert, mit UNION
SELECT content FROM post
    INNER JOIN user ON post.authorId = user.id
    WHERE user.displayname = "Mark"
    UNION
    SELECT content
    FROM post
    INNER JOIN likes ON post.id = likes.postId
    INNER JOIN user ON likes.userId = user.id
    WHERE user.displayname = "Mark";


/********************************************************\ AUFGABE 8 \********************************************************/ 
-- Alle Follower-Beziehungen
SELECT follower.displayname AS follower, followee.displayname AS followee FROM isfollowing
    INNER JOIN user AS followee ON isfollowing.followeeId = followee.id
    INNER JOIN user AS follower ON isfollowing.followerId = follower.id;


/********************************************************\ AUFGABE 9 \********************************************************/ 
-- Welche Beziehungen zwischen den Benutzern wären möglich und welche davon gibt es?
SELECT follower.displayname AS Follower, followee.displayname AS Followee, isfollowing.followeeId FROM user AS follower
    CROSS JOIN user AS followee
    LEFT OUTER JOIN isfollowing ON follower.id = isfollowing.followerId AND followee.id = isfollowing.followeeId;


-- Welche Beziehungen zwischen den Benutzern wären möglich und welche davon gibt es?
-- Jetzt mit einer etwas schöneren Anzeige, ob die Beziehung existiert:
SELECT follower.displayname AS Follower, followee.displayname AS Followee,
    CASE
        WHEN isfollowing.followeeId IS NULL THEN "false"
        ELSE "true"
    END
    AS relExists
FROM user AS follower
CROSS JOIN user AS followee
LEFT OUTER JOIN isfollowing ON follower.id = isfollowing.followerId AND followee.id = isfollowing.followeeId;
