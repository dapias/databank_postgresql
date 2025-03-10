# PostgreSQL Docker Setup

This repository contains SQL scripts for setting up a PostgreSQL database with a specific schema and tables related to a simple business model. 

## Prerequisites

- Docker
- Docker Compose

## Steps to Run

1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/dapias/databank_postgresql
   cd databank_postgresql

2. Run the Docker Compose command:
   ```bash
   docker-compose up -d
   
3. To verify the setup, connect to the PostgreSQL container:
   ```bash
   docker exec -it my_postgres_db psql -U myuser -d HandelsU

4. List the schema
   ```sql
   HandelsU=# \dn

5. List the tables in the ```dbo''' schema
   ```sql
   HandelsU=# \dt dbo.*


