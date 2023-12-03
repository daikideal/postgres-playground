FROM postgres:16.1

# postgresの公式イメージを使用する場合、指定が必須となる
ENV POSTGRES_PASSWORD=password

EXPOSE 5432
