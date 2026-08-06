-- Data Exploration

SELECT *
from raw_formula_unicorn.circuits
LIMIT 10;	 

DESCRIBE raw_formula_unicorn.circuits;

SELECT *
from raw_formula_unicorn.constructor_results
LIMIT 10;	

DESCRIBE raw_formula_unicorn.constructor_results;

SELECT *
from raw_formula_unicorn.constructor_standings
LIMIT 10;	

DESCRIBE raw_formula_unicorn.constructor_standings;

SELECT *
from raw_formula_unicorn.constructors
LIMIT 10;	

DESCRIBE raw_formula_unicorn.constructors;

SELECT *
from raw_formula_unicorn.driver_standings
LIMIT 10;

DESCRIBE raw_formula_unicorn.driver_standings;
	
SELECT *
from raw_formula_unicorn.drivers
LIMIT 10;

DESCRIBE raw_formula_unicorn.drivers;

SELECT *
from raw_formula_unicorn.pit_stops
LIMIT 10;

DESCRIBE raw_formula_unicorn.pit_stops;

SELECT *
from raw_formula_unicorn.qualifying
LIMIT 10;

DESCRIBE raw_formula_unicorn.qualifying;

SELECT *
from raw_formula_unicorn.races
LIMIT 10;

DESCRIBE raw_formula_unicorn.races;

SELECT *
from raw_formula_unicorn.results
LIMIT 10;

DESCRIBE raw_formula_unicorn.results;

SELECT *
from raw_formula_unicorn.seasons
LIMIT 10;

DESCRIBE raw_formula_unicorn.seasons;

SELECT *
from raw_formula_unicorn.sprint_results
LIMIT 10;

DESCRIBE raw_formula_unicorn.sprint_results;

SELECT *
from raw_formula_unicorn.status
LIMIT 10;

DESCRIBE raw_formula_unicorn.status;


-- Part I – Answering Business Questions

-- 1. How many different circuits are there in the dataset?

Select count(circuitid) as Total_circuitos
from raw_formula_unicorn.circuits;       -- Total de circuitos = 77

Select count(distinct circuitid) as Total_circuitos_dif
from raw_formula_unicorn.circuits;       -- Total de circuitos diferentes = 77

-- 2. How many drivers have competed in the history of Formula 1?

Select count(driverid) as Total_circuitos
from raw_formula_unicorn.drivers;       -- Total de circuitos = 861

Select count(distinct driverid) as Total_circuitos_dif
from raw_formula_unicorn.drivers;       -- Total de circuitos diferentes = 861

-- 3. Which teams have the most wins in history?

SELECT 
c.name,  
Count(*) as Victorias
from raw_formula_unicorn.results r
JOIN constructors c ON r.constructorId = c.constructorid
WHERE position = 1
GROUP BY c.name
ORDER BY Victorias DESC
LIMIT 5;

-- 4. Which driver has the highest number of fastest laps?

SELECT 
    drivers.driverId,
    drivers.surname,
    COUNT(*) AS total_vueltas_rapidas
FROM results
JOIN drivers ON results.driverId = drivers.driverId
WHERE results.rankValue = 1
GROUP BY drivers.driverId
ORDER BY total_vueltas_rapidas DESC;

-- 5. Which driver has achieved the most podiums in history?

SELECT 
    drivers.driverId,
    drivers.surname, 
    COUNT(*) AS total_podios
FROM results
JOIN drivers ON results.driverId = drivers.driverId
WHERE position IN (1, 2, 3)
GROUP BY drivers.driverId
ORDER BY total_podios DESC;

-- 6. Who are the 5 drivers with the best average finishing positions?

SELECT 
    drivers.driverId,
    drivers.surname, 
    AVG(positionOrder) AS promedio_posicion
FROM results
JOIN drivers ON results.driverId = drivers.driverId
GROUP BY drivers.driverId
ORDER BY promedio_posicion ASC
LIMIT 5;

-- 7. Which team has achieved the most pole positions?

SELECT constructors.name, COUNT(*) AS poles
FROM qualifying
JOIN constructors ON qualifying.constructorId = constructors.constructorId
WHERE position = 1
GROUP BY constructors.name
ORDER BY poles DESC
LIMIT 1;

-- 8. How many points has each team earned in a specific season? (Races)

SELECT constructors.name, races.year, SUM(results.points) AS puntos_totales
FROM results
JOIN races ON results.raceId = races.raceId
JOIN constructors ON results.constructorId = constructors.constructorId
GROUP BY constructors.name, races.year
ORDER BY races.year DESC, puntos_totales DESC;

-- 9. Which driver has gained the most positions from their starting grid?

SELECT drivers.surname, AVG(grid - positionOrder) AS mejora_promedio
FROM results
JOIN drivers ON results.driverId = drivers.driverId
WHERE grid IS NOT NULL AND grid > positionOrder
GROUP BY drivers.driverid
ORDER BY mejora_promedio DESC;

-- 10. Which teams have the most 1-2 finishes (first and second place in a race)?

SELECT constructors.name, COUNT(*) AS dobletes
FROM results r1
JOIN results r2 ON r1.raceId = r2.raceId
    AND r1.constructorId = r2.constructorId
    AND r1.driverId < r2.driverId
JOIN constructors ON r1.constructorId = constructors.constructorId
WHERE (
    (r1.position = 1 AND r2.position = 2) OR 
    (r1.position = 2 AND r2.position = 1)
)
GROUP BY constructors.name
ORDER BY dobletes DESC;

-- 11. Which have been the 5 GPs with the smallest gap between 1st and 2nd place?

SELECT 
    races.name,
    races.year, 
    MIN(ABS(r1.milliseconds - r2.milliseconds)) AS diferencia
FROM results r1
JOIN results r2 ON r1.raceId = r2.raceId 
    AND r1.driverId <> r2.driverId
JOIN races ON r1.raceId = races.raceId
WHERE r1.position = 1 
    AND r2.position = 2
    AND r1.milliseconds IS NOT NULL
    AND r2.milliseconds IS NOT NULL
GROUP BY races.name, races.year
ORDER BY diferencia ASC
LIMIT 5;

-- 12. How many drivers have participated in each season? (Using LEFT JOIN)

SELECT 
seasons.year, COUNT(DISTINCT results.driverId) AS total_pilotos
FROM seasons
LEFT JOIN races ON seasons.year = races.year
LEFT JOIN results ON races.raceId = results.raceId
GROUP BY seasons.year;

-- 13. Ranking of the top 5 drivers with the most points in a season (Using RANK())

SELECT 
driverId, surname, year, total_puntos, RANK() OVER (PARTITION BY year ORDER BY total_puntos DESC) AS ranking
FROM (
    SELECT results.driverId, d.surname AS surname, races.year, SUM(results.points) AS total_puntos
    FROM results
    JOIN races ON results.raceId = races.raceId
    JOIN drivers d ON results.driverId = d.driverId
    GROUP BY results.driverId, races.year
) AS subquery
ORDER BY year DESC, ranking ASC
LIMIT 5;

-- 14. How many points has each team earned? Using COALESCE to handle null values.

SELECT constructors.name, COALESCE(SUM(results.points), 0) AS total_puntos
FROM constructors
LEFT JOIN results ON constructors.constructorId = results.constructorId
GROUP BY constructors.name
ORDER BY total_puntos DESC;

-- 15. Determine a driver’s classification in a race using CASE

SELECT driverId, raceId,
    CASE
        WHEN positionOrder = 1 THEN 'Ganador'
        WHEN positionOrder BETWEEN 2 AND 3 THEN 'Podio'
        WHEN positionOrder BETWEEN 4 AND 10 THEN 'Puntos'
        ELSE 'Fuera de puntos'
    END AS clasificacion
FROM results;


/*
Parte II - Automatización
*/

-- 1. Create a view that translates race statuses into Spanish.

CREATE OR REPLACE VIEW estado_carrera_es AS
SELECT statusId,
    CASE 
        WHEN status = 'Finished' THEN 'Finalizado'
        WHEN status = 'Disqualified' THEN 'Descalificado'
        WHEN status = 'Accident' THEN 'Accidente'
        WHEN status = 'Collision' THEN 'Colisión'
        WHEN status = 'Engine' THEN 'Fallo de motor'
        WHEN status = 'Gearbox' THEN 'Fallo de caja de cambios'
        WHEN status = 'Hydraulics' THEN 'Fallo hidráulico'
        WHEN status = 'Electrical' THEN 'Fallo eléctrico'
        WHEN status = 'Spun off' THEN 'Salida de pista'
        ELSE 'Otro'
    END AS estado_espanol
FROM status;

-- 2. Create a procedure that calculates the number of wins for a team in a given year.

DELIMITER //
CREATE PROCEDURE victorias_por_equipo(IN equipo_id INT, IN anio INT)
BEGIN
    SELECT constructors.name AS equipo, COUNT(*) AS victorias
    FROM results
    JOIN races ON results.raceId = races.raceId
    JOIN constructors ON results.constructorId = constructors.constructorId
    WHERE results.position = 1 
      AND constructors.constructorId = equipo_id
      AND races.year = anio
    GROUP BY constructors.name;
END //
DELIMITER ;