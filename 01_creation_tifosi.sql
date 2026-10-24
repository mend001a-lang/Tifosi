
-- Script 1 : Création de la base de données Tifosi
-- Projet : Devoir MySQL

CREATE DATABASE IF NOT EXISTS tifosi;


-- ==========================================
-- CRÉATION DE L'UTILISATEUR TIFOSI
-- ==========================================

CREATE USER IF NOT EXISTS 'tifosi'@'localhost'
IDENTIFIED BY 'A_REMPLACER_PAR_UN_MOT_DE_PASSE_FORT';


-- IMPORTANT :
-- Le mot de passe ci-dessous est une valeur d'exemple.
-- Il doit être remplacé par un mot de passe fort
-- avant la première exécution du script.
-- Ne jamais publier un véritable mot de passe.


-- Attribution des droits sur la base tifosi

GRANT ALL PRIVILEGES ON tifosi.*
TO 'tifosi'@'localhost';


USE tifosi;

-- ==========================================
-- TABLE 1 : INGREDIENT
-- ==========================================

CREATE TABLE IF NOT EXISTS ingredient (
    id_ingredient INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL UNIQUE
);

-- ==========================================
-- TABLE 2 : FOCACCIA
-- ==========================================

CREATE TABLE IF NOT EXISTS focaccia (
    id_focaccia INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL UNIQUE,
    prix DECIMAL(5,2) NOT NULL,
    CONSTRAINT chk_prix_focaccia CHECK (prix >= 0)
);

-- ==========================================
-- TABLE 3 : COMPREND
-- ==========================================

CREATE TABLE IF NOT EXISTS comprend (
    id_focaccia INT NOT NULL,
    id_ingredient INT NOT NULL,
    quantite INT NOT NULL,

    PRIMARY KEY (id_focaccia, id_ingredient),

    FOREIGN KEY (id_focaccia)
        REFERENCES focaccia(id_focaccia),

    FOREIGN KEY (id_ingredient)
        REFERENCES ingredient(id_ingredient),

    CONSTRAINT chk_quantite_comprend
        CHECK (quantite > 0)
);

-- ==========================================
-- TABLE 4 : MARQUE
-- ==========================================

CREATE TABLE IF NOT EXISTS marque (
    id_marque INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL UNIQUE
);

-- ==========================================
-- TABLE 5 : BOISSON
-- ==========================================

CREATE TABLE IF NOT EXISTS boisson (
    id_boisson INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL UNIQUE,
    id_marque INT NOT NULL,

    FOREIGN KEY (id_marque)
        REFERENCES marque(id_marque)
);

-- ==========================================
-- TABLE 6 : MENU
-- ==========================================

CREATE TABLE IF NOT EXISTS menu (
    id_menu INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL UNIQUE,
    prix DECIMAL(5,2) NOT NULL,
    id_focaccia INT NOT NULL,

    CONSTRAINT chk_prix_menu CHECK (prix >= 0),

    FOREIGN KEY (id_focaccia)
        REFERENCES focaccia(id_focaccia)
);

-- ==========================================
-- TABLE 7 : CLIENT
-- ==========================================

CREATE TABLE IF NOT EXISTS client (
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    code_postal INT NOT NULL
);

-- ==========================================
-- TABLE 8 : ACHETE
-- ==========================================

CREATE TABLE IF NOT EXISTS achete (
    id_client INT NOT NULL,
    id_menu INT NOT NULL,
    date_achat DATE NOT NULL,

    PRIMARY KEY (id_client, id_menu, date_achat),

    FOREIGN KEY (id_client)
        REFERENCES client(id_client),

    FOREIGN KEY (id_menu)
        REFERENCES menu(id_menu)
);

-- ==========================================
-- TABLE 9 : CONTIENT
-- ==========================================

CREATE TABLE IF NOT EXISTS contient (
    id_menu INT NOT NULL,
    id_boisson INT NOT NULL,

    PRIMARY KEY (id_menu, id_boisson),

    FOREIGN KEY (id_menu)
        REFERENCES menu(id_menu),

    FOREIGN KEY (id_boisson)
        REFERENCES boisson(id_boisson)
);
