CREATE TABLE "users" (
  "username" varchar PRIMARY KEY,
  "hashed_password" varchar NOT NULL,
  "full_name" varchar NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "total_expenses" NUMERIC(9,2) NOT NULL DEFAULT 0
);

CREATE TABLE "entries" (
  "id" SERIAL PRIMARY KEY,
  "owner" varchar NOT NULL,
  "name" varchar NOT NULL,
  "due_date" timestamptz NOT NULL,
  "amount" NUMERIC(9,2) NOT NULL DEFAULT 0,
  "category" varchar
);

CREATE INDEX ON "users" ("username");

CREATE INDEX ON "entries" ("owner");

COMMENT ON COLUMN "entries"."amount" IS 'must be positive';

ALTER TABLE "entries" ADD FOREIGN KEY ("owner") REFERENCES "users" ("username")