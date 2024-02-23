CREATE TABLE  `thinking-land-410514.trips_data_all.green_tripdata` as
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_green_trips_2019`; 

CREATE TABLE  `thinking-land-410514.trips_data_all.yellow_tripdata` as
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2019`;

insert into  `thinking-land-410514.trips_data_all.green_tripdata` 
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_green_trips_2020` ;


insert into  `thinking-land-410514.trips_data_all.yellow_tripdata` 
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2020`; 

  -- Fixes yellow table schema
ALTER TABLE `thinking-land-410514.trips_data_all.yellow_tripdata`
  RENAME COLUMN vendor_id TO VendorID;
ALTER TABLE `thinking-land-410514.trips_data_all.yellow_tripdata`
  RENAME COLUMN pickup_datetime TO tpep_pickup_datetime;
ALTER TABLE `thinking-land-410514.trips_data_all.yellow_tripdata`
  RENAME COLUMN dropoff_datetime TO tpep_dropoff_datetime;
ALTER TABLE `thinking-land-410514.trips_data_all.yellow_tripdata`
  RENAME COLUMN rate_code TO RatecodeID;
ALTER TABLE `thinking-land-410514.trips_data_all.yellow_tripdata`
  RENAME COLUMN imp_surcharge TO improvement_surcharge;
ALTER TABLE `thinking-land-410514.trips_data_all.yellow_tripdata`
  RENAME COLUMN pickup_location_id TO PULocationID;
ALTER TABLE `thinking-land-410514.trips_data_all.yellow_tripdata`
  RENAME COLUMN dropoff_location_id TO DOLocationID;

  -- Fixes green table schema
ALTER TABLE `thinking-land-410514.trips_data_all.green_tripdata`
  RENAME COLUMN vendor_id TO VendorID;
ALTER TABLE `thinking-land-410514.trips_data_all.green_tripdata`
  RENAME COLUMN pickup_datetime TO lpep_pickup_datetime;
ALTER TABLE `thinking-land-410514.trips_data_all.green_tripdata`
  RENAME COLUMN dropoff_datetime TO lpep_dropoff_datetime;
ALTER TABLE `thinking-land-410514.trips_data_all.green_tripdata`
  RENAME COLUMN rate_code TO RatecodeID;
ALTER TABLE `thinking-land-410514.trips_data_all.green_tripdata`
  RENAME COLUMN imp_surcharge TO improvement_surcharge;
ALTER TABLE `thinking-land-410514.trips_data_all.green_tripdata`
  RENAME COLUMN pickup_location_id TO PULocationID;
ALTER TABLE `thinking-land-410514.trips_data_all.green_tripdata`
  RENAME COLUMN dropoff_location_id TO DOLocationID;

CREATE OR REPLACE EXTERNAL TABLE `thinking-land-410514.trips_data_all.external_fhv_tripdata` 
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://mage-zoomcamp-thinking-land/fhv/fhv_tripdata_2019-*.parquet']
);

CREATE OR REPLACE TABLE thinking-land-410514.trips_data_all.fhv_tripdata AS
SELECT *	
FROM thinking-land-410514.trips_data_all.external_fhv_tripdata