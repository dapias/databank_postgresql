--CREATE DATABASE HandelsU;
DROP SCHEMA dbo if EXISTS CASCADE;
create schema dbo;

DROP TABLE IF EXISTS dbo.Filiale;
CREATE TABLE dbo.Filiale (
    Filiale_ID SERIAL PRIMARY KEY,       
    strasse VARCHAR(100),             
    Ort VARCHAR(50),                  
    PLZ CHAR(5),                   
    Bundesland VARCHAR(50)             
);


DROP TABLE IF EXISTS dbo.Transaktion; 
CREATE TABLE dbo.Transaktion (
    transaktion_id SERIAL PRIMARY KEY,
    filiale_id INT REFERENCES dbo.Filiale(Filiale_ID) ON DELETE CASCADE,
    datum_id TIMESTAMP NOT NULL
);


DROP TABLE IF EXISTS dbo.ProduktSparte; 
CREATE TABLE dbo.ProduktSparte (
	sparte_id SERIAL PRIMARY KEY,
	name VARCHAR(20),
	beschreibung VARCHAR(100)
);

DROP TABLE IF EXISTS dbo.Produkt; 
CREATE TABLE dbo.Produkt (
	produkt_id SERIAL PRIMARY KEY,
	sparte_id INT REFERENCES dbo.ProduktSparte(sparte_id) ON DELETE CASCADE,
	name VARCHAR(20), 
	preis DOUBLE PRECISION
);


DROP TABLE IF EXISTS dbo.TransaktionProdukt; 
CREATE TABLE dbo.TransaktionProdukt (
    transaktion_id INT,
    produkt_id INT,
    Anzahl INT NOT NULL,
    PRIMARY KEY (transaktion_id, produkt_id),
    FOREIGN KEY (transaktion_id) REFERENCES dbo.Transaktion(transaktion_id) ON DELETE CASCADE,
    FOREIGN KEY (produkt_id) REFERENCES dbo.Produkt(produkt_id) ON DELETE CASCADE
);
