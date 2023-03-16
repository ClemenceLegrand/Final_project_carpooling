USE Final_Project;

### QUERIES

#Carpooling journeys per year and per incentives
SELECT year, count(*) AS total_journeys, count(CASE WHEN has_incentive="OUI" THEN 1 END) AS with_incentives
FROM carpool_journeys
GROUP BY year
ORDER BY year;

# I want to see the territorial authorities where there is financial incentives
SELECT dc.id_city,dc.id_reg,dc.city_name,cj.journey_start_towngroup,r.region_name
FROM data_cities dc 
JOIN carpool_journeys cj ON dc.id_city=cj.journey_start_insee
JOIN region r ON dc.id_city=r.id_reg
WHERE cj.has_incentive="OUI"
GROUP BY dc.id_reg, r.region_name, cj.journey_start_towngroup, dc.id_city,dc.city_name;

SELECT DISTINCT cj.journey_start_towngroup,r.region_name
FROM carpool_journeys cj
JOIN data_cities dc  ON dc.id_city=cj.journey_start_insee
JOIN region r ON dc.id_reg=r.id_reg
WHERE cj.has_incentive="OUI"
GROUP BY r.region_name, cj.journey_start_towngroup
ORDER BY r.region_name ASC;

#List of the region where there is the most carpool journeys per capita
SELECT r.region_name, 
count(cj.journey_id)/sum(total_pop_2019)*1000 as total_journeys_per_1000inhab
FROM carpool_journeys cj
JOIN data_cities dc  ON dc.id_city=cj.journey_start_insee
JOIN region r ON dc.id_reg=r.id_reg
GROUP BY r.region_name
ORDER BY total_journeys_per_1000inhab DESC;

#The list of the regions where there is the most financially incentivized journey per capita
SELECT r.region_name, 
count(cj.journey_id)/sum(total_pop_2019)*1000 as total_incentivized_journeys_1000inhab
FROM carpool_journeys cj
JOIN data_cities dc  ON dc.id_city=cj.journey_start_insee
JOIN region r ON dc.id_reg=r.id_reg
WHERE cj.has_incentive="OUI"
GROUP BY r.region_name
ORDER BY total_incentivized_journeys_1000inhab DESC;

#Look at the number of carpool journeys per capita depending of the type of density territories
SELECT dc.density_type, dc.density_degree, 
count(cj.journey_id)/sum(total_pop_2019)*1000 as total_journeys_1000inhab
FROM carpool_journeys cj
JOIN data_cities dc  ON dc.id_city=cj.journey_start_insee
GROUP BY dc.density_type, dc.density_degree
ORDER BY total_journeys_1000inhab DESC;

#Top 15 of the departments with most carpool journeys per capita
SELECT dc.id_dep as department, 
	count(cj.journey_id) as total_journeys, 
    sum(dc.total_pop_2019) as dep_population, 
    count(journey_id)/sum(dc.total_pop_2019)*1000 as journeys_per_1000inhab
FROM carpool_journeys cj
JOIN data_cities dc ON cj.journey_start_insee=dc.id_city
GROUP BY department
ORDER BY journeys_per_1000inhab DESC
LIMIT 15;

#Top 15 of the departments with high work-commute population 
SELECT id_dep as department, 
sum(no_commute_pop) as no_commute_pop,
sum(total_pop_2019) as total_pop_dep,
(sum(total_pop_2019)-sum(no_commute_pop))/sum(total_pop_2019)*1000 as commute_people_per_1000_inhab
FROM data_cities
GROUP BY department
ORDER BY commute_people_per_1000_inhab DESC
LIMIT 15;

