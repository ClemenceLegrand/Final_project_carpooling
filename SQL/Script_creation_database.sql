USE Final_Project;

## Data cities table : I need to create a table with all the tables giving informations on the cities : code_territories, density, density_labels,work_commute
DROP TABLE data_cities;
CREATE TABLE IF NOT EXISTS data_cities (
    id_city VARCHAR(10) NOT NULL,
    id_reg INT NOT NULL,
    id_dep VARCHAR(10) NOT NULL,
    city_name VARCHAR(255) NOT NULL,
    dens_pop FLOAT,
    density_degree VARCHAR(255),
    density_type VARCHAR(255),
    total_pop_2019 INT,
    no_commute_pop FLOAT,
    PRIMARY KEY (id_city)
);

INSERT INTO data_cities (id_city, id_reg, id_dep, city_name, dens_pop, density_degree, density_type, total_pop_2019, no_commute_pop)
SELECT 
    ct.id_city, 
    ct.id_reg, 
    ct.id_dep, 
    ct.city_name,
    d.dens_pop,
    dl.density_degree,
    dl.density_type,
    dl.total_pop_2019,
    wc.no_commute_pop
FROM code_territories ct
JOIN density d ON ct.id_city = d.id_city
JOIN density_labels dl ON ct.id_city = dl.id_city
LEFT JOIN work_commute wc ON ct.id_city = wc.id_city;

## I want to create an indicator in data_cities to have the proportion of people movinf to another city to work
ALTER TABLE data_cities 
ADD COLUMN work_commute_perc FLOAT;

UPDATE data_cities
SET work_commute_perc=(total_pop_2019-no_commute_pop)/total_pop_2019*100;

## Now that my table data_cities is created I can drop the tables I used to create it

## After importing the main dataset from SQLAlchemy in 5 datasets, I need to union them
DROP TABLE carpool_journeys;
CREATE TABLE IF NOT EXISTS carpool_journeys (
	journey_id int not null unique,
	journey_start_datetime datetime,
	journey_start_date date,
	journey_start_time time,
	journey_start_lon float,
	journey_start_lat float,
	journey_start_insee varchar(10),
	journey_start_department varchar(10),
	journey_start_towngroup varchar (255),
	journey_end_datetime datetime,
	journey_end_date date,
	journey_end_time time,
	journey_end_lon float,
	journey_end_lat float,
	journey_end_insee varchar(10),
	journey_end_department varchar(10),
	journey_end_towngroup varchar(255),
	operator_class varchar(10),
	journey_distance int,
	journey_duration float,
	has_incentive varchar(10),
	nb_passengers int,
	year int,
    PRIMARY KEY (journey_id)
    );
    
INSERT INTO carpool_journeys (
	journey_id,
	journey_start_datetime,
	journey_start_date,
	journey_start_time,
	journey_start_lon,
	journey_start_lat,
	journey_start_insee,
	journey_start_department,
	journey_start_towngroup,
	journey_end_datetime,
	journey_end_date,
	journey_end_time,
	journey_end_lon,
	journey_end_lat,
	journey_end_insee,
	journey_end_department,
	journey_end_towngroup,
	operator_class,
	journey_distance,
	journey_duration,
	has_incentive,
	nb_passengers,
	year)
SELECT * FROM carpool_2019;

INSERT INTO carpool_journeys (
	journey_id,
	journey_start_datetime,
	journey_start_date,
	journey_start_time,
	journey_start_lon,
	journey_start_lat,
	journey_start_insee,
	journey_start_department,
	journey_start_towngroup,
	journey_end_datetime,
	journey_end_date,
	journey_end_time,
	journey_end_lon,
	journey_end_lat,
	journey_end_insee,
	journey_end_department,
	journey_end_towngroup,
	operator_class,
	journey_distance,
	journey_duration,
	has_incentive,
	nb_passengers,
	year)
SELECT * FROM carpool_2020;

INSERT INTO carpool_journeys (
	journey_id,
	journey_start_datetime,
	journey_start_date,
	journey_start_time,
	journey_start_lon,
	journey_start_lat,
	journey_start_insee,
	journey_start_department,
	journey_start_towngroup,
	journey_end_datetime,
	journey_end_date,
	journey_end_time,
	journey_end_lon,
	journey_end_lat,
	journey_end_insee,
	journey_end_department,
	journey_end_towngroup,
	operator_class,
	journey_distance,
	journey_duration,
	has_incentive,
	nb_passengers,
	year)
SELECT * FROM carpool_2021;

INSERT INTO carpool_journeys (
	journey_id,
	journey_start_datetime,
	journey_start_date,
	journey_start_time,
	journey_start_lon,
	journey_start_lat,
	journey_start_insee,
	journey_start_department,
	journey_start_towngroup,
	journey_end_datetime,
	journey_end_date,
	journey_end_time,
	journey_end_lon,
	journey_end_lat,
	journey_end_insee,
	journey_end_department,
	journey_end_towngroup,
	operator_class,
	journey_distance,
	journey_duration,
	has_incentive,
	nb_passengers,
	year)
SELECT * FROM carpool_2023;

INSERT INTO carpool_journeys (
	journey_id,
	journey_start_datetime,
	journey_start_date,
	journey_start_time,
	journey_start_lon,
	journey_start_lat,
	journey_start_insee,
	journey_start_department,
	journey_start_towngroup,
	journey_end_datetime,
	journey_end_date,
	journey_end_time,
	journey_end_lon,
	journey_end_lat,
	journey_end_insee,
	journey_end_department,
	journey_end_towngroup,
	operator_class,
	journey_distance,
	journey_duration,
	has_incentive,
	nb_passengers,
	year)
SELECT * FROM carpool_2022_part1;

INSERT INTO carpool_journeys (
	journey_id,
	journey_start_datetime,
	journey_start_date,
	journey_start_time,
	journey_start_lon,
	journey_start_lat,
	journey_start_insee,
	journey_start_department,
	journey_start_towngroup,
	journey_end_datetime,
	journey_end_date,
	journey_end_time,
	journey_end_lon,
	journey_end_lat,
	journey_end_insee,
	journey_end_department,
	journey_end_towngroup,
	operator_class,
	journey_distance,
	journey_duration,
	has_incentive,
	nb_passengers,
	year)
SELECT * FROM carpool_2022_part2;

SELECT count(*) FROM carpool_journeys;

### Importing last tables : gasoline price, schedule, carpool areas


