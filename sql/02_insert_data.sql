--Filiale
DO $$
DECLARE
    i INT := 0;
BEGIN
    WHILE i < 100 LOOP
        INSERT INTO dbo.Filiale (strasse, Ort, PLZ, Bundesland)
        VALUES (
            'Strasse ' || (RANDOM() * 1000)::INT,       -- Random street name
            'Ort ' || (RANDOM() * 100)::INT,            -- Random city name
            LPAD((FLOOR(RANDOM() * 90000 + 10000))::TEXT, 5, '0'), -- Random postal code
            'Bundesland ' || (RANDOM() * 4 + 1)::INT      -- Random state name
        );
        i := i + 1;
    END LOOP;
END $$;

--ProduktSparte
DO $$
DECLARE
    i INT := 0;
BEGIN
    WHILE i < 10 LOOP
        INSERT INTO dbo.produktsparte (name, beschreibung)
        VALUES (
            'Sparte ' || i+1::INT,      
             SUBSTRING(MD5(RANDOM()::TEXT) FROM 1 FOR 100) 
			 --Create a random description (alphanumeric) with 100 characters 
        );
        i := i + 1;
    END LOOP;
END $$;


--Produkt
DO $$
DECLARE
    i INT := 0;
BEGIN
    WHILE i < 1000 LOOP
        INSERT INTO dbo.produkt (sparte_id, name, preis)
        VALUES (
            (RANDOM() * 9 + 1) ::INT,
			'Produkt' || i,
			(RANDOM()*1000) ::INT/100.0
        );
        i := i + 1;
    END LOOP;
END $$;

--Transaktion
--DROP FUNCTION RANDOM_DATE;
CREATE FUNCTION random_date() RETURNS TIMESTAMP AS $$
DECLARE
    start_date TIMESTAMP := '2024-01-01 00:00:00';
    end_date TIMESTAMP := '2025-02-28 23:59:59';
    random_timestamp TIMESTAMP;
    random_seconds BIGINT;
    diff_seconds BIGINT;
BEGIN
    -- Calculate the difference in seconds between the start and end dates
    diff_seconds := EXTRACT(EPOCH FROM end_date - start_date);

    -- Generate a random number of seconds within that range
    random_seconds := FLOOR(RANDOM() * diff_seconds);

    -- Calculate the random timestamp by adding the random seconds to the start date
    random_timestamp := start_date + (random_seconds || ' seconds')::INTERVAL;
	
	RETURN random_timestamp;
END ;
$$ LANGUAGE plpgsql;


DO $$
DECLARE
    i INT := 0;
BEGIN
    WHILE i < 5000 LOOP
        INSERT INTO dbo.transaktion (filiale_id, datum_id)
        VALUES (
            (RANDOM()*99+1)::INT,
			 random_date()
        );
        i := i + 1;
    END LOOP;
END $$;


--TransaktionProdukt
DO $$
DECLARE
    i INT := 0;
BEGIN
    WHILE i < 50000 LOOP
        INSERT INTO dbo.transaktionprodukt (transaktion_id, produkt_id, anzahl)
        VALUES (
            (RANDOM()*4999+1)::INT,
			 (RANDOM()*99+1)::INT,
			 (RANDOM()*9+1)::INT
        )
		ON CONFLICT (transaktion_id, produkt_id) DO NOTHING;
        i := i + 1;
    END LOOP;
END $$;
