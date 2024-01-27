# Introduction to docker

- docker build -t test:pandas .
- docker run -it test:pandas

# NY Taxi data to Postgres

- docker network create pg-network
- docker volume create --name postgres_vol_local -d local

- docker run -it \
 -e POSTGRES_USER="root" \
 -e POSTGRES_PASSWORD="root" \
 -e POSTGRES_DB="ny_taxi" \
 -v $(pwd)/ny_taxi_postgres_data:/var/lib/postgresql/data \
 -p 5432:5432 \
 --network=pg-network \
 --name=pg-database \
 postgres:13

- docker run -it \
 -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
 -e PGADMIN_DEFAULT_PASSWORD="root" \
  -p 8080:80 \
 --network=pg-network \
 --name=pgadmin \
 dpage/pgadmin4

# Ingest data

URL="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz"

docker run -it \
  --network=pg-network \
  taxi_ingest:v001 \
    --user=root \
    --password=root \
    --host=pg-database \
    --port=5432 \
    --db=ny_taxi \
    --table_name=yellow_taxi_trips \
    --url=${URL}
python ingest_data.py   --user=root   --password=root   --host=localhost   --port=5432   --db=ny_taxi   --table_name=green_zones   --url=${URL}


  # Docker compose

  docker-compose up
  docker-compose down