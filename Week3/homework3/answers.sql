SELECT * FROM thinking-land-410514.ny_taxi.external_green_taxi limit 10;

SELECT DISTINCT(PULocationID)
FROM thinking-land-410514.ny_taxi.external_green_taxi;

SELECT DISTINCT(PULocationID)
FROM thinking-land-410514.ny_taxi.external_green_taxi;

SELECT  count(1)
FROM thinking-land-410514.ny_taxi.green_taxi where fare_amount = 0;

ALTER TABLE thinking-land-410514.ny_taxi.green_taxi
ADD COLUMN lpep_pickup_datetime_timestamp TIMESTAMP;


update thinking-land-410514.ny_taxi.green_taxi
set lpep_pickup_datetime_timestamp = TIMESTAMP_MICROS(cast(lpep_pickup_datetime/1000 as INT64)) where true;

CREATE OR REPLACE TABLE thinking-land-410514.ny_taxi.green_taxi_partitoned_clustered
PARTITION BY DATE(lpep_pickup_datetime_timestamp)
CLUSTER BY PUlocationID AS
SELECT * FROM thinking-land-410514.ny_taxi.green_taxi;

SELECT distinct(PULocationID) FROM thinking-land-410514.ny_taxi.green_taxi
WHERE DATE(lpep_pickup_datetime_timestamp) BETWEEN '2022-06-01' AND '2022-06-30'

SELECT distinct(PULocationID) FROM thinking-land-410514.ny_taxi.green_taxi_partitoned_clustered
WHERE DATE(lpep_pickup_datetime_timestamp) BETWEEN '2022-06-01' AND '2022-06-30'