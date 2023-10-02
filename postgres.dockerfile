FROM postgres:15.1-alpine

LABEL author="Mariany Ferreira da Silva"
LABEL description="Postgres Image for Data warehouse for BI Specialization"
LABEL version="1.0"

COPY *.sql /docker-entrypoint-initdb.d/