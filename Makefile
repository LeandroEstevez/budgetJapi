DB_URL=postgresql://root:budgetdb@budgetdb.cviqqzopm7zr.us-east-2.rds.amazonaws.com:5432/budgetdb
DB_URL_local=postgresql://root:budgetapidb@localhost:5432/budgetapidb?sslmode=disable

newPostgres:
	docker run --name postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=budgetapidb -d postgres:latest

postgres:
	docker start postgres

createdb:
	docker exec -it postgres createdb --username=root --owner=root budgetapidb

dropdb:
	docker exec -it postgres dropdb budgetapidb

migrateup:
	migrate -path db/migration -database "$(DB_URL_local)" -verbose up 1

migratedown:
	migrate -path db/migration -database "$(DB_URL_local)" -verbose down

.PHONY: network newPostgres postgres createdb dropdb migrateup migratedown sqlc server mock