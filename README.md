
// Introduction

In SQL, the GEOMETRY data type represents data in a two-dimensional Cartesian plane.
It can store points, lines, and polygons, as well as more complex shapes like circles and rectangles. The GEOGRAPHY data type is similar to GEOMETRY, but it represents data in a round-earth coordinate system.

A spatial reference system (SRS) or coordinate reference system (CRS) is a framework used to precisely measure locations on the surface of the Earth as coordinates. It is thus the application of the abstract mathematics of coordinate systems and analytic geometry to geographic space.

SRID - this is the identifier for the SRS.

When we create column we can set SRID to identify SRS for special type. EXAMPLE: 

CREATE TABLE coordinates (first_location geography(POINT, SRID)); 

In this example POINT is the GEOMETRY data type but we convert it into GEOGRAPHY by setting SRID.

// Project composition

This project consist of two services:

1) POSTGRESQL with extention GIS (POSTGIS)
2) LIQUIBASE

POSTGIS images in DockerHub: https://registry.hub.docker.com/r/postgis/postgis/

// Functionality

Project demonstrate base functions and data types like: {POINT, LINESTRING, POLYGON, GEOMETRYCOLLECTION} {ST_MakeLine, ST_Length, ST_Area}

// Deployment

Run docker compose up command in root folder.

// Documentation

Geography: http://postgis.net/workshops/postgis-intro/geography.html
Geometries: http://postgis.net/workshops/postgis-intro/geometries.html
Getting Started: https://postgis.net/documentation/getting_started/
