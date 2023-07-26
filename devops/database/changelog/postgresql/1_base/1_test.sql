-- liquibase formatted sql

-- changeset liquibase:1
CREATE TABLE coordinates (
    id SERIAL PRIMARY KEY,
    name VARCHAR(64),
    first_location geography(POINT,4326),
    second_location geography(POINT,4326)
 );
 
 -- changeset liquibase:2
 
ALTER TABLE coordinates
ADD line geography(LINESTRING, 4326);

-- changeset liquibase:3 

CREATE OR REPLACE FUNCTION update_line() RETURNS TRIGGER AS
'
BEGIN
	update coordinates set line = (
  	SELECT ST_MakeLine(c.first_location::geometry, c.second_location ::geometry) AS line_string
	FROM coordinates c 
	WHERE c.id = new.id
 	 )
 	where id = new.id;
 	
    RETURN NEW;
END;
' LANGUAGE plpgsql;

-- changeset liquibase:4 

CREATE TRIGGER update_line_trigger
    AFTER INSERT ON coordinates 
    FOR EACH ROW
    EXECUTE PROCEDURE update_line();
    
-- changeset liquibase:5 

ALTER TABLE coordinates
ADD geometry_collection geography(GEOMETRYCOLLECTION, 4326);

ALTER TABLE coordinates
ADD line_length NUMERIC;

ALTER TABLE coordinates
ADD geometry_collection_area NUMERIC;

-- changeset liquibase:6 

INSERT INTO coordinates (first_location, second_location, geometry_collection) 
VALUES ('POINT(26.98378312542289 49.4332813971677)', 'POINT(26.991229593293525 49.44553153633202)', 'GEOMETRYCOLLECTION(POINT(2 0), POLYGON((0 0, 1 0, 1 1, 0 1, 0 0)))');

-- changeset liquibase:7

UPDATE coordinates 
SET 
	line_length = (SELECT ST_Length( (SELECT line FROM coordinates WHERE id = 1)) FROM coordinates where id = 1),
	geometry_collection_area = (SELECT ST_Area( (SELECT geometry_collection  FROM coordinates WHERE id = 1)) FROM coordinates where id = 1)
 WHERE id = 1;

