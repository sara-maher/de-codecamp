SELECT * FROM thinking-land-410514.ny_taxi.external_green_taxi limit 10;

SELECT DISTINCT(PULocationID)
FROM thinking-land-410514.ny_taxi.external_green_taxi;

SELECT DISTINCT(PULocationID)
FROM thinking-land-410514.ny_taxi.external_green_taxi;

SELECT  count(1)
FROM thinking-land-410514.ny_taxi.green_taxi where fare_amount = 0;

CREATE OR REPLACE TABLE thinking-land-410514.ny_taxi.green_taxi_partitoned_clustered
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PUlocationID AS
SELECT * FROM thinking-land-410514.ny_taxi.external_green_taxi;
