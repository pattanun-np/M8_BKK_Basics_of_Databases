FROM alpine:3.19 AS downloader

RUN apk add --no-cache curl tar && \
    curl -L https://downloads.mysql.com/docs/sakila-db.tar.gz -o /tmp/sakila-db.tar.gz && \
    tar -xzf /tmp/sakila-db.tar.gz -C /tmp

FROM mysql:8.0

ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=sakila

COPY --from=downloader /tmp/sakila-db/sakila-schema.sql /docker-entrypoint-initdb.d/01-sakila-schema.sql
COPY --from=downloader /tmp/sakila-db/sakila-data.sql /docker-entrypoint-initdb.d/02-sakila-data.sql

EXPOSE 3306
