
-- ==========================================
-- SCRIPT 3 : REQUÊTES DE VÉRIFICATION
-- PROJET TIFOSI
-- ==========================================

USE tifosi;

-- ==========================================
-- REQUÊTE 1
-- Objectif : Afficher la liste des focaccias
-- par ordre alphabétique.
-- ==========================================

SELECT nom
FROM focaccia
ORDER BY nom ASC;

-- Résultat attendu : 8 focaccias.
-- Résultat obtenu lors du test : 8 focaccias.
-- Commentaire : Résultat conforme.


-- ==========================================
-- REQUÊTE 2
-- Objectif : Afficher le nombre total
-- d'ingrédients disponibles.
-- ==========================================

SELECT COUNT(*) AS total_ingredients
FROM ingredient;

-- Résultat attendu : 25 ingrédients.
-- Résultat obtenu lors du test : 25 ingrédients.
-- Commentaire : Résultat conforme.


-- ==========================================
-- REQUÊTE 3
-- Objectif : Afficher le prix moyen
-- des focaccias.
-- ==========================================

SELECT ROUND(AVG(prix), 2) AS prix_moyen
FROM focaccia;

-- Résultat attendu : 10.38 euros.
-- Résultat obtenu lors du test : 10.38 euros.
-- Commentaire : Résultat conforme.


-- ==========================================
-- REQUÊTE 4
-- Objectif : Afficher la liste des boissons
-- avec leurs marques, par ordre alphabétique.
-- ==========================================

SELECT
    b.nom AS boisson,
    m.nom AS marque
FROM boisson b
INNER JOIN marque m
    ON b.id_marque = m.id_marque
ORDER BY b.nom ASC;

-- Résultat attendu : 12 boissons avec leurs marques.
-- Résultat obtenu lors du test : 12 boissons.
-- Commentaire : Résultat conforme.


-- ==========================================
-- REQUÊTE 5
-- Objectif : Afficher les ingrédients
-- de la focaccia Raclaccia.
-- ==========================================

SELECT i.nom AS ingredient
FROM ingredient i
INNER JOIN comprend c
    ON i.id_ingredient = c.id_ingredient
INNER JOIN focaccia f
    ON c.id_focaccia = f.id_focaccia
WHERE f.nom = 'Raclaccia'
ORDER BY i.nom ASC;

-- Résultat attendu : 7 ingrédients.
-- Résultat obtenu lors du test : 7 ingrédients.
-- Commentaire : Résultat conforme.


-- ==========================================
-- REQUÊTE 6
-- Objectif : Afficher le nombre d'ingrédients
-- pour chaque focaccia.
-- ==========================================

SELECT
    f.nom AS focaccia,
    COUNT(c.id_ingredient) AS nombre_ingredients
FROM focaccia f
LEFT JOIN comprend c
    ON f.id_focaccia = c.id_focaccia
GROUP BY f.id_focaccia, f.nom
ORDER BY f.nom ASC;

-- Résultat attendu : 8 focaccias avec
-- leur nombre respectif d'ingrédients.
-- Résultat obtenu lors du test : 8 focaccias.
-- Commentaire : Résultat conforme.


-- ==========================================
-- REQUÊTE 7
-- Objectif : Afficher la focaccia qui
-- possède le plus grand nombre d'ingrédients.
-- ==========================================

SELECT
    f.nom AS focaccia,
    COUNT(c.id_ingredient) AS nombre_ingredients
FROM focaccia f
INNER JOIN comprend c
    ON f.id_focaccia = c.id_focaccia
GROUP BY f.id_focaccia, f.nom
ORDER BY nombre_ingredients DESC
LIMIT 1;

-- Résultat attendu : Paysanne, 12 ingrédients.
-- Résultat obtenu lors du test : Paysanne, 12 ingrédients.
-- Commentaire : Résultat conforme.


-- ==========================================
-- REQUÊTE 8
-- Objectif : Afficher toutes les focaccias
-- contenant de l'ail.
-- ==========================================

SELECT f.nom AS focaccia
FROM focaccia f
INNER JOIN comprend c
    ON f.id_focaccia = c.id_focaccia
INNER JOIN ingredient i
    ON c.id_ingredient = i.id_ingredient
WHERE i.nom = 'Ail'
ORDER BY f.nom ASC;

-- Résultat attendu : 4 focaccias.
-- Résultat obtenu lors du test : 4 focaccias.
-- Commentaire : Résultat conforme.


-- ==========================================
-- REQUÊTE 9
-- Objectif : Afficher les ingrédients
-- qui ne sont utilisés dans aucune focaccia.
-- ==========================================

SELECT i.nom AS ingredient_inutilise
FROM ingredient i
LEFT JOIN comprend c
    ON i.id_ingredient = c.id_ingredient
WHERE c.id_ingredient IS NULL
ORDER BY i.nom ASC;

-- Résultat attendu : 2 ingrédients inutilisés.
-- Résultat obtenu lors du test :
-- Salami et Tomate cerise.
-- Commentaire : Résultat conforme.


-- ==========================================
-- REQUÊTE 10
-- Objectif : Afficher les focaccias
-- qui ne contiennent pas de champignons.
-- ==========================================

SELECT f.nom AS focaccia
FROM focaccia f
WHERE NOT EXISTS (
    SELECT 1
    FROM comprend c
    INNER JOIN ingredient i
        ON c.id_ingredient = i.id_ingredient
    WHERE c.id_focaccia = f.id_focaccia
      AND i.nom = 'Champignon'
)
ORDER BY f.nom ASC;

-- Résultat attendu : 2 focaccias.
-- Résultat obtenu lors du test :
-- Américaine et Hawaienne.
-- Commentaire : Résultat conforme.
