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
 -v postgres_vol_local:/var/lib/postgresql/data \
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